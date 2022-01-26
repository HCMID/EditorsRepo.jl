
"""
$(SIGNATURES)
List entries with `missing` values in citation configuration.
"""
function missingcitation(repo::EditingRepository)
	arr = CSV.File(repo.configs * "/citation.cex", skipto=2, delim="|", 
	quotechar='&', escapechar='&') |> Array
	urns = map(row -> CtsUrn(row[1]), arr)
	files = map(row -> row[2], arr)
	ohco2s = map(row -> row[3], arr)
	dipls = map(row -> row[4], arr)
	norms = map(row -> row[5], arr)
	orthos = map(row -> row[6], arr)

	df = DataFrame(urn = urns, file = files, 
	o2converter = ohco2s, diplomatic = dipls,
	normalized = norms, orthography = orthos)
	missinglist = []
	nrows, ncols = size(df)
	for row in 1:nrows
		for col in 1:ncols
		  if ismissing(df[row,col])
			push!(missinglist, "$(df[row,:urn].urn) is missing entry for $(names(df)[col]).")
		  end
		end
  	end
  	missinglist
end
