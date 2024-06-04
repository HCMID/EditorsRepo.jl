"""File organization of a repository for HMT editors.

**Members**

- `editions` Path to directory with source files for textual editions.
- `dse`  Path to directory with delimited text files recording text, image and surface relations.
- `configs` Path to directory with `catalog.cex` and `citation.cex` files.
"""
struct EditingRepository
    editions::AbstractString
    dse::AbstractString
    configs::AbstractString
    function EditingRepository(e, d, c)        
        if (! isdir(e))
            throw(ArgumentError("Editing directory $(e) does not exist."))
        end

        if (! isdir(d))
            throw(ArgumentError("DSE directory $(d) does not exist."))
        end

        if (! isdir(c))
            throw(ArgumentError("Configuration directory $(c) does not exist."))
        end
        new(e, d, c)
    end

end

"""Construct an `EditingRepository` from a root directory containing
all three required directories.

$(SIGNATURES)

If the required directories are named "editions", "dse" and "config",
`repodir` is the only parameter needed.  Optionally, you may supply names 
for any of those directories relative to `reporoot`.

"""
function repository(repodir::AbstractString; editions = "", dse = "", config = "")
    #root = endswith(repodir,'/') ? repodir : string(repodir, "/")
    @debug "root is $root"
    eds = isempty(editions) ? "editions" : editions
    editingdir = joinpath(repodir, eds)
    if (! isdir(editingdir))
        throw(ArgumentError("Editing directory $(editingdir) does not exist."))
    end

    dses = isempty(dse) ? "dse" : dse
    dsedir = joinpath(repodir, dses)
    if (! isdir(dsedir))
        throw(ArgumentError("DSE directory $(dsedir) does not exist."))
    end

    confs = isempty(config) ? "config" : config
    configdir = joinpath(repodir, confs)
    if (! isdir(configdir))
        throw(ArgumentError("Configuration directory $(configdir) does not exist."))
    end

    EditingRepository(editingdir, dsedir, configdir)
end


"""Find configuration directory for repository.
$(SIGNATURES)
"""
function configdir(repo::EditingRepository)
    repo.configs
end

"""Find DSE directory for repository.
$(SIGNATURES)
"""
function dsedir(repo::EditingRepository)
    repo.dse
end

"""Find editions directory for repository.
$(SIGNATURES)
"""
function editionsdir(repo::EditingRepository)
    repo.editions
end