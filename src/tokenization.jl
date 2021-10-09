"""Compose an edition of normalized tokens for allt exts in repository.

$(SIGNATURES)
"""
function normedtokens(repo)
    textconfig = citation_df(repo)  
    ## REVERSE THIS:  go from URNs in textconfig to filter texts
    # for particular orthography
#=  psgs = repo |> EditorsRepo.normedpassages

        normalizedpassages = repo |> EditorsRepo.normedpassages
        psgs = textpassages(normalizedpassages, urn)
    =#
    nothing
end

"""Create a list of `CitablePassage`s from a list of `OrthographicToken`s 
and a node URN.

$(SIGNATURES)

Node URNs are extended with an additional level of citation for the individual
token.  This citation tier is made up of sequential numbers for lexical tokens,
and token number + a character for other kinds of tokens (`1a`, `1b`, etc.).
"""
function nodesfortokens(tkns, urn::CtsUrn)
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

Node URNs are extended with an additional level of citation for the individual
token.  This citation tier is made up of sequential numbers for lexical tokens,
and token number + a character for other kinds of tokens (`1a`, `1b`, etc.).
"""
function lexnodesfortokens(tkns, urn::CtsUrn)
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
            txt = normednodetext(repo, psg.urn)
            @debug("Normalized text to $txt")
            cns = lexnodesfortokens(ortho.tokenizer(txt), psg.urn)
            push!(tknlist, cns)
        end
        tknlist |> Iterators.flatten |> collect
    end
end

"""Compose an edition of normalized tokens matching `urn`.

$(SIGNATURES)
"""
function normedtokens(repo::EditingRepository, urn::CtsUrn)
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
            txt = normednodetext(repo, psg.urn)
            @debug("Normalized text to $txt")
            cns = nodesfortokens(ortho.tokenizer(txt), psg.urn)
            push!(tknlist, cns)
        end
        tknlist |> Iterators.flatten |> collect
    end
end





"""Collect diplomatic text for a single text passage identified by URN.
The URN should either match a citable node, or be a containing node
for one or more citable nodes.  Ranges URNs are not supported.

$(SIGNATURES)
"""
function diplnodetext(repo, urn)
	diplomaticpassages = repo |> EditorsRepo.diplpassages
    nodetext(diplomaticpassages, urn)
end


"""Collect diplomatic text for a text passage identified by URN.
The URN should either match a citable node, or be a containing node
for one or more citable nodes.  Ranges URNs are not supported.

$(SIGNATURES)
"""
function normednodetext(repo, urn)
	normalizedpassages = repo |> EditorsRepo.normedpassages
    nodetext(normalizedpassages, urn)
end

"""Select from a list passages those URN matching a given URN,
and omit "ref" passages conventionally used for non-text content.

$(SIGNATURES)
"""
function textpassages(psgs, urn)
    generalized = CitableText.dropversion(urn)
    filtered = filter(cn -> CitableText.urncontains(generalized, CitableText.dropversion(cn.urn)), psgs)
    dropreff = filter(cn -> ! isref(cn.urn), filtered)
    dropreff 
end

"""Collect text from a list of passages for a text passage identified by URN.
The URN should either match a citable node, or be a containing node
for one or more citable nodes.  Ranges URNs are not supported.

$(SIGNATURES)    
"""    
function nodetext(psgs, urn)
    psgs = textpassages(psgs, urn)
	if length(psgs) > 0
        content = collect(map(n -> n.text, psgs))
        join(content, "\n")
	else 
		""
    end
end



"""True if last component of CTS URN passage is "ref".
MID convention is to exclude elements, like notes on HMT scholia,  
with this identifier.

$(SIGNATURES)
"""
function isref(urn::CtsUrn)::Bool
    passageparts(urn)[end] == "ref"
end