""" 
Create a citable corpus of all archival text in a repo.

$(SIGNATURES)
"""
function archivalcorpus(r::EditingRepository)
    corpora = CitableTextCorpus[]
    for u in texturns(r)
        # get edition builder for u
        fname = joinpath(editionsdir(r), filename(r, u))
        c = readcitable(fname, u, o2converter(r, u), FileReader)
        push!(corpora, c)
    end
    map(c -> c.passages, corpora) |> vcat |> Iterators.flatten |> collect |> CitableTextCorpus 
end

"""Read source for text identified by `u`.

$(SIGNATURES)    
"""
function textsourceforurn(repo::EditingRepository, u::CtsUrn)

    fname = joinpath(editionsdir(repo), filename(repo, u))
    # concat contents of files matching u
    read(fname, String)
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