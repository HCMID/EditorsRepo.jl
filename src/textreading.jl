


"""
Read the entire text contents of the online file identified by `urn`."

$(SIGNATURES)

This function simply concatenates the text content of all source documents
matching `urn`.  Note that if multiple XML documents match `urn`, the result will
therefore not be well-formed XML.
"""
function textsourceforurn(repo::EditingRepository, urn::CtsUrn)
	textconfig = citation_df(repo)
	rows = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing
	else 
		doctext = []
		for i in 1:nrow(rows)
			f = repo.editions * "/" *	rows[i,:file]
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
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing

	else 
        
        # Instantiate configured converter and edition builder:
        reader = ohco2forurn(textconfig, urn)
	    diplbuilder = diplomaticforurn(textconfig, urn)
        if isnothing(reader) || isnothing(diplbuilder)
            nothing
        else 
            nodes = []
            for i in 1:nrow(rows)
                # Read text contents and construct a corpus if everyting is OK
                f = repo.editions * "/" *	rows[i,:file]
                srctext = open(f) do file
                    read(file, String)
                end
                corpus = reader(srctext, urn)
                diplnodes = map(cn -> editednode(diplbuilder, cn), corpus.corpus)
                push!(nodes, diplnodes)
            end
            nodes |> Iterators.flatten |> collect
        end
	end
end




"""
Compose an array of `CitableNode`s for a normalized reading of a text identified by CtsUrn.

$(SIGNATURES)	
"""
function normalizednodes(repo, urn)

    textconfig = citation_df(repo)
    rows = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing

	else 
        nodes = []
        # Instantiate configured converter and edition builder:
        reader = ohco2forurn(textconfig, urn)
	    normbuilder = normalizerforurn(textconfig, urn)
		#doctext = []
		for i in 1:nrow(rows)
            # Read text contents and construct a corpus if everyting is OK
			f = repo.editions * "/" *	rows[i,:file]
			srctext = open(f) do file
				read(file, String)
			end
			corpus = reader(srctext, urn)
            normednodes = map(cn -> editednode(normbuilder, cn), corpus.corpus)
            push!(nodes, normednodes)
		end
        nodes |> Iterators.flatten |> collect
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

