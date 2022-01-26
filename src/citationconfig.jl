"""Read citation configuration into a Table.

$(SIGNATURES)
"""
function citationconfig(repo::EditingRepository)
	citecex = joinpath(repo.configs, "citation.cex")
	inferred = CSV.File(citecex, skipto=2, delim="|", 
	quotechar='&', escapechar='&') |> Table


    coldata = []
    for col in columnnames(inferred)
        if col == :urn 
            idrow = map(row -> CtsUrn(row.urn), inferred)
            push!(coldata, idrow)
        else
            row = map(getproperty(col), inferred)
            push!(coldata, row)
        end
   end
   NamedTuple{columnnames(inferred)}(coldata) |> Table 
    
end

"""
$(SIGNATURES)
Lookup file name in a repository for a text identified by URN.
"""
function filename(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if isempty(matching)
        ArgumentError("No citation configuration found for $(txturn)")
    elseif length(matching) > 1
        ArgumentError("Multiple matches for $(txturn)")
    else
        matching[1].file
    end
end


"""
$(SIGNATURES)
Lookup ocho2converter for a text identified by URN.
"""
function o2converter(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if isempty(matching)
        ArgumentError("No citation configuration found for $(txturn)")
    elseif length(matching) > 1
        ArgumentError("Multiple matches for $(txturn)")
    else
        matching[1].converter
    end
end