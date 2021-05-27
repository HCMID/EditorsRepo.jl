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





