
@testset "Test reading DSE files" begin
    repo = EditingRepository("data/lycian", "editing", "dse")
    @test dsefiles(repo) == ["tl25dse.cex"]
end
