
@testset "Test reading DSE files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test dsefiles(repo) == ["tl25dse.cex"]
end
