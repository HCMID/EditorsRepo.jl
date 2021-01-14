module EditorsRepo

using Test, Documenter, DocStringExtensions
using CSV, DataFrames
using CitableText, CitableTeiReaders
using CitableObject

export EditingRepository
export textcatalog
export dsefiles, dse_df, surfaces, passages, images
export xmlfiles, xmlfiles_df
export citation_df, filename, o2converter, 
    diplomaticbuilder, normalizedbuilder, orthography

include("repository.jl")
include("textcatalog.jl")
include("dse.jl")
include("xmlarchive.jl")
include("citationconfig.jl")

end # module
