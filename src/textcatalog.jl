
"""Loads catalog of texts from file as an Array of CSV Rows.
$(SIGNATURES)

# Arguments

- `repo` The editorial repository.
- `catalogname` Name of the text catalog file.
- `delimiter` Delimiting string in the text catalog.

"""
function textcatalog(repo::EditingRepository, catalogname::AbstractString, delimiter::AbstractString="|")
    filename = join([repo.root, repo.configs, catalogname], "/")
    if !isfile(filename)
        throw(ArgumentError("No text catalog file $(filename) exists."))
    end
    rawdata = CSV.File(filename, skipto=2, delim=delimiter)  |> Array
   
end

"""Create a (possibly empty) list of texts cataloged as online.

$(SIGNATURES)

# Arguments

- `repo` The editorial repository.
- `catalogname` Name of the text catalog file.
- `delimiter` Delimiting string in the text catalog.
"""
function online(repo::EditingRepository, catalogname::AbstractString, delimiter::AbstractString="|")
    catalog = textcatalog(repo, catalogname, delimiter)
    filter(row -> row.online, catalog)
end


"""Loads catalog of texts from file as a DataFrame
$(SIGNATURES)

# Arguments

- `repo` The editorial repository.
"""
function textcatalog_df(repo::EditingRepository)
	allcataloged = fromfile(CatalogedText, repo.root * "/" * repo.configs * "/catalog.cex")
	filter(row -> row.online, allcataloged)
end


"""Find CTS URNs of all texts cataloged as online.

$(SIGNATURES)
"""
function texturns(repo::EditingRepository)
    texts = textcatalog_df(repo)
    texts[:, :urn]
end