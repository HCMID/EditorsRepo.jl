
"Read the text contents of the online file identified by `urn`."
function textforurn(repo, urn)
    textconfig = citation_df(repo)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	if nrow(row) == 0
		nothing
	else 
		f= repo.root * "/" * repo.editions * "/" *	row[1,:file]
		contents = open(f) do file
			read(file, String)
		end
		contents
	end
end

"Eval the string expression for the OHCO2 converter configured for a URN."
function ohco2forurn(textconfig, urn)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	if nrow(row) == 0
		nothing
	else
		eval(Meta.parse(row[1,:o2converter]))
	end
end


"Eval the string expression for the orthography system configured for a URN."
function orthographyforurn(textconfig, urn)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	if nrow(row) == 0
		nothing
	else 
    	orthostring = row[1,:orthography]
		eval(Meta.parse(orthostring))
	end
end



"Eval the string expression for the diplomatic builder configured for a URN."
function diplomaticforurn(textconfig, urn)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	if nrow(row) == 0
		nothing
	else
		eval(Meta.parse(row[1,:diplomatic]))
	end
end

"Eval the string expression for the normalized builder configured for a URN."
function normalizerforurn(textconfig, urn)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	if nrow(row) == 0
		nothing
	else 
		eval(Meta.parse(row[1,:normalized]))
	end
end

"Compose an array of `CitableNode`s for a diplomatic reading of a text identified by CtsUrn."
function diplomaticnodes(repo, urn)
	textconfig = citation_df(repo)
	# Instantiate configured converter and edition builder:
	reader = ohco2forurn(textconfig, urn)
	diplbuilder = diplomaticforurn(textconfig, urn)
	# Read text contents
	xml = textforurn(repo, urn)
	corpus = reader(xml, urn)
	
	map(cn -> editednode(diplbuilder, cn), corpus.corpus)
end

"Compose an array of `CitableNode`s for a normalized reading of a text identified by CtsUrn."
function normalizednodes(repo, urn)
	textconfig = citation_df(repo)
	# Instantiate configured converter and edition builder:
	reader = ohco2forurn(textconfig, urn)
	normbuilder = normalizerforurn(textconfig, urn)
	# Read text contents
	xml = textforurn(repo, urn)
	corpus = reader(xml, urn)
	
	map(cn -> editednode(normbuilder, cn), corpus.corpus)
end
