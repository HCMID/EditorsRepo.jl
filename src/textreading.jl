""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository)
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        # get edition builder for u
        fname = joinpath(editionsdir(r), filename(r, u))
        c = readcitable(fname, u, o2converter(r, u), FileReader)
        push!(corpora, c)
    end
    map(c -> c.passages, corpora) |> vcat |> Iterators.flatten |> collect |> CitableTextCorpus 
end

"""Read source for text identified by `u`.

$(SIGNATURES)    
"""
function textsourceforurn(repo::EditingRepository, u::CtsUrn)
    fname = joinpath(editionsdir(repo), filename(repo, u))
    # concat contents of files matching u
    read(fname, String)
end


"""
Compose an array of `CitablePassage`s for a diplomatic reading of a text identified by CtsUrn."

$(SIGNATURES)
"""
function diplomatic_passages(r::EditingRepository, u::CtsUrn)
    stripped = droppassage(u)
    fname = joinpath(editionsdir(r), filename(r, stripped))
    @debug("Get diplomatic for $(stripped)")
    c = readcitable(fname, stripped, o2converter(r, stripped), FileReader)
    #o2converter(mixedrepo, u1)
    diplbuilder = diplomaticbuilder(r, stripped)
    map(cn -> edited_passage(diplbuilder, cn), c.passages)
end

"""Collect diplomatic text for a single text passage identified by URN.
The URN should either match a citable passage, or be a containing passage
for one or more citable passage.  Ranges URNs are not supported.

$(SIGNATURES)
"""
function diplomatic_passagetext(r::EditingRepository, u::CtsUrn)
	diplpassages = diplomatic_passages(r, u)
    passage_text(diplpassages, u)
end



"""
Compose an array of `CitablePassage`s for a normalized reading of a text identified by CtsUrn.

$(SIGNATURES)	
"""
function normalized_passages(r::EditingRepository, u::CtsUrn)
    stripped = droppassage(u)
    fname = joinpath(editionsdir(r), filename(r, stripped))
    c = readcitable(fname, stripped, o2converter(r, stripped), FileReader)
    normbuilder = normalizedbuilder(r, stripped)
    map(cn -> edited_passage(normbuilder, cn), c.passages)
end


"""Collect diplomatic text for a single text passage identified by URN.
The URN should either match a citable passage, or be a containing passage
for one or more citable passage.  Ranges URNs are not supported.

$(SIGNATURES)
"""
function normalized_passagetext(r::EditingRepository, u::CtsUrn)
	normpassages = normalized_passages(r, u)
    passage_text(normpassages, u)
end

"""Select from a list passages those URN matching a given URN,
and omit "ref" passages conventionally used for non-text content.

$(SIGNATURES)
"""
function textpassages(psgs, urn)
    generalized = CitableText.dropversion(urn)
    filtered = filter(cn -> urncontains(generalized, cn.urn), psgs)
    dropreff = filter(cn -> ! isref(cn.urn), filtered)
    dropreff 
end



"""Collect text from a list of passages for a text passage identified by URN.
The URN should either match a citable passage, or be a containing passage
for one or more citable passages.  Ranges URNs are not supported.

$(SIGNATURES)    
"""    
function passage_text(psgs::Vector{CitablePassage}, u::CtsUrn)
    psgs = textpassages(psgs, u)
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
