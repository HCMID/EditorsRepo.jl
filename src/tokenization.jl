
"""Compose an edition of normalized tokens.
Optionally, filter by a URN.

$(SIGNATURES)
"""
function normtokens(repo; urn = nothing)
    textconfig = citation_df(repo)  

    psgs = []
    if isnothing(urn)
        psgs = repo |> EditorsRepo.normedpassages
    else
        normalizedpassages = repo |> EditorsRepo.normedpassages
        psgs = textpassages(normalizedpassages, urn)
        
    end  
    tknlist = []
    for psg in psgs
        reduced = baseurn(psg.urn)
        ortho = orthographyforurn(textconfig, reduced)
        if isnothing(ortho)
            @warn("No orthography configured for $reduced")
        else
            txt = normednode(reduced, repo)
		    push!(tknlist, ortho.tokenizer(txt))
        end
    end
    tknlist
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
    filtered = filter(cn -> urncontains(generalized, CitableText.dropversion(cn.urn)), psgs)
    dropreff = filter(cn -> ! isref(cn.urn), filtered)
    dropreff 
end

"""Collect text from a list of passages for a text passage identified by URN.
The URN should either match a citable node, or be a containing node
for one or more citable nodes.  Ranges URNs are not supported.
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