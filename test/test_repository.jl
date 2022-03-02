
@testset "Test constructing repository directly from relative references" begin
    relativedirs = EditingRepository("data/lycian/editing/", "data/lycian/dse/", "data/lycian/config/")

    @test  isa(relativedirs, EditingRepository)

    @test editionsdir(relativedirs) == "data/lycian/editing/"
    @test configdir(relativedirs) == "data/lycian/config/"
    @test dsedir(relativedirs) == "data/lycian/dse/"

    # Directories must exist:
    @test_throws ArgumentError("DSE directory data/lycian/MISSING does not exist.") EditingRepository("data/lycian/editing/", "data/lycian/MISSING", "data/lycian/config")
   
end



@testset "Test constructing repository with repository function" begin
    lycdir = joinpath("data", "lycian")
    lycrepo = repository(lycdir, editions = "editing")
    
    @test  isa(lycrepo, EditingRepository)

    @test editionsdir(lycrepo) == "data/lycian/editing"
    @test configdir(lycrepo) == "data/lycian/config"
    @test dsedir(lycrepo) == "data/lycian/dse"
end