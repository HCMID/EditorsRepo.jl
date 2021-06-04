
"""Compose an edition of normalized tokens.
Optionally, filter by a URN.

$(SIGNATURES)
"""
function normtokens(repo; urn)
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

"""Collect text from a list of passages for a text passage identified by URN.
The URN should either match a citable node, or be a containing node
for one or more citable nodes.  Ranges URNs are not supported.
"""    
function nodetext(psgs, urn)
    generalized = dropversion(urn)
    filtered = filter(cn -> urncontains(generalized, dropversion(cn.urn)), psgs)
    dropreff = filter(cn -> ! isref(cn.urn), filtered)
    
	if length(dropreff) > 0
        content = collect(map(n -> n.text, dropreff))
        join(content, "\n")
		#filtered[1].text
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