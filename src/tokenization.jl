
"""Compute a list of `OrthographicToken`s based on the normalized edition of all texts in the repository.
$(SIGNATURES)
"""
function tokencorpus(r::EditingRepository)
       corpora = []

       normed = normalizedcorpus(r)
       for u in texturns(r)
              tokenlist = []
              #ortho = orthography(r, u)
              #bldr = normalizedbuilder(r, u)

              #fname = joinpath(editionsdir(r), filename(r, u))
              #archival = readcitable(fname, u, o2converter(r, u), FileReader)
              #normalized = map(cn -> edited(bldr, cn), archival.passages)
              #for t in map(cn -> cn.text, normalized)
              #=
              for cn in normalized
                     tokensinpassage = tokenize(cn.text, ortho) #, exemplar = "tokens")
                     tokenpassages = passages_for_tokens(tokensinpassage, cn.urn)
                     push!(tokenlist, tokenpassages)
              end
              =#
              flattokens = tokenlist |> Iterators.flatten |> collect
              push!(corpora, flattokens)
       end
       rslt = CitablePassage[]
       rslt = corpora |> Iterators.flatten |> collect
       CitableTextCorpus(rslt)
end

"""Create a list of `CitablePassage`s from a list of `OrthographicToken`s 
and a passage URN.

$(SIGNATURES)

Passage URNs are extended with an additional level of citation for the individual
token.  This citation tier is made up of sequential numbers for lexical tokens,
and token number + a character for other kinds of tokens (`1a`, `1b`, etc.).
"""
function passages_for_tokens(tkns::Vector{OrthographicToken}, urn::CtsUrn)
    CitablePassages = []
    n1 = 0 # Int value before 1
    n2 = 96 # Char value before 'a'
    for tkn in tkns
        if tkn.tokencategory == Orthography.LexicalToken()
            n1 = n1 + 1
            n2 = 96
            u = CtsUrn(string(urn.urn, ".", n1))
            push!(CitablePassages, CitablePassage(u, tkn.text))
            
        else
            n2 = n2 + 1
            u = CtsUrn(string(urn.urn, ".", n1, Char(n2)))
            push!(CitablePassages, CitablePassage(u, tkn.text))
           
        end
    end
    CitablePassages
end


"""For a single token citable as a `CitablePassage`, find its
token class and determine if it is orthographically valid.
$(SIGNATURES)
Returns a tuple of a token type and a boolean value.
"""
function tokenanalysis(r::EditingRepository, cn::CitablePassage)
    queryurn = dropversion(cn.urn) |> droppassage
    ortho = orthography(r, queryurn)
    ttype = tokenize(cn.text, ortho)[1].tokencategory
    (ttype, validstring(cn.text, ortho))
end