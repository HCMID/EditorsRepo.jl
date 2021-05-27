
@testset "Test finding XML file in split document" begin
    repo = EditingRepository("data/splitdocs", "editions", "dse", "config")
    expected = ["e3_scholia08.xml", "e3_scholia10.xml"] 
    @test xmlfiles(repo) == expected
end


@testset "Find archival file for a urn in document edited in multiple files" begin
    repo = EditingRepository("data/splitdocs", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test filename(repo,urn) == "e3_scholia08.xml"
end