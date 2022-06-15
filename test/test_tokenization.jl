
@testset "Test text tokenization functions" begin
    path = joinpath(pwd(),"data", "mixedrepo")
    repo = repository(path, editions =  "editing")
    u = CtsUrn("urn:cts:trmilli:tl.25.v1:2")
    expectedtext = "towetE : xssbezE : krop"
 
    #tkns =  analyzedtokens(repo, u)
    #@test length(tkns) == 5
    


    #=
    normtext = normalized_passagetext(repo, urn)
    dipltext = diplomatic_passagetext(repo, urn)

    @test normtext == expectedtext
    @test dipltext == expectedtext
    psgtkns = normalized_tokens(repo, urn)
    @test length(psgtkns) == 5
    psglextkns = lextokens(repo, urn)
    @test length(psglextkns) == 3

    alltkns = normalized_tokens(repo, droppassage(urn))
    @test length(alltkns) == 37
    lexicaltkns = lextokens(repo, droppassage(urn))
    @test length(lexicaltkns) == 24
    =#
end
