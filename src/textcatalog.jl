
"""
$(SIGNATURES)
Loads catalog of texts from file as an Array of CSV Rows.
"""
function textcatalog(repo, catalogname::AbstractString, delimiter::AbstractString="|")
    filename = join([repo.root, repo.configs, catalogname], "/")
    if !isfile(filename)
        throw(ArgumentError("No text catalog file $(filename) exists."))
    end
    rawdata = CSV.File(filename, skipto=2, delim=delimiter)  |> Array
   
end


function online(repo, catalogname::AbstractString, delimiter::AbstractString="|")
    catalog = textcatalog(repo, catalogname, delimiter)
    filter(row -> row.online, catalog)
end