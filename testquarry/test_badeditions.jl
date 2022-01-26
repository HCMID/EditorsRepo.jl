@testset "Test instantiating a diplomatic edition builder from config with bad file name" begin
    repo = repository("data/badrepo1/") #editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test diplomatic_passages(repo, urn)  == nothing
end

@testset "Test instantiating a diplomatic edition builder from config with no entries" begin
    repo = repository("data/badrepo2/")#, "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test diplomatic_passages(repo, urn)  === nothing
end


@testset "Test instantiating a diplomatic edition builder from config with ill-formed CEX" begin
    repo = repository("data/badconfig/")#, "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    @test diplomatic_passages(repo, urn)  === nothing
end

@testset "Test instantiating a diplomatic edition builder from invalid XML" begin
    repo = repository("data/badxml") #, "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.NOMARKUP:")
    @test diplomatic_passages(repo, urn)  === nothing
end

@testset "Test instantiating a diplomatic edition builder from XML with citation encoded wrong" begin
    repo = repository("data/badxml/")#, "editions", "dse", "config")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.BADCITATION:")
    @test diplomatic_passages(repo, urn)  === nothing
end