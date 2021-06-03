"""
Eval the string expression for the OHCO2 converter configured for a URN.

$(SIGNATURES)	
"""
function ohco2forurn(textconfig, urn)
	row = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(row) == 0
		nothing
	else
		try
			eval(Meta.parse(row[1,:o2converter]))
		catch e
			nothing
		end
	end
end


"""Eval the string expression for the orthography system configured for a URN.

$(SIGNATURES)	
"""
function orthographyforurn(textconfig, urn)
	
	row = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	@debug("URN $urn yields row $row")
	if nrow(row) == 0
		nothing
	else 
		orthostring = row[1,:orthography]
		@debug("Ortho string for row 1 is $orthostring")
		try
			sym = Meta.parse(orthostring) 
			@debug("Trying to eval symbol $sym")
			valuable = eval(sym)
			@debug("Succeeded!")
			valuable
		catch e
			@warn("Couldn't eval $(Meta.parse(orthostring))")
			e
		end
	end
end

"""Eval the string expression for the diplomatic builder configured for a URN.

$(SIGNATURES)

# Arguments

- `textconfig` configuration file
- `urn` text to retrieve
"""
function diplomaticforurn(textconfig, urn)
	row = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(row) == 0
		nothing
	else
		try
			eval(Meta.parse(row[1,:diplomatic]))
		catch e
			nothing
		end
	end
end

"""Eval the string expression for the normalized builder configured for a URN.

"""
function normalizerforurn(textconfig, urn)
	row = filter(r -> urncontains(droppassage(urn), r[:urn]), textconfig)
	if nrow(row) == 0
		nothing
	else 
		try
			eval(Meta.parse(row[1,:normalized]))
		catch e
			nothing
		end
	end
end
