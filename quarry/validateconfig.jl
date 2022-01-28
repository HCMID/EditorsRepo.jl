
"True if catalog and textconfig have same set of URNs."
function citationmatches(catalogedtexts, textconfig)
	if isempty(catalogedtexts) || isempty(textconfig)
		false
	else
		catalog = catalogedtexts[:, :urn]
		citationconfig = textconfig[:,:urn]
		tf = []
		for txt in catalog
			push!(tf, txt in citationconfig)
		end
		tftotal = unique(tf)
		length(catalog) == length(citationconfig) && length(tftotal) == 1 && tftotal[1]
	end
end

"List texts in citation config but missing from catalog."
function citationonly(catalogedtexts, textconfig)
	if isempty(textconfig)
		[]
	elseif isempty(catalogedtexts)
		textconfig[:, :urn]
	else
		catalog = catalogedtexts[:,:urn]
		citationconfig = textconfig[:,:urn]
		diffs = setdiff(citationconfig, catalog)
		intersect(diffs, citationconfig)
	end
end

"List texts in catalog but missing from citation config."
function catalogonly(catalogedtexts, textconfig)
	catalog = catalogedtexts[:,:urn]
	citationconfig = textconfig[:,:urn]
	diffs = setdiff(catalog, citationconfig)
	intersect(diffs, catalog)
end


"True if files on disk match listing in citation configuration."
function filesmatch(repo, textconfig)
	ondisk = xmlfiles(repo)
	cited = textconfig[:,:file]
	isempty(setdiff(ondisk, cited)) && isempty(setdiff(cited, ondisk))
end

"List files in editing directory that are not configured."
function filesonly(repo, textconfig)
	ondisk = xmlfiles(repo)
	cited = textconfig[:,:file]
	diffs = setdiff(ondisk, cited)
	intersect(diffs, ondisk)
end

"List configured files not found in file system."
function citedonly(repo, textconfig)
	ondisk = xmlfiles(repo)
	cited = textconfig[:,:file]
	diffs = setdiff(cited, ondisk)
	intersect(diffs, cited)
end


