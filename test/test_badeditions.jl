@testset "Test instantiating a diplomatic edition builder from config with bad file name" begin
    repo = EditingRepository("data/badrepo1", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test_throws SystemError diplomaticnodes(repo, urn) 
end

@testset "Test instantiating a diplomatic edition builder from config with no entries" begin
    repo = EditingRepository("data/badrepo2", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test diplomaticnodes(repo, urn)  === nothing
end


@testset "Test instantiating a diplomatic edition builder from config with ill-formed CEX" begin
    repo = EditingRepository("data/badconfig", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test diplomaticnodes(repo, urn)  === nothing
end

@testset "Test instantiating a diplomatic edition builder from invalid XML" begin
    repo = EditingRepository("data/badxml", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.NOMARKUP:")
    @test diplomaticnodes(repo, urn)  === nothing
end

@testset "Test instantiating a diplomatic edition builder from XML with citation encoded wrong" begin
    repo = EditingRepository("data/badxml", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.BADCITATION:")
    @test diplomaticnodes(repo, urn)  === nothing
end