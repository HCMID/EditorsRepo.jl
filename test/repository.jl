
@testset "Test constructing repository instance" begin

    repo = EditingRepository("data/lycian", "editing", "dse")
    @test  isa(repo, EditingRepository)

    trailers = EditingRepository("data/lycian/", "editing/", "dse/")
    @test  isa(trailers, EditingRepository)
    @test trailers.editions == "editing"


    # Directories must exist:
    @test_throws ArgumentError("DSE directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "editing/", "MISSING")
    @test_throws ArgumentError("Editing directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "MISSING", "dse")

end