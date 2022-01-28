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
    corpora = CitableTextCorpus[]
    archive = archivalcorpus(r) 
    for u in texturns(r)
        diplbuilder = diplomaticbuilder(r, u)
        archivecorpus = filter(p -> urncontains(u, p.urn),  archive.passages) |> CitableTextCorpus
        push!(corpora, edited(diplbuilder, archivecorpus))
   
    end
    map(c -> c.passages, corpora) |> Iterators.flatten |> collect |> CitableTextCorpus
end


""" 
Create normalized editions of all texts in a repo.

$(SIGNATURES)
"""
function normalizedcorpus(r::EditingRepository)
    corpora = CitableTextCorpus[]
    archive = archivalcorpus(r) 
    for u in texturns(r)
        builder = normalizedbuilder(r, u)
        archivecorpus = filter(p -> urncontains(u, p.urn),  archive.passages) |> CitableTextCorpus
        push!(corpora, edited(builder, archivecorpus))
    end
    corpora |> Iterators.flatten |> collect |> CitableTextCorpus
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
