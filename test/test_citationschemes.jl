import CitableTeiReaders.poeticLineReader


@testset "Test finding citation entries with missing values" begin
    #repo = EditingRepository("data/lycian", "editing", "dse", "config")
    #markupschemes = citation_df(repo)
    #@test isa(markupschemes, DataFrame)


    badrepo = EditingRepository("data/badconfig", "editions", "dse", "config")
    failures = missingcitation(badrepo)
    @test length(failures) == 1
end
#=
@testset "Test reading configuration of citation schemes" begin
    repo = EditingRepository("data/lycian", "editing", "dse", "config")
    markupschemes = citation_df(repo)
    @test isa(markupschemes, DataFrame)


    badrepo = EditingRepository("data/badconfig", "editions", "dse", "config")
    badcite = citation_df(badrepo)
    @test isa(badcite, DataFrame)
    @test nrow(badcite) == 0
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

    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    @test o2converter(df,missingurn) === nothing
    @test o2converter(repo,missingurn) === nothing
end


@testset "Lookup diplomatic edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    
    df = citation_df(repo)
    @test diplomaticbuilder(df,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"
    @test diplomaticbuilder(repo,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"

    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    @test diplomaticbuilder(df,missingurn) === nothing
    @test diplomaticbuilder(repo,missingurn) === nothing
end


@testset "Lookup normalized edition builder for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")

    df = citation_df(repo)    
    @test normalizedbuilder(df,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"
    @test normalizedbuilder(repo,urn) ==  "LiteralTextBuilder(\"Literal text builder\",\"rawtext\")"

    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    @test normalizedbuilder(df,missingurn) === nothing
    @test normalizedbuilder(repo,missingurn) === nothing
end


@testset "Lookup orthography for URN" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")

    df = citation_df(repo)    
    @test orthography(df,urn) ==  "SimpleAscii()"
    @test orthography(repo,urn) ==  "SimpleAscii()"

    missingurn = CtsUrn("urn:cts:trmilli:tl.MISSING:")
    @test orthography(df,missingurn) === nothing
    @test orthography(repo,missingurn) === nothing
end

=#