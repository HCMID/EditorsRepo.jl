"""
$(SIGNATURES)
List `.cex` files in DSE directory.
"""
function dsetriples(repo::EditingRepository)
    dsecollections = []
    fullpath = dsedir(repo) |> readdir
    fnames = filter(f -> endswith(f, "cex"), fullpath)        
    for filename in map(f -> joinpath(dsedir(repo), f) , fnames)
        push!(dsecollections, fromcex(filename, DSECollection, FileReader))
    end
    map(c -> c.data, dsecollections)  |> Iterators.flatten |> collect
end


"""
$(SIGNATURES)
Compute list of unique surfaces in DSE records.
"""
function surfaces(repo::EditingRepository)
    urnvals = map(trip -> trip.surface, dsetriples(repo))
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> Cite2Urn
end


"""
$(SIGNATURES)
Compute list of unique images in DSE records.
"""
function images(repo::EditingRepository)
    urnvals = map(trip -> trip.image, dsetriples(repo)) .|> dropsubref
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> Cite2Urn
end


"""
$(SIGNATURES)
Compute list of unique surfaces in DSE records.
"""
function passages(repo::EditingRepository)
    urnvals = map(trip -> trip.passage, dsetriples(repo))
    # why is unique broken on Cite2Urns when `isequal` works correctly?
    map(u -> string(u), urnvals) |> unique .|> CtsUrn
end

"""
$(SIGNATURES)
Compute list of passages in DSE records for a given surface.
"""
function passagesforsurface(r::EditingRepository, u::Cite2Urn)
    triples = filter(tr -> urncontains(u, tr.surface), dsetriples(r))
    map(tr -> tr.passage, triples)
end


"""
$(SIGNATURES)
Compute list of images in DSE records for a given passage.
"""
function imagesforpassage(r::EditingRepository, u::CtsUrn)
    triples = filter(tr -> urncontains(u, tr.passage), dsetriples(r))
    if isempty(triples)
        @warn("No DSE records found for $(u)")
    elseif length(triples) > 1
        @warn("$(length(triples)) DSE records found for $(u)")
    end
    map(tr -> tr.image, triples)
end