

@testset "Test loading DSE data" begin
    path = joinpath(pwd(), "data", "mixedrepo")
    repo = repository(path, editions = "editing")
    @test EditorsRepo.dsefiles(repo) |> length == 3
    trips = EditorsRepo.dsetriples(repo, strict = false)
    @test length(trips) == 38
end


@testset "Test finding list of surfaces in DSE records" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    surfs = surfaces(repo, strict = false)
    @test length(surfs) == 3
end

#=
export surfacevizpairs
export passageurnsforsurface, imagesforpassage
export diplomaticforsurface, normalizedforsurface, tokensforsurface
=#
@testset "Test finding textpassages for a physical surface" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    Cite2Urn("urn:cite2:trmilli:inscriptions.v1:TL3")
    @test_broken 1 == 2
end

@testset "Test finding list of passages in DSE records" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    @test_broken 1 == 2
end



@testset "Test finding list of images in DSE records" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    imgs = [] #images(repo)
    @test_broken length(imgs) == 38
end

@testset "Test trimming URNs" begin
    urn = CtsUrn("urn:cts:hcmid:aratus.latinus.v1:aquila@Aquilam-aquila@inpor")
    #@test EditorsRepo.baseurn(urn) == CtsUrn("urn:cts:hcmid:aratus.latinus.v1:aquila")
    @test_broken  1 == 2
end
