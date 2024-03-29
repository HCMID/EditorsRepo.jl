""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository; skipref = true)
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        namelist = []
        for fname in fileswithin(r, u)
            fullpath = joinpath(editionsdir(r), fname)
            c = readcitable(fullpath, u, o2converter(r, u), FileReader)
            c.passages
            # Run through textpassages selector
            revised = textpassages(c, u, skipref = skipref)
            push!(corpora, revised)
        end
    end
    map(c -> c.passages, corpora) |> vcat |> Iterators.flatten |> collect |> CitableTextCorpus 
end

""" 
Create diplomatic editions of all texts in a repo.

$(SIGNATURES)
"""
function diplomaticcorpus(r::EditingRepository; sourcecorpus = nothing)
    archive = isnothing(sourcecorpus) ? archivalcorpus(r)  : sourcecorpus
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        diplbuilder = diplomaticbuilder(r, u)
        archivecorpus = filter(p -> urncontains(u, p.urn),  archive.passages) |> CitableTextCorpus

        versionid = workparts(u)[3]
        push!(corpora, edited(diplbuilder, archivecorpus, edition = versionid, exemplar = "diplomatic"))
   
    end
    map(c -> c.passages, corpora) |> Iterators.flatten |> collect |> CitableTextCorpus
end


""" 
Create normalized editions of all texts in a repo.

$(SIGNATURES)
"""
function normalizedcorpus(r::EditingRepository; sourcecorpus = nothing)
    archive = isnothing(sourcecorpus) ? archivalcorpus(r)  : sourcecorpus
    
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        builder = normalizedbuilder(r, u)
        archivecorpus = filter(p -> urncontains(u, p.urn),  archive.passages) |> CitableTextCorpus
        versionid = workparts(u)[3]
        push!(corpora, edited(builder, archivecorpus, edition = versionid, exemplar = "normalized"))
    end
    corpora |> Iterators.flatten |> collect |> CitableTextCorpus
end



"""Select from a corpus those matching a given URN,
omitting `ref` passages conventionally used for non-textual metadata.

$(SIGNATURES)
"""
function textpassages(c::CitableTextCorpus, u::CtsUrn; skipref = true)
    generalized = CitableText.dropversion(u)
    filtered = filter(cn -> urncontains(generalized, cn.urn), c.passages)
    skipref ? filter(cn -> ! isref(cn.urn), filtered) |> CitableTextCorpus  : filtered |> CitableTextCorpus
end

"""True if last component of CTS URN passage is "ref".
MID convention is to exclude elements, like notes on HMT scholia,  
with this identifier.

$(SIGNATURES)
"""
function isref(urn::CtsUrn)::Bool
    passageparts(urn)[end] == "ref"
end
