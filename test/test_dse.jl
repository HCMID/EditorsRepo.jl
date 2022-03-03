

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
export 
export  
export diplomaticforsurface, normalizedforsurface, tokensforsurface
=#
@testset "Test finding content by physical surface" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    surf = Cite2Urn("urn:cite2:trmilli:inscriptions.v1:TL3")
    psgs = passageurnsforsurface(repo, surf, strict = false)
    @test length(psgs) == 4

    txt = CtsUrn("urn:cts:trmilli:tl.3.v1:1")
    imgs = imagesforpassage(repo, txt, strict = false)
    expectedimg = Cite2Urn("urn:cite2:lycian:hc.v1:2007.02.0060@0.001425,0.000,0.9915,0.2174")
    @test length(imgs) == 1
    @test imgs[1] == expectedimg

    vizpairs = surfacevizpairs(repo, surf, strict = false)
    @test length(vizpairs) == 4
    @test map(pr -> pr[1], vizpairs) == psgs

    dipl = diplomaticforsurface(repo, surf, strict = false)
    @test length(dipl) == 4

    norm = normalizedforsurface(repo, surf, strict = false)
    @test length(norm) == 4

    
end




@testset "Test finding list of images in DSE records" begin
    repo = repository(joinpath("data", "mixedrepo"), editions = "editing")
    imgs = images(repo, strict = false)
    @test length(imgs) == 3
end

@testset "Test trimming URNs" begin
    urn = CtsUrn("urn:cts:hcmid:aratus.latinus.v1:aquila@Aquilam-aquila@inpor")
    #@test EditorsRepo.baseurn(urn) == CtsUrn("urn:cts:hcmid:aratus.latinus.v1:aquila")
    @test_broken  1 == 2
end
