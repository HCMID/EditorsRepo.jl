module EditorsRepo


using Test, Documenter, DocStringExtensions
using CSV
using CitableText, CitableTeiReaders

export EditingRepository
export textcatalog
export dsefiles
export xmlfiles



include("repository.jl")
include("textcatalog.jl")
include("dse.jl")
include("editions.jl")


end # module
