function dsefiles(repository)
    fullpath = readdir(repository.root * "/" * repository.dse)
    filenames = filter(f -> endswith(f, "cex"), fullpath)        
	filenames
end