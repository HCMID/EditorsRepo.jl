"File organization of a repository for HMT editors."
struct EditingRepository
    root::AbstractString
    editions::AbstractString
    dse::AbstractString
    function EditingRepository(r, e, d)
        root = endswith(r,'/') ? chop(r, head=0, tail=1) : r


        editions = endswith(e, '/') ? chop(e, head=0, tail=1) : e
        editingdir = root * "/" * editions
        if (! isdir(editingdir))
            throw(ArgumentError("Editing directory $(editingdir) does not exist."))
        end


        dse = endswith(d, '/') ? chop(d, head=0, tail=1) : d
        dsedir = root * "/" * dse
        if (! isdir(dsedir))
            throw(ArgumentError("DSE directory $(dsedir) does not exist."))
        end
        
        new(root, editions, dse)
    end
end