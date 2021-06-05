@testset "Test finding XML files" begin
    repo = EditingRepository("data/lycian/editing", "data/lycian/dse", "data/lycian/config")
    @test xmlfiles(repo) == ["tl25.xml"]
end

@testset "Test creating a DataFrame XML files" begin
    repo = EditingRepository("data/lycian/editing", "data/lycian/dse", "data/lycian/config")
    @test isa(xmlfiles_df(repo), DataFrame)
end

@testset "Test creating an archival XML edition for a text" begin
    repo = EditingRepository("data/mixedrepo/editing", "data/mixedrepo/dse", "data/mixedrepo/config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    df = citation_df(repo)
    o2 = o2converter(df, urn)
end





