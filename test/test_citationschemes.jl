@testset "Read citation configuration into a table" begin
    path = joinpath("data", "mixedrepo")
    repo = repository(path; editions = "editing")
    cites = citationconfig(repo)
    @test cites isa Table
    @test length(cites) == 3
    @test typeof(cites[1].urn) == CtsUrn

    txturn = CtsUrn("urn:cts:trmilli:tl.25.v1:")    
    @test o2converter(repo, txturn) == TEIAnonblock
    @test_broken filename(repo, txturn) == "tl25.xml"
    @test_broken orthography(repo, txturn) |> typeof  == LycianAscii
    @test normalizedbuilder(repo, txturn) |> typeof ==  EditionBuilders.MidNormalizedBuilder
    @test diplomaticbuilder(repo, txturn) |> typeof == EditionBuilders.MidDiplomaticBuilder
    
    #
    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    @test_throws ArgumentError o2converter(repo, missingurn)
    #@test_throws ArgumentError filename(repo, missingurn)
    @test_throws ArgumentError orthography(repo, missingurn)
    @test_throws ArgumentError normalizedbuilder(repo, missingurn)
    @test_throws ArgumentError diplomaticbuilder(repo, missingurn)
end
