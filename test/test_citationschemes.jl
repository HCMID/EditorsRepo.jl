
@testset "Test reading configuration of citation schemes" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    markupschemes = citation_df(repo)
    @test isa(markupschemes, DataFrame)
end

@testset "Lookup filename for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    @test filename(repo,urn) == "tl3.xml"
end

@testset "Lookup ohco2 converter for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    @test o2converter(repo,urn) ==  simpleAbReader
end


@testset "Lookup diplomatic edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    @test diplomaticbuilder(repo,urn) ===  nothing
end


@testset "Lookup normalized edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    @test normalizedbuilder(repo,urn) ===  nothing
end


@testset "Lookup orthography for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    df = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    @test orthography(repo,urn) ===  nothing
end