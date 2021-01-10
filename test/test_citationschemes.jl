
@testset "Test reading configuration of citation schemes" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    markupschemes = citation_df(repo)
    @test isa(markupschemes, DataFrame)
end