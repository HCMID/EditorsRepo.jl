using EditorsRepo
using CitableText, CitableTeiReaders
using Test


@testset "directories" begin
    @test isdir("data/lycian/editing")
end

include("repository.jl")
include("textcatalog.jl")