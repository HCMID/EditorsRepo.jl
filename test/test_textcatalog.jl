@testset "Test reading text catalog" begin
    mixeddir = joinpath("data", "mixedrepo")
    mixedrepo = repository(mixeddir, editions = "editing")
    cat =  textcatalog(mixedrepo)

    @test cat isa TextCatalogCollection

    onlineurns = texturns(mixedrepo)
    @test length(onlineurns) == 3
    # Test different signatures for optional params
end

@testset "Test finding online texts in catalog" begin
    repo = joinpath("data", "hmttextconfig") |> repository
    hmtcat = textcatalog(repo)
    @test length(hmtcat) == 15
    online = EditorsRepo.texturns(repo)
    @test length(online) == 11
end