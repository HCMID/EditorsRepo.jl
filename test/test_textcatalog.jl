
@testset "Test text catalog" begin
    lyctestrepo  = EditingRepository("data/lycian", "editing", "dse")
    catalog = textcatalog(lyctestrepo, "catalog.cex")
    #@test catalog == ""
end