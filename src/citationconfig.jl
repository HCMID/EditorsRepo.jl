"""
$(SIGNATURES)
Read citation configuration into a DataFrame.
"""
function citation_df(repo::EditingRepository)
	arr = CSV.File(repo.root * "/" * repo.configs * "/citation.cex", skipto=2, delim="|") |> Array
	urns = map(row -> CtsUrn(row[1]), arr)
	files = map(row -> row[2], arr)
	ohco2s = map(row -> eval(Meta.parse(row[3])), arr)
	dipls = map(row -> eval(Meta.parse(row[4])), arr)
	norms = map(row -> eval(Meta.parse(row[5])), arr)
	orthos = map(row -> eval(Meta.parse(row[6])), arr)

	DataFrame(urn = urns, file = files, 
	o2converter = ohco2s, diplomatic = dipls,
	normalized = norms, orthography = orthos)
end