""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository)
end


function textsourceforurn(repo::EditingRepository, u::CtsUrn)
end


"""
Compose an array of `CitablePassage`s for a diplomatic reading of a text identified by CtsUrn."

$(SIGNATURES)
"""
function diplomatic_passages(repo, urn)
end

"""
Compose an array of `CitablePassage`s for a normalized reading of a text identified by CtsUrn.

$(SIGNATURES)	
"""
function normalized_passages(repo, urn)
end