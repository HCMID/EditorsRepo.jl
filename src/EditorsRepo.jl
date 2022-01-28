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
using CitableImage

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
export analyzedtokens

# DSE records
export dsetriples
export surfaces, passages, images
export surfacevizpairs
export passageurnsforsurface, imagesforpassage
export diplomaticforsurface, normalizedforsurface, tokensforsurface

# HTML utilities
export htmltoken
export indexingaccuracy_html
export indexingcompleteness_html
export orthographicvalidity_html


#=
# Validation:
export citationmatches, citationonly, catalogonly
export filesmatch, filesonly, citedonly
export missingcitation
=#

include("repository.jl")
include("citationconfig.jl")
include("imageconfig.jl")
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
