@testset "Test finding XML files" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    @test xmlfiles(repo) == ["tl25.xml"]
end