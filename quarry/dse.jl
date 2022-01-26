
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

"""Find URN for a single passage from DSE record, which could
include a range with subrefs within a single passage.
$(SIGNATURES)
"""
function baseurn(urn::CtsUrn)
	trimmed = CitableText.dropsubref(urn)
	if CitableText.isrange(trimmed)
		psg = CitableText.range_begin(trimmed)
		CitableText.addpassage(urn,psg)
	else
		urn
	end
end


"""Find DSE records for surface currently selected in popup menu.
$(SIGNATURES)
"""
function surfaceDse(repo, surfurn)
    alldse = dse_df(repo)
	filter(row -> row.surface == surfurn, alldse)
end