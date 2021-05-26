@testset "Test finding XML files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test xmlfiles(repo) == ["tl25.xml"]
end

@testset "Test creating a DataFrame XML files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test isa(xmlfiles_df(repo), DataFrame)
end

@testset "Test creating an archival XML edition for a text" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    df = citation_df(repo)
    o2 = o2converter(df, urn)
end


@testset "Test finding XML file in split document" begin
    repo = EditingRepository("data/splitdocs", "editions", "dse", "config")
    expected = ["e3_scholia10.xml", "e3_scholia8.xml"] 
    @test xmlfiles(repo) == expected
end




@testset "Find archival file for a urn in document edited in multiple files" begin
    repo = EditingRepository("data/splitdocs", "editions", "dse", "config")
    urn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:8.2")
    @test filename(repo,urn) == "e3_scholia8.xml"
end
