
@testset "Test synchronization of catalog and citation" begin
    repo = repository("data/lycian"; editions = "editing")
    markupschemes = citation_df(repo)
    catalog = df_fromfile(repo.configs * "/catalog.cex")

    @test isa(catalog, DataFrame)
    @test isa(catalog[:,:urn][1], CtsUrn)

    @test isa(markupschemes, DataFrame)
    @test isa(markupschemes[:,:urn][1], CtsUrn)

    cf1 = catalog[:,:urn] 
    cf2 = markupschemes[:,:urn]
    @test isempty(setdiff(cf1,cf2))

    @test citationmatches(catalog, markupschemes)
    badrepo = repository("data/badrepo1") #, "editions", "dse", "config")
    badschemes = citation_df(repo)
    badcatalog = df_fromfile(badrepo.configs * "/catalog.cex")

    @test citationmatches(badcatalog, badschemes) ==  false
end

@testset "Test listing files missing from catalog" begin
    repo = repository("data/badrepo1") #, "editions", "dse", "config")
    textconfig = citation_df(repo)
    catalog = df_fromfile( repo.configs * "/catalog.cex")
    @test citationonly(catalog, textconfig) == [CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")]

end


@testset "Test listing files missing from citation config" begin
    repo = repository("data/badrepo2") #, "editions", "dse", "config")
    textconfig = citation_df(repo)
    catalog = df_fromfile(repo.configs * "/catalog.cex")
    @test catalogonly(catalog, textconfig) == [CtsUrn("urn:cts:trmilli:tl.25.v1:")]
end


@testset "Test synchronization of configuration and local files" begin
    repo = repository("data/lycian"; editions = "editing") #, "dse", "config")
    textconfig = citation_df(repo)
    @test filesmatch(repo, textconfig)
end


@testset "Test finding uncataloged local files" begin
    repo = repository("data/badrepo2") #, "editions", "dse", "config")
    textconfig = citation_df(repo)
    @test filesonly(repo, textconfig) == ["bad.xml"]
end



@testset "Test finding missing cataloged files" begin
    repo = repository("data/badrepo1") #, "editions", "dse", "config")
    textconfig = citation_df(repo)
    @test citedonly(repo, textconfig) == ["aratea.xml"]
end