@testset "Test finding XML files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test xmlfiles(repo) == ["tl25.xml"]
end

@testset "Test creating a DataFrame XML files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test isa(xmlfiles_df(repo), DataFrame)
end