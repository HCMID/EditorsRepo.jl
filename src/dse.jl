"""
$(SIGNATURES)
List `.cex` files in DSE directory.
"""
function dsefiles(repository::EditingRepository)
    fullpath = readdir(repository.dse)
    filenames = filter(f -> endswith(f, "cex"), fullpath)        
	filenames
end

"""Read a single DSE file into a DataFrame.
The file should have a three line cite relation header that looks
like

```
#!citerelationset
urn|urn:cite2:trmilli:dse.v1:tl25
label|Collection of DSE records for TL25
```

followed by one header line, then data lines.

$(SIGNATURES)

"""
function readdse(f)
	arr = CSV.File(f, header=4, delim="|") |> Array
	# text, image, surface
	passages = map(row -> CtsUrn(row[1]), arr)
	images = map(row -> Cite2Urn(row[2]), arr)
	surfaces = map(row -> Cite2Urn(row[3]), arr)
	DataFrame(passage = passages, image = images, surface = surfaces)
end

"""
$(SIGNATURES)
Merge all DSE data into a single dataframe.
"""
function dse_df(repository::EditingRepository)
    alldse = dsefiles(repository)
    dirpath = repository.dse * "/"
	fullnames = map(f ->  dirpath * f, alldse)
    dfs = map(f -> EditorsRepo.readdse(f), fullnames)
    vcat(dfs...)
end

"""
$(SIGNATURES)
Compute list of unique surfaces in DSE records.
"""
function surfaces(repo::EditingRepository)
	df = dse_df(repo)
	unique(df.surface)
end


"""
$(SIGNATURES)
Compute list of passages in DSE records.
"""
function passages(repo::EditingRepository)
	df = dse_df(repo)
	df.passage
end


"""
$(SIGNATURES)
Compute list of passages in DSE records.
"""
function images(repo::EditingRepository)
	df = dse_df(repo)
	df.image
end

"""Find URN for a single node from DSE record, which could
include a range with subrefs within a single node.
$(SIGNATURES)
"""
function baseurn(urn::CtsUrn)
	trimmed = CitableText.dropsubref(urn)
	if CitableText.isrange(trimmed)
		psg = CitableText.rangebegin(trimmed)
		CitableText.addpassage(urn,psg)
	else
		urn
	end
end


"""Find DSE records for surface currently selected in popup menu.
$(SIGNATURES)
"""
function surfaceDse(repo, surfurn)
    alldse = dse_df(repo)
	filter(row -> row.surface == surfurn, alldse)
end