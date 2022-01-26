
""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository)
    citesdf = citation_df(r)
    urns = citesdf[:, :urn]

    corpora = []
    for u in urns
        # 1. Read the source text (here, XML)
        src = textsourceforurn(r, u)
        if isnothing(src)
            # skip it
        else
            # 2. get the EditionBuilder for the urn
            reader = ohco2forurn(citesdf, u)
			if isnothing(reader)
				msg = "Unable to apply text reader to $u : check configuration"
				@warn msg
			else
            	# 3. create citable corpus of the archival version
            	push!(corpora, reader(src, u))
			end
        end
    end
    CitableCorpus.combine(corpora)
end



"""
Compose an array of `CitablePassage`s for a diplomatic reading of a text identified by CtsUrn."

$(SIGNATURES)
"""
function diplomatic_passages(repo, urn)
	textconfig = citation_df(repo)
    rows = filter(r -> CitableText.urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing

	else 
        
        # Instantiate configured converter and edition builder:
        reader = ohco2forurn(textconfig, urn)
	    diplbuilder = diplomaticforurn(textconfig, urn)
        if isnothing(reader) || isnothing(diplbuilder)
            nothing
        else 
            passages = []
            for i in 1:nrow(rows)
                # Read text contents and construct a corpus if everyting is OK
                f = repo.editions * "/" *	rows[i,:file]
                srctext = open(f) do file
                    read(file, String)
                end
                corpus = reader(srctext, urn)
                diplomatic_passages = map(cn -> edited_passage(diplbuilder, cn), corpus.passages)
                push!(passages, diplomatic_passages)
            end
            passages |> Iterators.flatten |> collect
        end
	end
end




"""
Compose an array of `CitablePassage`s for a normalized reading of a text identified by CtsUrn.

$(SIGNATURES)	
"""
function normalized_passages(repo, urn)

    textconfig = citation_df(repo)
    rows = filter(r -> CitableText.urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing

	else 
        passages = []
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
            normalized_passages = map(cn -> edited_passage(normbuilder, cn), corpus.passages)
            push!(passages, normalized_passages)
		end
        passages |> Iterators.flatten |> collect
	end
end


"""Compose a diplomatic text for all texts in the repository.

$(SIGNATURES)

Uses the repository's configuration info to determine how to edit each cataloged text.
"""
function diplpassages(editorsrepo::EditingRepository)
    urnlist = texturns(editorsrepo)
	try 
		diplomaticarrays = map(u -> diplomatic_passages(editorsrepo, u), urnlist)
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
		normedarrays = map(u -> normalized_passages(editorsrepo, u), urnlist)
		singlearray = reduce(vcat, normedarrays)
		filter(psg -> psg !== nothing, singlearray)
	catch e
		@warn "Error building normalized passages: $e"
		nothing
	end
end

