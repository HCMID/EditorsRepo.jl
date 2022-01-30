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


function fileswithin(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
 
    matching = filter(r -> urncontains(txturn, r.urn), cites)
    if isempty(matching)
        @warn("No citation configuration found for $(txturn)")
        String[]
    else
        map(row -> row.file, matching)
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
        @warn("Multiple configuration entries for $(txturn).  Returning first ohco2 converter.")
    end
    matching[1].converter |> Meta.parse |> eval
end

"""
$(SIGNATURES)
Lookup diplomaticbuilder for a text identified by URN.
"""
function diplomaticbuilder(repo::EditingRepository, txturn::CtsUrn)
    cites = citationconfig(repo)
    matching = filter(r -> urncontains(droppassage(txturn), r.urn), cites)
    if length(matching) < 1
        throw(ArgumentError("No citation configuration found for $(txturn)"))
    elseif length(matching) > 1
        @warn("Multiple configuration entries for $(txturn).  Returning first diplomatic edition builder.")
    end
    matching[1].diplomatic |> Meta.parse |> eval
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
        @warn("Multiple configuration entries for $(txturn).  Returning first normalized edition builder.")
    end
    matching[1].normalized |> Meta.parse |> eval
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
        @warn("Multiple configuration entries for $(txturn).  Returning first orthography.")
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