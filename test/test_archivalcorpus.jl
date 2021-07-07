@testset "Test building citable corpus of archival source" begin
    lyctestrepo  = EditingRepository("data/lycian/editing", "data/lycian/dse", "data/lycian/config")
    citablearchive = archivalcorpus(lyctestrepo)
    expectedlength = 7
    @test length(citablearchive.corpus) == expectedlength
end