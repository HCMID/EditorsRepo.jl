
LEXICAL_TOKEN = Orthography.LexicalToken()
PUNCTUATION = Orthography.PunctuationToken()

"""Format an orthographic token in HTML.
$(SIGNATURES)
Adds appropriate whitespace to non-punctuation tokens,
and wraps orthographically failed tokens in `span` element.
"""
function htmltoken(r::EditingRepository, tkn::CitablePassage)
    analysis = tokenanalysis(r, tkn)
    if ! analysis[2]
        " <span class=\"\">" * tkn.text * "</span>"
    else
        analysis[1] == PUNCTUATION ? tkn.text : " " * tkn.text
    end
end

"""Compose HTML for verification of accuracy of DSE indexing of a given surface.
$(SIGNATURES)
Juxtapose diplomatic edition of text with displayed image.
"""
function indexingaccuracy(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 500)
    vizprs = surfacevizpairs(r, surf)
    corpus = diplomaticcorpus(r)
    textlines = []
    for pr in vizprs
        # get text contents
        psgs = filter(psg -> urncontains(pr[1], psg.urn), corpus.passages)
        psgtext = if isempty(psgs)
            @warn("No passages match indexed URN $(pr[1])")
            ""
        elseif length(psgs) != 1
            @warn("Found $(length(psgs)) passages matching indexed URN $(pr[1])")
            textconent = map(p -> p.text, psgs)
            join(textcontent, "\n")
        else
            psgs[1].text
        end

        mdtext = string("**", passagecomponent(pr[1]), "** ", psgtext, "\n" )
        # get image markup
        mdimg = linkedMarkdownImage(ict, pr[2], iiif; ht=height, caption="image")
        push!(textlines, "---\n\n" * mdimg * "\n\n" * mdtext )
    end
    join(textlines, "\n")
    
end

"""Compose HTML for verifciation of completeness of DSE indexing of a given surface.
$(SIGNATURES)
"""
function indexingcompleteness(r::EditingRepository, surf::Cite2Urn; iiif = EditorsRepo.DEFAULT_IIIF, ict = EditorsRepo.DEFAULT_ICT, height = 150)
    triples = dsetriples(r)
    surfacetriples = filter(row -> urncontains(surf, row.surface), triples)
    images = map(tr -> tr.image, surfacetriples)
    ictlink = ict * "urn=" * join(images, "&urn=")
    imgmd = markdownImage(dropsubref(images[1]), iiif; ht = height)
    string("[", imgmd, "](", ictlink, ")")
end

#=
function completenessView(urn, repo)
     
	# Group images with ROI into a dictionary keyed by image
	# WITHOUT RoI.
	grouped = Dict()
	for row in eachrow(surfaceDse(repo, urn))
		trimmed = CitableObject.dropsubref(row.image)
		if haskey(grouped, trimmed)
			push!(grouped[trimmed], row.image)
		else
			grouped[trimmed] = [row.image]
		end
	end

	mdstrings = []
	for k in keys(grouped)
		thumb = markdownImage(k, iiifsvc(), thumbht)
		params = map(img -> "urn=" * img.urn * "&", grouped[k]) 
		lnk = ict() * join(params,"") 
		push!(mdstrings, "[$(thumb)]($(lnk))")
		
	end
	join(mdstrings, " ")

end


http://www.homermultitext.org/ict2/?urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2689,0.1740,0.3689,0.01957&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2699,0.1940,0.3674,0.01969&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2696,0.2165,0.3718,0.01896&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2705,0.2367,0.2901,0.01798&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2714,0.2539,0.3276,0.02177&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2751,0.2729,0.3268,0.01969&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2733,0.2904,0.3552,0.01969&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2766,0.3119,0.3474,0.01871&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2789,0.3319,0.3580,0.01932&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2795,0.5843,0.3273,0.01798&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2492,0.5083,0.3841,0.04636&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2630,0.5479,0.3916,0.01541&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2740,0.5679,0.3532,0.01394&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2849,0.6019,0.3374,0.02043&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2769,0.6189,0.3185,0.01835&urn=urn:cite2:citeecod:bern88imgs.v1:bern88_004v@0.2802,0.6403,0.3224,0.01614&

=#