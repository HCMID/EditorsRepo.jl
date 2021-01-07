
"""
$(SIGNATURES)
Loads catalog of texts from file.
"""
function textcatalog(repo, catalogname::AbstractString, delimiter::AbstractString="|")
    filename = join([repo.root, repo.editions, catalogname], "/")
    if !isfile(filename)
        throw(ArgumentError("No text catalog file $(filename) exists."))
    end
    rawdata = CSV.File(filename, skipto=2, delim=delimiter)  |> Array
    map(row -> CatalogedText(row,delimiter), rawdata)
    #fromfile(CatalogedText, filename)
end

