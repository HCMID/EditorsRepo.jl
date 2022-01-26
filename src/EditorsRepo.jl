module EditorsRepo

#using Base: nothing_sentinel
using Test, Documenter, DocStringExtensions

using CitableBase
using CitableObject
using CSV, TypedTables

using CitableText, CitableCorpus
using CitableTeiReaders, EditionBuilders


# All recognized orthographies:
using Orthography
using Lycian, PolytonicGreek, AtticGreek, ManuscriptOrthography

# Repository organization
export EditingRepository, repository
export configdir, dsedir, editionsdir

# Citation configuration
export citationconfig, missingcitation
export filename, o2converter,
    diplomaticbuilder, normalizedbuilder, orthography

# Text catalog    
export textcatalog,  texturns

# Text contents
export xmlfiles
export archivalcorpus
export textsourceforurn
export diplomatic_passages, normalized_passages



#=
export dsefiles
export surfaces, passages, images, surfaceDse


export textcatalog, textcatalog_df, texturns

export citationmatches, citationonly, catalogonly
export filesmatch, filesonly, citedonly
export missingcitation

export diplomatic_passagetext, normalized_passagetext, textpassages
export normalized_tokens, lextokens
=#

include("repository.jl")
include("citationconfig.jl")
include("textcatalog.jl")
include("textreading.jl")

include("xmlfiles.jl")
#=
include("dse.jl")


include("textconfig.jl")

include("validateconfig.jl")
include("tokenization.jl")
=#
end # module
