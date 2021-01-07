using EditorsRepo
using CitableText, CitableTeiReaders
using Test


@testset "directories" begin
    @test isdir("data/lycian/editing")
end



include("test_repository.jl")
include("test_editions.jl")
include("test_textcatalog.jl")
include("test_dse.jl")