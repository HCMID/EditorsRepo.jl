
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

"""Compose HTML for verification of DSE indexing of a given surface.
$(SIGNATURES)
Juxtapose diplomatic edition of text with displayed image.
"""
function indexingaccuracy(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT)
    vizprs = surfacevizpairs(r, surf)
    corpus = diplomaticcorpus(r)
    @warn(ict)
    @warn(iiif)

end




# linky = linkedMarkdownImage(ict, img, service; ht=500, caption="Proclus")