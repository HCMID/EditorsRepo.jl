
LEXICAL_TOKEN = Orthography.LexicalToken()
PUNCTUATION = Orthography.PunctuationToken()

"""Format an orthographic token in HTML.
$(SIGNATURES)
Adds appropriate whitespace to non-punctuation tokens,
and wraps orthographically failed tokens in `span` element.
"""
function htmltoken(psg::CitablePassage, tokentype, ok::Bool)
    if ! ok
        " <span class=\"invalidtoken\">" * psg.text * "</span>"
    else
        tokentype == PUNCTUATION ? psg.text : " " * psg.text
    end
end

function htmltoken(ct::CitableToken, ok::Bool)
    htmltoken(ct.passage, ct.tokentype, ok)
end

"""Compose HTML for verification of accuracy of DSE indexing of a given surface.
$(SIGNATURES)
Juxtapose diplomatic edition of text with displayed image.
"""
function indexingaccuracy_md(r::EditingRepository, surf::Cite2Urn; 
    iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, width = 500, strict = true)

    vizprs = surfacevizpairs(r, surf, strict = strict)
    txtlist = map(vizprs) do pr
        pr[1]|> droppassage
    end |> unique

    corpus = diplomaticcorpus(r)
    
    textlines = []
    for txt in txtlist
        push!(textlines, string("## " , txt, "\n"))
        currpassages = filter(pr -> droppassage(pr[1]) == txt, vizprs)
        for pr in currpassages
            # get text contents
            psgs = filter(psg -> urncontains(pr[1], psg.urn), corpus.passages)
            psgtext = if isempty(psgs)
                @warn("No passages match indexed URN $(pr[1])")
                ""
            elseif length(psgs) != 1
                @warn("Found $(length(psgs)) passages matching indexed URN $(pr[1])")
                @warn("Type of first is $(typeof(psgs[1]))")
                textcontent = map(p -> p.text, psgs)
                join(textcontent, "\n")
            else
                psgs[1].text
            end

            mdtext = string("**", passagecomponent(pr[1]), "** ", psgtext, "\n" )
            # get image markup
            mdimg = linkedMarkdownImage(ict, pr[2], iiif; w=width, caption="image")
            push!(textlines, "---\n\n" * mdimg * "\n\n" * mdtext )
        end
    end
    join(textlines, "\n")
    
end

"""Compose Markdown for verification of completeness of DSE indexing of a given surface.
$(SIGNATURES)
"""
function indexingcompleteness_md(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, width = 150, strict = true)
    triples = dsetriples(r, strict = strict)
    surfacetriples = filter(row -> urncontains(surf, row.surface), triples)
    images = map(tr -> tr.image, surfacetriples)
    ictlink = ict * "urn=" * join(images, "&urn=")
    imgmd = markdownImage(dropsubref(images[1]), iiif; w = width)
    string("[", imgmd, "](", ictlink, ")")
end


"""Compose Markdown for verification of orthographic validity.
$(SIGNATURES)
"""
function orthographicvalidity_html(r::EditingRepository, surf::Cite2Urn; strict = true)
    tkns = analyzedtokens(r)
    catalog = textcatalog(r)

    psgs = passageurnsforsurface(r, surf, strict = strict)
    results = []
    for psg in psgs
        ref_urn = droppassage(psg) |> dropexemplar
        ortho = orthography(r, ref_urn)
        catentry =  filter(e -> urncontains(ref_urn, e.urn), catalog.entries)[1]

        psgurn = dropsubref(psg)
        if isrange(psgurn)
            ref1 = range_begin(psgurn)
            psgurn = addpassage(psgurn, ref1)
        end
    
        
        psgstring = [textgroup(catentry), ", <i>", work(catentry), "</i> (", version(catentry), "), ", "<b>", passagecomponent(psgurn) , "</b>: "]

        # THIS IS THE ERROR:
        matches = filter(t -> urncontains(psgurn, urn(t)),  tkns)
        for t in matches
            ok = validstring(t.passage.text, ortho)
            push!(psgstring, htmltoken(t, ok))
        end
        push!(results, "<p>" * join(psgstring) * "</p>")
    end
    join(results, "\n\n")
end