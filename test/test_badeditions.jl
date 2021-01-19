@testset "Test instantiating a diplomatic edition builder from config with bad file name" begin
    repo = EditingRepository("data/badrepo1", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test_throws SystemError diplomaticnodes(repo, urn)
    
end