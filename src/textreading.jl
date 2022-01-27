""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository)
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        fname = joinpath(editionsdir(r), filename(r, u))
        c = readcitable(fname, u, o2converter(r, u), FileReader)
        c.passages
        # Run through textpassages selector
        revised = textpassages(c, u)
        push!(corpora, revised)
    end
    map(c -> c.passages, corpora) |> vcat |> Iterators.flatten |> collect |> CitableTextCorpus 
end

""" 
Create diplomatic editions of all texts in a repo.

$(SIGNATURES)
"""
function diplomaticcorpus(r::EditingRepository)
    psgs = []
    for u in texturns(r)
        fname = joinpath(editionsdir(r), filename(r, u))
        c = readcitable(fname, u, o2converter(r, u), FileReader)
        diplbuilder = diplomaticbuilder(r, u)
        diplpsgs = map(cn -> edited_passage(diplbuilder, cn), c.passages)
        push!(psgs, diplpsgs)
    end
    psgs |> Iterators.flatten |> collect |> CitableTextCorpus
end


""" 
Create normalized editions of all texts in a repo.

$(SIGNATURES)
"""
function normalizedcorpus(r::EditingRepository)
    psgs = []
    for u in texturns(r)
        fname = joinpath(editionsdir(r), filename(r, u))
        c = readcitable(fname, u, o2converter(r, u), FileReader)
        bldr = normalizedbuilder(r, u)
        normedpsgs = map(cn -> edited_passage(bldr, cn), c.passages)
        push!(psgs, normedpsgs)
    end
    psgs |> Iterators.flatten |> collect |> CitableTextCorpus
end



"""Select from a list passages those URN matching a given URN,
and omit "ref" passages conventionally used for non-text content.

$(SIGNATURES)
"""
function textpassages(c::CitableTextCorpus, u::CtsUrn)
    generalized = CitableText.dropversion(u)
    filtered = filter(cn -> urncontains(generalized, cn.urn), c.passages)
    filter(cn -> ! isref(cn.urn), filtered) |> CitableTextCorpus 
end



"""True if last component of CTS URN passage is "ref".
MID convention is to exclude elements, like notes on HMT scholia,  
with this identifier.

$(SIGNATURES)
"""
function isref(urn::CtsUrn)::Bool
    passageparts(urn)[end] == "ref"
end
