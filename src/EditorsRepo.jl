module EditorsRepo


using Test, Documenter, DocStringExtensions
using CitableText, CitableTeiReaders

export EditingRepository
export textcatalog

include("repository.jl")
include("textcatalog.jl")


end # module
