
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

"""Compose HTML for verification of accuracy of DSE indexing of a given surface.
$(SIGNATURES)
Juxtapose diplomatic edition of text with displayed image.
"""
function indexingaccuracy_html(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 500)
    vizprs = surfacevizpairs(r, surf)
    corpus = diplomaticcorpus(r)
    textlines = []
    for pr in vizprs
        # get text contents
        psgs = filter(psg -> urncontains(pr[1], psg.urn), corpus.passages)
        psgtext = if isempty(psgs)
            @warn("No passages match indexed URN $(pr[1])")
            ""
        elseif length(psgs) != 1
            @warn("Found $(length(psgs)) passages matching indexed URN $(pr[1])")
            textconent = map(p -> p.text, psgs)
            join(textcontent, "\n")
        else
            psgs[1].text
        end

        mdtext = string("**", passagecomponent(pr[1]), "** ", psgtext, "\n" )
        # get image markup
        mdimg = linkedMarkdownImage(ict, pr[2], iiif; ht=height, caption="image")
        push!(textlines, "---\n\n" * mdimg * "\n\n" * mdtext )
    end
    join(textlines, "\n")
    
end

"""Compose HTML for verification of completeness of DSE indexing of a given surface.
$(SIGNATURES)
"""
function indexingcompleteness_html(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 150)
    triples = dsetriples(r)
    surfacetriples = filter(row -> urncontains(surf, row.surface), triples)
    images = map(tr -> tr.image, surfacetriples)
    ictlink = ict * "urn=" * join(images, "&urn=")
    imgmd = markdownImage(dropsubref(images[1]), iiif; ht = height)
    string("[", imgmd, "](", ictlink, ")")
end


"""Compose HTML for verification of orthographic validity.
$(SIGNATURES)
"""
function orthographicvalidity_html(r::EditingRepository, surf::Cite2Urn)
    tkns = analyzedtokens(r)
    psgs = passageurnsforsurface(r, surf)
    results = []
    for psg in psgs
        ref_urn = droppassage(psg) |> dropexemplar
        ortho = orthography(r, ref_urn)

        psgurn = dropsubref(psg)
        if CitableText.isrange(psgurn)
            ref1 = range_begin(psgurn)
            psgurn = addpassage(psgurn, ref1)
        end
    
        psgstring = ["<b>", passagecomponent(psgurn) , "</b>: "]
        matchingpairs = filter(pr -> urncontains(psgurn, pr[1].urn),  tkns)
        for pr in matchingpairs
            ok = validstring(pr[1].text, ortho)
            push!(psgstring, htmltoken(pr[1], pr[2], ok))
        end
        push!(results, join(psgstring))
    end
    join(results, "\n\n")
end