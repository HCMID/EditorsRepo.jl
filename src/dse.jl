"""Create a single composite list of DSE data.
$(SIGNATURES)
"""
function dsetriples(repo::EditingRepository; strict = true)
    dsecollections = []       
    for filename in dsefiles(repo)
        push!(dsecollections, fromcex(filename, DSECollection, FileReader, strict = strict))
    end
    dsecollections  |> Iterators.flatten |> Iterators.flatten |> collect
end

"""File full paths to all `.cex` files in the DSE directory.
$(SIGNATURES)
"""
function dsefiles(repo::EditingRepository)
    fullpath = dsedir(repo) |> readdir
    fnames = filter(f -> endswith(f, "cex"), fullpath) 
    map(f -> joinpath(dsedir(repo), f) , fnames)
end


"""
$(SIGNATURES)
Compute list of unique surfaces in DSE records.
"""
function surfaces(repo::EditingRepository; strict = true)
    urnvals = map(trip -> trip.surface, dsetriples(repo, strict = strict))
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> Cite2Urn
end


"""
$(SIGNATURES)
Compute list of unique images in DSE records.
"""
function images(repo::EditingRepository; strict = true)
    urnvals = map(trip -> trip.image, dsetriples(repo, strict = strict)) .|> dropsubref
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> Cite2Urn
end


"""
$(SIGNATURES)
Compute list of unique surfaces in DSE records.
"""
function passages(repo::EditingRepository; strict = true)
    urnvals = map(trip -> trip.passage, dsetriples(repo, strict = strict))
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> CtsUrn
end

"""
$(SIGNATURES)
Compute list of passages in DSE records for a given surface.
"""
function passageurnsforsurface(r::EditingRepository, u::Cite2Urn; strict = true)
    triples = filter(tr -> urncontains(u, tr.surface), dsetriples(r, strict = strict))
    map(tr -> tr.passage, triples)
end

"""
$(SIGNATURES)
Assemble citable passages in diplomatic edition for a given surface.
"""
function diplomaticforsurface(r::EditingRepository, u::Cite2Urn; strict = true)
    corpus = diplomaticcorpus(r)
    rslts = []
    for psgurn in passageurnsforsurface(r, u, strict = strict)
        @debug("Compare $(psgurn) ")
        citables = filter(n -> urncontains(psgurn, urn(n)), corpus.passages)
        push!(rslts, citables)
    end
    rslts |> Iterators.flatten |> collect
end


"""
$(SIGNATURES)
Assemble citable passages in normalized edition for a given surface.
"""
function normalizedforsurface(r::EditingRepository, u::Cite2Urn; strict = true)
    corpus = normalizedcorpus(r)
    rslts = []
    for psgurn in passageurnsforsurface(r, u, strict = strict)
        @debug("Compare $(psgurn) ")
        citables = filter(n -> urncontains(psgurn, urn(n)), corpus.passages)
        push!(rslts, citables)
    end
    rslts |> Iterators.flatten |> collect
end

function tokencorpus(r::EditingRepository)
    
end


function tokensforsurface(r::EditingRepository, u::Cite2Urn; strict = true)
    corpus = tokencorpus(r)
    rslts = []
    for psgurn in passageurnsforsurface(r, u, strict = strict)
        @debug("Compare $(psgurn) ")
        citables = filter(n -> urncontains(psgurn, urn(n)), corpus.passages)
        push!(rslts, citables)
    end
    rslts |> Iterators.flatten |> collect
end

"""
$(SIGNATURES)
Compute list of images in DSE records for a given passage.
"""
function imagesforpassage(r::EditingRepository, u::CtsUrn; strict = true)
    triples = filter(tr -> urncontains(u, tr.passage), dsetriples(r, strict = strict))
    if isempty(triples)
        @warn("No DSE records found for $(u)")
    elseif length(triples) > 1
        @warn("$(length(triples)) DSE records found for $(u)")
    end
    map(tr -> tr.image, triples)
end


"""Find pairs of text passage and image for a surface.
$(SIGNATURES)
"""
function surfacevizpairs(r::EditingRepository, surf::Cite2Urn; strict = true)
    triples = filter(tr -> urncontains(surf, tr.surface), dsetriples(r, strict = strict))
    map(tr -> (tr.passage, tr.image), triples)
end