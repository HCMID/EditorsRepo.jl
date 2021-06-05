"""
$(SIGNATURES)
Find names of XML files in editing directory.
"""
function xmlfiles(repository::EditingRepository)
    fullpath = readdir(repository.editions)
    filenames = filter(f -> endswith(f, "xml"), fullpath)        
	filenames
end

"""
$(SIGNATURES)
Find names of XML files in editing directory.
"""
function xmlfiles_df(repository::EditingRepository)
    fnames = xmlfiles(repository)
    DataFrame(filename = fnames)
end


#=
function archivaledition(repo::EditingRepository, u::CtsUrn)
     settings = citation_df(repo::EditingRepository)
     ohco2 = o2converter(settings, u)

end
=#