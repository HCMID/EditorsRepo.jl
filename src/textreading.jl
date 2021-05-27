


"""
Read the entire text contents of the online file identified by `urn`."

$(SIGNATURES)
"""
function textforurn(repo::EditingRepository, urn::CtsUrn)
	textconfig = citation_df(repo)
	rows = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing
	else 
		doctext = []
		for i in 1:nrow(rows)
			f = repo.root * "/" * repo.editions * "/" *	rows[i,:file]
			contents = open(f) do file
				read(file, String)
			end
			push!(doctext, contents)
		end
		join(doctext,"\n")
	end
end


"""
Compose an array of `CitableNode`s for a diplomatic reading of a text identified by CtsUrn."

$(SIGNATURES)
"""
function diplomaticnodes(repo, urn)
	textconfig = citation_df(repo)
	# Instantiate configured converter and edition builder:
	reader = ohco2forurn(textconfig, urn)
	diplbuilder = diplomaticforurn(textconfig, urn)
	# Read text contents and construct a corpus if everyting is OK

	rows = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing
	else 
		doctext = []
		for i in 1:nrow(rows)
			f = repo.root * "/" * repo.editions * "/" *	rows[i,:file]
			contents = open(f) do file
				read(file, String)
			end
			push!(doctext, contents)
		end
		join(doctext,"\n")
	end
	#=
	xml = textforurn(repo, urn)
	if nothing in [textconfig, reader, diplbuilder, xml]
		nothing
	else 
		corpus = reader(xml, urn)
		map(cn -> editednode(diplbuilder, cn), corpus.corpus)
	end
	=#
end




"""
Compose an array of `CitableNode`s for a normalized reading of a text identified by CtsUrn.

$(SIGNATURES)	
"""
function normalizednodes(repo, urn)
	textconfig = citation_df(repo)
	# Instantiate configured converter and edition builder:
	reader = ohco2forurn(textconfig, urn)
	normbuilder = normalizerforurn(textconfig, urn)
	# Read text contents and construct a corpus
	xml = textforurn(repo, urn)	
	if nothing in [textconfig, reader, normbuilder, xml]
		nothing
	else 
		corpus = reader(xml, urn)
		map(cn -> editednode(normbuilder, cn), corpus.corpus)
	end
end




"""Compose a diplomatic text for all texts in the repository.

$(SIGNATURES)

Uses the repository's configuration info to determine how to edit each cataloged text.
"""
function diplpassages(editorsrepo::EditingRepository)
    urnlist = texturns(editorsrepo)
	try 
		diplomaticarrays = map(u -> diplomaticnodes(editorsrepo, u), urnlist)
		singlearray = reduce(vcat, diplomaticarrays)
		filter(psg -> psg !== nothing, singlearray)
	catch e
		@warn "Error building diplomatic passages: $e"
		nothing
	end
end



"""Compose a normalized text for all texts in the repository.

$(SIGNATURES)

Uses the repository's configuration info to determine how to edit each cataloged text.
"""
function normedpassages(editorsrepo)
    urnlist = texturns(editorsrepo)
	try 
		normedarrays = map(u -> normalizednodes(editorsrepo, u), urnlist)
		singlearray = reduce(vcat, normedarrays)
		filter(psg -> psg !== nothing, singlearray)
	catch e
		@warn "Error building normalized passages: $e"
		nothing
	end
end

