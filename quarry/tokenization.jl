

"""Create a list of `CitablePassage`s from a list of `OrthographicToken`s 
and a passage URN.

$(SIGNATURES)

Passage URNs are extended with an additional level of citation for the individual
token.  This citation tier is made up of sequential numbers for lexical tokens,
and token number + a character for other kinds of tokens (`1a`, `1b`, etc.).
"""
function passages_for_tokens(tkns, urn::CtsUrn)
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


"""Create a list of `CitablePassage`s for all lexical tokens in a list of `OrthographicToken`s 
for a given URN.

$(SIGNATURES)

Passages URNs are extended with an additional level of citation for the individual
token.  This citation tier is made up of sequential numbers for lexical tokens,
and token number + a character for other kinds of tokens (`1a`, `1b`, etc.).
"""
function lexpassages_for_tokens(tkns, urn::CtsUrn)
    CitablePassages = []
    n = 0
    for tkn in tkns
        if tkn.tokencategory == Orthography.LexicalToken()
            n = n + 1
            u = CtsUrn(string(urn.urn, ".", n))
            push!(CitablePassages, CitablePassage(u, tkn.text))
            
        else
            # Omit
        end
    end
    CitablePassages
end


"""Compose an edition of lexical tokens matching `urn`.

$(SIGNATURES)
"""
function lextokens(repo, urn)
    textconfig = citation_df(repo)  
    ortho = orthographyforurn(textconfig, urn)
    if isnothing(ortho)
        @warn("No orthography configured for $urn")
        nothing

    else
        normalized = repo |> EditorsRepo.normedpassages
        psgs = textpassages(normalized, urn)
        tknlist = []
        i = 0
        for psg in psgs
            i = i + 1
            @info("tokenizing $(psg.urn.urn) $i / $(length(psgs)) passages ")
            txt = normalized_passagetext(repo, psg.urn)
            @debug("Normalized text to $txt")
            cns = lexpassages_for_tokens(tokenize(txt, ortho), psg.urn)
            push!(tknlist, cns)
        end
        tknlist |> Iterators.flatten |> collect
    end
end

"""Compose an edition of normalized tokens matching `urn`.

$(SIGNATURES)
"""
function normalized_tokens(repo::EditingRepository, urn::CtsUrn)
    textconfig = citation_df(repo)  
    ortho = orthographyforurn(textconfig, urn)
    if isnothing(ortho)
        @warn("No orthography configured for $urn")
        nothing

    else
        normalized = repo |> EditorsRepo.normedpassages
        psgs = textpassages(normalized, urn)
        tknlist = []
        for psg in psgs
            # Set version to original!
            #nopsg = droppassage(psg.urn)
            txt = normalized_passagetext(repo, psg.urn)
            @debug("Normalized text to $txt")
            cns = passages_for_tokens(tokenize(txt, ortho), psg.urn)
            push!(tknlist, cns)
        end
        tknlist |> Iterators.flatten |> collect
    end
end





