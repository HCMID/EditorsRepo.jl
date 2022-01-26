@testset "Read citation configuration into a table" begin
    path = joinpath("data", "mixedrepo")
    repo = repository(path; editions = "editing")
    cites = citationconfig(repo)
    @test cites isa Table
    @test length(cites) == 3
    @test typeof(cites[1].urn) == CtsUrn
end

@testset "Lookup ohco2 converter for URN" begin
    path = joinpath("data", "mixedrepo")
    repo = repository(path; editions = "editing")
    txturn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    expected = "simpleAbReader"
    #
    # o2converter


    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    #
end


@testset "Lookup filename for URN" begin
    path = joinpath("data", "mixedrepo")
    repo = repository(path; editions = "editing")
    txturn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    #filename
    expected = "tl25.xml"
    @test filename(repo, txturn) == expected
end