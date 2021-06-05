
@testset "Test constructing repository instance" begin

    #repo = repository("data/lycian"; editions = "editing")#, "dse", "config")
    #@test  isa(repo, EditingRepository)

    trailers = EditingRepository("data/lycian/editing/", "data/lycian/dse/", "data/lycian/config/")
    @test  isa(trailers, EditingRepository)
    @test trailers.editions == "data/lycian/editing/"

    # Directories must exist:
    @test_throws ArgumentError("DSE directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/editing/", "data/lycian/MISSING", "data/lycian/config")
    #@test_throws ArgumentError("Editing directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "MISSING", "dse", "config")
    #@test_throws ArgumentError("Configuration directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/", "editing", "dse", "MISSING")

end