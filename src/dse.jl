"""
$(SIGNATURES)
List `.cex` files in DSE directory.
"""
function dsefiles(repository::EditingRepository)
    fullpath = readdir(repository.root * "/" * repository.dse)
    filenames = filter(f -> endswith(f, "cex"), fullpath)        
	filenames
end

"Read a single DSE file into a DataFrame"
function readdse(f)
	arr = CSV.File(f, skipto=2, delim="|") |> Array
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
    dirpath = repository.root * "/" * repository.dse * "/"
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