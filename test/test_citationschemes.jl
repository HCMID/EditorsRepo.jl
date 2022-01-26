@testset "Read citation configuration into a table" begin
    path = joinpath("data", "mixedrepo")
    repo = repository(path; editions = "editing")
    cites = citationconfig(repo)
    @test cites isa Table
    @test length(cites) == 1
    @test types(cites[1].urn) == CtsUrn
end

@testset "Lookup ohco2 converter for URN" begin
    repo = repository("data/mixedrepo"; editions = "editing") #, "editing", "dse", "config")
    txturn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    expected = "simpleAbReader"
    #
    # o2converter


    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    #
end


@testset "Lookup filename for URN" begin
    #filename
end