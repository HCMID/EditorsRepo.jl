
@testset "Test constructing repository instance" begin

    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test  isa(repo, EditingRepository)

    trailers = EditingRepository("data/lycian/", "editing/", "dse/", "config/")
    @test  isa(trailers, EditingRepository)
    @test trailers.editions == "editing"

    # Directories must exist:
    @test_throws ArgumentError("DSE directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "editing/", "MISSING", "config")
    @test_throws ArgumentError("Editing directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "MISSING", "dse", "config")
    @test_throws ArgumentError("Configuration directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "editing", "dse", "MISSING")

end