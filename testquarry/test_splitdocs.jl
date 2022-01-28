
@testset "Test finding XML file in split document" begin
    repo = repository("data/splitdocs") #, "editions", "dse", "config")
    expected = ["e3_scholia08.xml", "e3_scholia10.xml"] 
    @test xmlfiles(repo) == expected
end


@testset "Find archival file for a urn in document edited in multiple files" begin
    repo = repository("data/splitdocs") #, "editions", "dse", "config")
    urn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test filename(repo,urn) == "e3_scholia08.xml"
end


@testset "Lookup orthography for split document" begin
    repo = repository("data/splitdocs") #, "editions", "dse", "config")
    textconfig = citation_df(repo)

    urn10 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1")
    @test orthographyforurn(textconfig, urn10).codepoints == literaryGreek().codepoints

    urn8 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test orthographyforurn(textconfig, urn8).codepoints == literaryGreek().codepoints
end

@testset "Lookup passages in split document" begin
    repo = repository("data/splitdocs") #, "editions", "dse", "config")
    normalizedpassages = repo |> EditorsRepo.normedpassages
    @test length(normalizedpassages) == 6
end

@testset "Get archival source for part of split document" begin
    urn10 =  CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10")
    repo = repository("data/splitdocs")
    # XML source should be valid.
    src = textsourceforurn(repo, urn10)
    @test length(src) < 1200
   
end