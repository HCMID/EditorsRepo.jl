"""
$(SIGNATURES)
Read citation configuration into a DataFrame.
"""
function citation_df(repo::EditingRepository)
	arr = CSV.File(repo.root * "/" * repo.configs * "/citation.cex", skipto=2, delim="|", 
	quotechar='&', escapechar='&') |> Array
	urns = map(row -> CtsUrn(row[1]), arr)
	files = map(row -> row[2], arr)

	ohco2s = map(row -> row[3], arr)
	dipls = map(row -> row[4], arr)
	norms = map(row -> row[5], arr)
	orthos = map(row -> row[6], arr)
	#=
	ohco2s = map(row -> eval(Meta.parse(row[3])), arr)
	dipls = map(row -> eval(Meta.parse(row[4])), arr)
	norms = map(row -> eval(Meta.parse(row[5])), arr)
	orthos = map(row -> eval(Meta.parse(row[6])), arr)
	=#
	DataFrame(urn = urns, file = files, 
	o2converter = ohco2s, diplomatic = dipls,
	normalized = norms, orthography = orthos)
end

"""
$(SIGNATURES)
Lookup file name in a repository for a text identified by URN.
"""
function filename(repo::EditingRepository, u)
	df = citation_df(repo)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:file]
end

"""
$(SIGNATURES)
Lookup file name in a DataFame for a text identified by URN.
"""
function filename(df, u)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:file]
end



"""
$(SIGNATURES)
Lookup ohco2 converter in a repository for a text identified by URN.
"""
function o2converter(repo::EditingRepository, u)
	df = citation_df(repo)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:o2converter]
end

"""
$(SIGNATURES)
Lookup ohco2 converter in a DataFrame for a text identified by URN.
"""
function o2converter(df, u)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:o2converter]
end


"""
$(SIGNATURES)
Lookup in a repository the builder for diplomatic edition for a text identified by URN.
"""
function diplomaticbuilder(repo::EditingRepository, u)
	df = citation_df(repo)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:diplomatic]
end

"""
$(SIGNATURES)
Lookup in a DataFrame the builder for diplomatic edition for a text identified by URN.
"""
function diplomaticbuilder(df, u)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:diplomatic]
end


"""
$(SIGNATURES)
Lookup in a repository the builder for diplomatic edition for a text identified by URN.
"""
function normalizedbuilder(repo::EditingRepository, u)
	df = citation_df(repo)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:normalized]
end

"""
$(SIGNATURES)
Lookup in a DataFrame the builder for diplomatic edition for a text identified by URN.
"""
function normalizedbuilder(df, u)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:normalized]
end


"""
$(SIGNATURES)
Lookup in a repository the orthogaraphic system for a text identified by URN.
"""
function orthography(repo::EditingRepository, u)
	df = citation_df(repo)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:orthography]
end

"""
$(SIGNATURES)
Lookup in a DataFrame the orthogaraphic system for a text identified by URN.
"""
function orthography(df, u)
	filtered = filter(r -> r[:urn] == u, df )
	filtered[1,:orthography]
end

