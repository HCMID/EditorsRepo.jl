using EditorsRepo
using CitableText, CitableTeiReaders, Orthography
using DataFrames
using Test

@testset "directories" begin
    @test isdir("data/lycian/editing")
end



include("test_repository.jl")
include("test_xmlarchive.jl")
#include("test_textcatalog.jl")
include("test_dse.jl")
include("test_citationschemes.jl")

include("test_texthandling.jl")
