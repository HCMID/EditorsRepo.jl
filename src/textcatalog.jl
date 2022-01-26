
"""Read a `TextCatalogCollection` for a repository.
$(SIGNATURES)
"""
function textcatalog(repo::EditingRepository; catalogname::AbstractString = "catalog.cex", delimiter::AbstractString="|")
    catfile = joinpath(configdir(repo), catalogname)
    fromcex(catfile, TextCatalogCollection, FileReader, delimiter = delimiter)
end


"""Find CTS URNs of all texts cataloged as online.

$(SIGNATURES)
"""
function texturns(repo::EditingRepository)
    cat = textcatalog(repo)
    map(e -> urn(e), cat)
end