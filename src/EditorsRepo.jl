module EditorsRepo

using Base: nothing_sentinel
using Test, Documenter, DocStringExtensions

using CitableBase
using CitableObject
using CSV, DataFrames

using CitableText, CitableCorpus
using CitableTeiReaders, EditionBuilders
# All recognized orthographies:
using Orthography
using Lycian, PolytonicGreek, AtticGreek, ManuscriptOrthography


export EditingRepository, repository

export dsefiles, dse_df
export surfaces, passages, images, surfaceDse

export archivalcorpus
export textcatalog, textcatalog_df, texturns
export xmlfiles, xmlfiles_df
export citationmatches, citationonly, catalogonly
export filesmatch, filesonly, citedonly
export missingcitation

export citation_df, filename, o2converter, 
    diplomaticbuilder, normalizedbuilder, orthography
export textsourceforurn, ohco2forurn, orthographyforurn, diplomaticforurn, normalizerforurn

export diplomaticnodes, normalizednodes
export diplnodetext, normednodetext, textpassages
export normedtokens, lextokens

include("repository.jl")
include("textcatalog.jl")
include("dse.jl")
include("xmlarchive.jl")
include("citationconfig.jl")
include("textconfig.jl")
include("textreading.jl")
include("validateconfig.jl")
include("tokenization.jl")

end # module
