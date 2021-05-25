
@testset "Test finding xml files" begin
    lyctestrepo  = EditingRepository("data/lycian", "editing", "dse", "config")
    catalog = textcatalog(lyctestrepo, "catalog.cex")
    @test length(catalog) ==  1
end


@testset "Test creating DF of cataloged files" begin
    lyctestrepo  = EditingRepository("data/lycian", "editing", "dse", "config")
    catalogdf = textcatalog_df(lyctestrepo)
    @test nrow(catalogdf) == 1
end