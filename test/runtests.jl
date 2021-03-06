using CitableText, CitableCorpus
using CitableObject
using CitableTeiReaders
using EditorsRepo
using Orthography, EditionBuilders
using DataFrames
using PolytonicGreek
using Test

include("test_repository.jl")
include("test_archivalcorpus.jl")
include("test_xmlarchive.jl")
include("test_textcatalog.jl")
include("test_dse.jl")
include("test_citationschemes.jl")
include("test_configvalidation.jl")
include("test_texthandling.jl")
include("test_splitdocs.jl")
include("test_tokenization.jl")
include("test_badeditions.jl")
