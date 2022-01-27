
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