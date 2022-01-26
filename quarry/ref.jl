
"""
Compose an array of `CitablePassage`s for a diplomatic reading of a text identified by CtsUrn."
$(SIGNATURES)
"""
function diplomatic_passages(repo, urn)
	textconfig = citation_df(repo)
    rows = filter(r -> CitableText.urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(rows) == 0
		nothing

	else 
        
        # Instantiate configured converter and edition builder:
        reader = ohco2forurn(textconfig, urn)
	    diplbuilder = diplomaticforurn(textconfig, urn)
        if isnothing(reader) || isnothing(diplbuilder)
            nothing
        else 
            passages = []
            for i in 1:nrow(rows)
                # Read text contents and construct a corpus if everyting is OK
                f = repo.editions * "/" *	rows[i,:file]
                srctext = open(f) do file
                    read(file, String)
                end
                corpus = reader(srctext, urn)
                diplomatic_passages = map(cn -> edited_passage(diplbuilder, cn), corpus.passages)
                push!(passages, diplomatic_passages)
            end
            passages |> Iterators.flatten |> collect
        end
	end
end