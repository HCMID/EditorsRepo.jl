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
	if nrow(row) == 0
		nothing
	else 
		orthostring = row[1,:orthography]
		try
			eval(Meta.parse(orthostring))
		catch e
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
