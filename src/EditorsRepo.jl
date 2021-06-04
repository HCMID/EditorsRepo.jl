module EditorsRepo

using Test, Documenter, DocStringExtensions

using CitableObject
using CSV, DataFrames

using CitableText, CitableCorpus
using CitableTeiReaders, EditionBuilders
# All recognized orthographies:
using Orthography
using Lycian, PolytonicGreek, AtticGreek, ManuscriptOrthography


export EditingRepository

export dsefiles, dse_df
export surfaces, passages, images, surfaceDse

export textcatalog, textcatalog_df, texturns
export xmlfiles, xmlfiles_df
export citation_df, filename, o2converter, 
    diplomaticbuilder, normalizedbuilder, orthography
export textsourceforurn, ohco2forurn, orthographyforurn, diplomaticforurn, normalizerforurn
export diplomaticnodes, normalizednodes
export diplnodetext, normednodetext
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
