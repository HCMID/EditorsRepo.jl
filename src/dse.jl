"""
$(SIGNATURES)
List `.cex` files in DSE directory.
"""
function dsefiles(repository::EditingRepository)
    fullpath = readdir(repository.root * "/" * repository.dse)
    filenames = filter(f -> endswith(f, "cex"), fullpath)        
	filenames
end
