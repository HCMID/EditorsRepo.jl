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