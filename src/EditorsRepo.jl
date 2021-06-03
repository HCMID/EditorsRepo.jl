module EditorsRepo

using Test, Documenter, DocStringExtensions
using CSV, DataFrames
using CitableText, CitableCorpus
using CitableTeiReaders, Orthography, EditionBuilders
using CitableObject
using Lycian, PolytonicGreek



export EditingRepository
export textcatalog, textcatalog_df, texturns
export dsefiles, dse_df, surfaces, passages, images
export xmlfiles, xmlfiles_df
export citation_df, filename, o2converter, 
    diplomaticbuilder, normalizedbuilder, orthography
export textsourceforurn, ohco2forurn, orthographyforurn, diplomaticforurn, normalizerforurn
export diplomaticnodes, normalizednodes
export citationmatches, citationonly, catalogonly
export filesmatch, filesonly, citedonly
export missingcitation

include("repository.jl")
include("textcatalog.jl")
include("dse.jl")
include("xmlarchive.jl")
include("citationconfig.jl")
include("textconfig.jl")
include("textreading.jl")
include("validateconfig.jl")

end # module
