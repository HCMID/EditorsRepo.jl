
@testset "Test reading file contents given a URN" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    urn = CtsUrn("urn:cts:trmilli:tl.3.v1:")
    txt = textsourceforurn(repo, urn)
    expectedxml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<?xml-model  href=\"https://vault.tei-c.org/P5/current/xml/tei/custom/schema/relaxng/tei_all.rng\" schematypens=\"http://relaxng.org/ns/structure/1.0\" type=\"application/xml\"?>\n<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">\n  <teiHeader>\n    <fileDesc>\n      <titleStmt>\n        <title>TL 3</title>\n        <editor>Dane Scott</editor>\n      </titleStmt>\n      <publicationStmt>\n        <p>Unpublished edition</p>\n      </publicationStmt>\n      <sourceDesc>\n        <p>Edited directly from digital images</p>\n      </sourceDesc>\n    </fileDesc>\n  </teiHeader>\n  <text>\n    <body>\n     <ab n=\"1\">ebENnE : xopA : mE=ti prNnawatE : <w n=\"1\">te</w></ab>\n     <ab n=\"2\"><w n=\"1\">winezEi</w> : ppNtazah : <persName>asawAzala</persName></ab>\n     <ab n=\"3\">tideimi : hrppi : ladi : se <w>tide<supplied>imi</supplied></w></ab>\n      <ab n=\"4\"><w><choice><sic>p</sic><corr>m</corr></choice>iNti</w> : adaiyE <num>111</num></ab>\n    </body>\n  </text>\n</TEI>"
    @test txt == expectedxml
end

@testset "Test instantiating a configured OHCO2 converter" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    citation = citation_df(repo)
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    o2reader = ohco2forurn(citation, urn)
    @test isa(o2reader, typeof(poeticLineReader))

    badurn = CtsUrn("urn:cts:latinLit:FAKETEXT:")
    fakereader = ohco2forurn(citation, badurn)
    @test fakereader === nothing


    lycurn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    lycrepo =   EditingRepository("data/lycian/editing", "data/lycian/dse", "data/lycian/config")
    lyccites =  citation_df(lycrepo)
   
end


@testset "Test instantiating an orthographic system" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    citation = citation_df(repo)
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    ortho = orthography(citation, urn)
    @test supertype(typeof(ortho)) == OrthographicSystem

    badurn = CtsUrn("urn:cts:latinLit:FAKETEXT:")
    fakereader = orthography(citation, badurn)
    @test fakereader === nothing
end




@testset "Test instantiating a different orthographic system in the same repo" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    citation = citation_df(repo)
    urn = CtsUrn("urn:cts:trmilli:tl.25.v1:")
    ortho = orthography(citation, urn)
    @test supertype(typeof(ortho)) == OrthographicSystem
end


@testset "Test instantiating a diplomatic edition builder" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    citation = citation_df(repo)
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    dipl = diplomaticforurn(citation, urn)
    @test isa( dipl, LiteralTextBuilder)

    badurn = CtsUrn("urn:cts:latinLit:FAKETEXT:")
    fakereader = diplomaticforurn(citation, badurn)
    @test fakereader === nothing
end




@testset "Test building `CitablePassage`s for diplomatic edition for a given URN" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    psgs = diplomatic_passages(repo, urn)
    @test isa(psgs, Array{CitablePassage})
    @test length(psgs) == 19
    @test psgs[1].urn.urn == "urn:cts:latinLit:phi0881.phi003.rawtext:256"
end


@testset "Test instantiating a normalized edition builder" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    citation = citation_df(repo)
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    dipl = normalizerforurn(citation, urn)
    @test isa( dipl, LiteralTextBuilder)
end



@testset "Test building `CitablePassage`s for a normalized edition for a given URN" begin
    repo = repository("data/mixedrepo"; editions = "editing")
    urn = CtsUrn("urn:cts:latinLit:phi0881.phi003.bern88:")
    psgs = normalized_passages(repo, urn)
    @test isa(psgs, Array{CitablePassage})
    @test length(psgs) == 19
    @test psgs[1].urn.urn == "urn:cts:latinLit:phi0881.phi003.rawtext:256"
end

