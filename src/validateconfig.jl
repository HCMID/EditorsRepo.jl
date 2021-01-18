
"True if catalog and textconfig have same set of URNs."
function citationmatches(catalogedtexts, textconfig)
    catalog = catalogedtexts[:, :urn]
	citationconfig = textconfig[:,:urn]
	isempty(setdiff(catalog, citationconfig)) && isempty(setdiff(citationconfig, catalog))
end

"List texts in citation config but missing from catalog."
function citationonly(catalogedtexts, textconfig)
	catalog = catalogedtexts[:,:urn]
	citationconfig = textconfig[:,:urn]
	diffs = setdiff(citationconfig, catalog)
	intersect(diffs, citationconfig)
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


