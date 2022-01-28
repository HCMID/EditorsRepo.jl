
LEXICAL_TOKEN = Orthography.LexicalToken()
PUNCTUATION = Orthography.PunctuationToken()

"""Format an orthographic token in HTML.
$(SIGNATURES)
Adds appropriate whitespace to non-punctuation tokens,
and wraps orthographically failed tokens in `span` element.
"""
function htmltoken(r::EditingRepository, tkn::CitablePassage)
    analysis = tokenanalysis(r, tkn)
    if ! analysis[2]
        " <span class=\"\">" * tkn.text * "</span>"
    else
        analysis[1] == PUNCTUATION ? tkn.text : " " * tkn.text
    end
end

"""Compose HTML for verification of accuracy of DSE indexing of a given surface.
$(SIGNATURES)
Juxtapose diplomatic edition of text with displayed image.
"""
function indexingaccuracy(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 500)
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

"""Compose HTML for verifciation of completeness of DSE indexing of a given surface.
$(SIGNATURES)
"""
function indexingcompleteness(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 150)
    triples = dsetriples(r)
    surfacetriples = filter(row -> urncontains(surf, row.surface), triples)
    images = map(tr -> tr.image, surfacetriples)
    ictlink = ict * "urn=" * join(images, "&urn=")
    imgmd = markdownImage(dropsubref(images[1]), iiif; ht = height)
    string("[", imgmd, "](", ictlink, ")")
end
