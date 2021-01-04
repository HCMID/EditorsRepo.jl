
"""
$(SIGNATURES)
Loads catalog of texts from file.
"""
function textcatalog(repo, catalogname::AbstractString, delimiter::AbstractString)
    fname = join([repo.root, repo.editions, catalogname], "/")
    fname
end