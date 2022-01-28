module EditorsRepo

#using Base: nothing_sentinel
using Test, Documenter, DocStringExtensions
using CSV, TypedTables

using CitableBase

using CitableText, CitableCorpus
using CitableTeiReaders
using EditionBuilders
import EditionBuilders: normalizedbuilder
import EditionBuilders: diplomaticbuilder

using CitableObject

using CitablePhysicalText
import CitablePhysicalText: surfaces
import CitablePhysicalText: images
import CitablePhysicalText: passages

# All recognized orthographies:
using Orthography
using Lycian
using PolytonicGreek, ManuscriptOrthography
using AtticGreek

# Repository organization
export EditingRepository, repository
export configdir, dsedir, editionsdir

# Citation configuration
export citationconfig #, missingcitation
export filename, o2converter, orthography

# Text catalog    
export textcatalog,  texturns

# Text contents
export archivalcorpus
export diplomaticcorpus
export normalizedcorpus
export tokencorpus, tokenanalysis

# DSE records
export dsetriples
export surfaces, passages, images
export passagesforsurface, imagesforpassage, diplomaticnodesforsurface

# HTML utilities
export htmltoken


#=
# Validation:
export citationmatches, citationonly, catalogonly
export filesmatch, filesonly, citedonly
export missingcitation

export normalized_tokens, lextokens
=#

include("repository.jl")
include("citationconfig.jl")
include("textcatalog.jl")
include("textreading.jl")

include("xmlfiles.jl")
include("dse.jl")

include("tokenization.jl")

include("htmlutils.jl")

#=


include("validateconfig.jl")

=#
end # module
