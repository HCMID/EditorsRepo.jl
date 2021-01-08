
@testset "Test finding xml files" begin
    lyctestrepo  = EditingRepository("data/lycian", "editing", "dse", "config")
    catalog = textcatalog(lyctestrepo, "catalog.cex")
    @test catalog == ""    
end
