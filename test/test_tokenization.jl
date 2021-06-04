
@testset "Test text tokenization functions" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")    
    urn = CtsUrn("urn:cts:trmilli:tl.25.v1:2")
    expectedtext = "towetE : xssbezE : krop"
    normtext = normednodetext(repo, urn)
    dipltext = diplnodetext(repo, urn)

    @test normtext == expectedtext
    @test dipltext == expectedtext
    psgtkns = normedtokens(repo, urn)
    @test length(psgtkns) == 5
    psglextkns = lextokens(repo, urn)
    @test length(psglextkns) == 3

    alltkns = normedtokens(repo, droppassage(urn))
    @test length(alltkns) == 37
    lexicaltkns = lextokens(repo, droppassage(urn))
    @test length(lexicaltkns) == 24
end
