
@testset "Test constructing repository instance" begin
    trailers = EditingRepository("data/lycian/editing/", "data/lycian/dse/", "data/lycian/config/")
    @test  isa(trailers, EditingRepository)
    @test trailers.editions == "data/lycian/editing/"

    # Directories must exist:
    @test_throws ArgumentError("DSE directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/editing/", "data/lycian/MISSING", "data/lycian/config")
    
end