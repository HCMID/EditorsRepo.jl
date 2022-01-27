
LEXICAL_TOKEN = Orthography.LexicalToken()
PUNCTUATION = Orthography.PunctuationToken()

"""Format an orthographic token in HTML.
$(SIGNATURES)
Adds appropriate whitespace to non-punctuation tokens,
and wraps orthographically failed tokens in `span` element.
"""
function htmltoken(r::EditingRepository, tkn::OrthographicToken)

end