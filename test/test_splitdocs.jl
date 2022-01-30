
@testset "Test finding XML files for split document" begin
    repo = joinpath("data","splitdocs") |> repository
    expected = ["e3_scholia08.xml", "e3_scholia10.xml"] 
    @test EditorsRepo.xmlfiles(repo) == expected
end


@testset "Find archival file for a urn in document edited in multiple files" begin
    repo = joinpath("data","splitdocs") |> repository
    u = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test_broken filename(repo,u) == "e3_scholia08.xml"
end


@testset "Lookup orthography for split document" begin
    repo = joinpath("data","splitdocs") |> repository
    urn10 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1")
    @test_broken orthographyforurn(textconfig, urn10).codepoints == literaryGreek().codepoints

    urn8 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test_broken orthographyforurn(textconfig, urn8).codepoints == literaryGreek().codepoints
end

@testset "Lookup passages in split document" begin
    repo = joinpath("data","splitdocs") |> repository
    @test_broken length(normalizedcorpus(repo)) == 6
end

@testset "Get archival source for part of split document" begin
    urn10 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10")
    repo = joinpath("data","splitdocs") |> repository
    # XML source should be valid.
    #src = textsourceforurn(repo, urn10)
    #@test length(src) < 1200
   
end