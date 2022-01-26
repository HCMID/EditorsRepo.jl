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
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        throw(ArgumentError("Multiple matches for $(txturn)"))
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
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        throw(ArgumentError("Multiple matches for $(txturn)"))
    else
        matching[1].converter
    end
end

"""
$(SIGNATURES)
Lookup diplomaticbuilder for a text identified by URN.
"""
function diplomaticbuilder(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        throw(ArgumentError("Multiple matches for $(txturn)"))
    else
        matching[1].diplomatic
    end
end

"""
$(SIGNATURES)
Lookup normalizedbuilder for a text identified by URN.
"""
function normalizedbuilder(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        throw(ArgumentError("Multiple matches for $(txturn)"))
    else
        matching[1].normalized
    end
end

"""
$(SIGNATURES)
Lookup orthography for a text identified by URN.
"""
function orthography(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        throw(ArgumentError("Multiple matches for $(txturn)"))
    else
        matching[1].orthography
    end
end