
@testset "Test reading names of DSE files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test dsefiles(repo) == ["tl25dse.cex"]
end

@testset "Test loading DSE data into a DataFrame" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = dse_df(repo)
    @test isa(df,  DataFrame)
    @test nrow(df) == 38
end

@testset "Test finding list of surfaces in DSE records" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    surfs = surfaces(repo)
    @test length(surfs) == 3
end



@testset "Test finding list of passages in DSE records" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    psgs = passages(repo)
    @test length(psgs) == 38
end



@testset "Test finding list of images in DSE records" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    imgs = images(repo)
    @test length(imgs) == 38
end