
@testset "Test text tokenization functions" begin
    repo = EditingRepository("data/mixedrepo", "editing", "dse", "config")    
    urn = CtsUrn("urn:cts:trmilli:tl.25.v1:1")
    normtext = normednodetext(repo, urn)
    dipltext = diplnodetext(repo, urn)
    tkns = normtokens(repo; urn = urn)
end
