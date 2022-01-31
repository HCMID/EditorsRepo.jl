"""Read citation configuration into a Table.

$(SIGNATURES)
"""
function citationconfig(repo::EditingRepository; filename = "citation.cex", delimiter = "|")
	citecex = joinpath(repo.configs, "citation.cex")
	inferred = CSV.File(citecex, skipto=2, delim=delimiter, 
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
Lookup file names in a repository for a text identified by URN.
`filescontaining` matches configuration entries with URNs containing `txturn`,
so if `txturn` refers to a specific citable passage, you will find the
corresponding file.
"""
function filescontaining(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
 
    matching = filter(r -> urncontains(r.urn, txturn), cites)
    if isempty(matching)
        @warn("No citation configuration found for $(txturn)")
        String[]
    else
        map(row -> row.file, matching)
    end
end

"""
Lookup file names in a repository for a text identified by URN.
$(SIGNATURES)
`fileswithin` matches configuration entires with URNs contained by `txturn`,
so if `txturn` refers to an entire work, you will find *all* corresponding files
for texts edited in more than one file.
"""
function fileswithin(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
 
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if isempty(matching)
        @debug("No citation configuration found for $(txturn)")
        String[]
    else
        map(row -> row.file, matching)
    end
end


"""
$(SIGNATURES)
Lookup `ocho2converter` for a text identified by URN.  If one than one configuration
entry matches `txturn`, it is assumed that all entries are configured to use the same
OHCO2 converter, and only the first entry is instantiated and returned.
"""
function o2converter(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        @debug("Multiple configuration entries for $(txturn).  Returning first ohco2 converter.")
    end
    matching[1].converter |> Meta.parse |> eval
end

"""
Lookup `diplomaticbuilder` for a text identified by URN.  
$(SIGNATURES)
If one than one configuration entry matches `txturn`, it is assumed that all entries are configured to use the same diplomatic builder, and only the first entry is instantiated and returned.
"""
function diplomaticbuilder(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(droppassage(txturn), r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        @debug("Multiple configuration entries for $(txturn).  Returning first diplomatic edition builder.")
    end
    matching[1].diplomatic |> Meta.parse |> eval
end

"""
Lookup normalizedbuilder for a text identified by URN.
$(SIGNATURES)
If one than one configuration entry matches `txturn`, it is assumed that all entries are configured to use the same normalized builder, and only the first entry is instantiated and returned.
"""
function normalizedbuilder(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        @debug("Multiple configuration entries for $(txturn).  Returning first normalized edition builder.")
    end
    matching[1].normalized |> Meta.parse |> eval
end

"""
Lookup orthography for a text identified by URN.
$(SIGNATURES)
If one than one configuration entry matches `txturn`, it is assumed that all entries are configured to use the same orthography, and only the first entry is instantiated and returned.
"""
function orthography(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        @debug("Multiple configuration entries for $(txturn).  Returning first orthography.")
    end
    matching[1].orthography |> Meta.parse |> eval
end

# TBD
function missingcitation(repo::EditingRepository)
    cites = citationconfig(repo)
    naughtylist = []
    for c in cites
        # for each property in list:
        # if ismissing, push! to naughtylist
    end
    naughtylist
end