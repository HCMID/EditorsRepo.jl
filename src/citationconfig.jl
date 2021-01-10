"""
$(SIGNATURES)
Read citation configuration into a DataFrame.
"""
function citation_df(repo::EditingRepository)
	arr = CSV.File(repo.root * "/" * repo.configs * "/citation.cex", skipto=2, delim="|") |> Array
	urns = map(row -> CtsUrn(row[1]), arr)
	files = map(row -> row[2], arr)
	fnctns = map(row -> eval(Meta.parse(row[3])), arr)
	DataFrame(urn = urns, file = files, converter = fnctns)
end