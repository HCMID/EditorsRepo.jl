"""
$(SIGNATURES)
Find names of XML files in editing directory.
"""
function xmlfiles(repository::EditingRepository)
    fullpath = readdir(repository.root * "/" * repository.editions)
    filenames = filter(f -> endswith(f, "xml"), fullpath)        
	filenames
end


function xmlfiles_df(repository::EditingRepository)
    fnames = xmlfiles(repository)
    DataFrame(filename = fnames)
end
