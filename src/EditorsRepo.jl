module EditorsRepo


using Test, Documenter, DocStringExtensions
using CSV, DataFrames
using CitableText, CitableTeiReaders

export EditingRepository
export textcatalog
export dsefiles
export xmlfiles, xmlfiles_df
export citation_df



include("repository.jl")
include("textcatalog.jl")
include("dse.jl")
include("xmlarchive.jl")
include("citationconfig.jl")


end # module
