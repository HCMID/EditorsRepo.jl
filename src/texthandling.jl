

"Read contents of file identified by `urn`."
function fileforurn(repo, urn)
    textconfig = citation_df(repo)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	f= repo.root * "/" * repo.editions * "/" *	row[1,:file]
	contents = open(f) do file
		read(file, String)
	end
	contents
end



"Eval the string expression for OHCO2 converter."
function ohco2forurn(textconfig, urn)
	row = filter(r -> droppassage(urn) == r[:urn], textconfig)
	eval(Meta.parse(row[1,:o2converter]))
end


"Eval the string expression for orthography."
function orthographyforurn(textconfig, urn)
    row = filter(r -> droppassage(urn) == r[:urn], textconfig)
    orthostring = row[1,:orthography]
	eval(Meta.parse(orthostring))
end