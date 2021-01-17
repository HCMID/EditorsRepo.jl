import CitableTeiReaders.poeticLineReader

@testset "Test reading configuration of citation schemes" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    markupschemes = citation_df(repo)
    @test isa(markupschemes, DataFrame)
end


@testset "Lookup filename for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")

    df = citation_df(repo)
    @test filename(df,urn) == "tl3.xml"
    @test filename(repo,urn) == "tl3.xml"
end



@testset "Lookup ohco2 converter for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    
    df = citation_df(repo)
    @test o2converter(df,urn) ==  "simpleAbReader"
    @test o2converter(repo,urn) ==  "simpleAbReader"
end


@testset "Lookup diplomatic edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    df = citation_df(repo)
    @test diplomaticbuilder(df,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"
    @test diplomaticbuilder(repo,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"
end


@testset "Lookup normalized edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")

    df = citation_df(repo)    
    @test normalizedbuilder(df,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"
    @test normalizedbuilder(repo,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"

end


@testset "Lookup orthography for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")

    df = citation_df(repo)    
    @test orthography(df,urn) ==  "SimpleAscii()"
    @test orthography(repo,urn) ==  "SimpleAscii()"
end

