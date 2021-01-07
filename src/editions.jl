"""
$(SIGNATURES)
Find names of XML files in editing directory.
"""
function xmlfiles(repository)
    fullpath = readdir(repository.root * "/" * repository.editions)
    filenames = filter(f -> endswith(f, "xml"), fullpath)        
	filenames
end