using EditorsRepo
using CitableText, CitableTeiReaders, Orthography, EditionBuilders
using DataFrames
using Test

include("test_repository.jl")
include("test_xmlarchive.jl")
#include("test_textcatalog.jl")
include("test_dse.jl")

include("test_citationschemes.jl")
include("test_texthandling.jl")

include("test_configvalidation.jl")