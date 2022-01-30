var documenterSearchIndex = {"docs":
[{"location":"#EditorsRepo.jl","page":"Home","title":"EditorsRepo.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Manage editing of digital scholarly editions.","category":"page"},{"location":"","page":"Home","title":"Home","text":"ghroot = pwd() |> dirname\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"EditorsRepo.jl lets you work with files of editing work in progress in a local file system using more abstract structures such as \"a corpus of citable texts\" (CitableText.Corpus) or \"a record associating texts, image and physical surface\" (from the CitablePhysicalText module).","category":"page"},{"location":"","page":"Home","title":"Home","text":"One important application built with EditorsRepo.jl is the Pluto notebook providing interactive validation and verification of work in progress.  The next section of this documentation illustrates most of the functionality of EditorsRepo.jl by walking you through how the MID validator notebook uses the module.","category":"page"},{"location":"#Briefest-possible-example","page":"Home","title":"Briefest possible example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Create an EditingRepository.","category":"page"},{"location":"","page":"Home","title":"Home","text":"repopath = joinpath(ghroot, \"data\", \"splitdocs\")\nusing EditorsRepo\nrepo = repository(repopath)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Collect a corpus of normalized texts from the repository.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using CitableText, CitableCorpus\nurn = CtsUrn(\"urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1\")\n#normalized_passages(repo, urn) |> CitableTextCorpus","category":"page"},{"location":"","page":"Home","title":"Home","text":"A non-standard directory name:","category":"page"},{"location":"","page":"Home","title":"Home","text":"path = joinpath(ghroot, \"test\", \"data\", \"mixedrepo\")\nrepository(path, editions = \"editing\")","category":"page"},{"location":"man/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"man/#The-basic-Type","page":"API documentation","title":"The basic Type","text":"","category":"section"},{"location":"man/","page":"API documentation","title":"API documentation","text":"The starting point for EditorsRepo.jl is a directory in a local file system that includes subdirectories for standard kinds of content: editions of texts, indexing of texts to citable images and surfaces, and configuration files.","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"EditingRepository\nrepository\nconfigdir\ndsedir\neditionsdir","category":"page"},{"location":"man/#EditorsRepo.EditingRepository","page":"API documentation","title":"EditorsRepo.EditingRepository","text":"File organization of a repository for HMT editors.\n\nMembers\n\neditions Path to directory with source files for textual editions.\ndse  Path to directory with delimited text files recording text, image and surface relations.\nconfigs Path to directory with catalog.cex and citation.cex files.\n\n\n\n\n\n","category":"type"},{"location":"man/#EditorsRepo.repository","page":"API documentation","title":"EditorsRepo.repository","text":"Construct an EditingRepository from a root directory containing all three required directories.\n\nrepository(repodir; editions, dse, config)\n\n\nIf the required directories are named \"editions\", \"dse\" and \"config\", repodir is the only parameter needed.  Optionally, you may supply names  for any of those directories relative to reporoot.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.configdir","page":"API documentation","title":"EditorsRepo.configdir","text":"Find configuration directory for repository.\n\nconfigdir(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.dsedir","page":"API documentation","title":"EditorsRepo.dsedir","text":"Find DSE directory for repository.\n\ndsedir(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.editionsdir","page":"API documentation","title":"EditorsRepo.editionsdir","text":"Find editions directory for repository.\n\neditionsdir(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/","page":"API documentation","title":"API documentation","text":"Text configuration:","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"citationconfig\nfilename\no2converter,\ndiplomaticbuilder\nnormalizedbuilder\northography","category":"page"},{"location":"man/#EditorsRepo.citationconfig","page":"API documentation","title":"EditorsRepo.citationconfig","text":"Read citation configuration into a Table.\n\ncitationconfig(repo; filename, delimiter)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.filename","page":"API documentation","title":"EditorsRepo.filename","text":"filename(repo, txturn)\n\n\nLookup file name in a repository for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.orthography","page":"API documentation","title":"EditorsRepo.orthography","text":"orthography(repo, txturn)\n\n\nLookup orthography for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/","page":"API documentation","title":"API documentation","text":"Text catalog and contents:","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"textcatalog\ntexturns\narchivalcorpus\ndiplomaticcorpus\nnormalizedcorpus","category":"page"},{"location":"man/#EditorsRepo.textcatalog","page":"API documentation","title":"EditorsRepo.textcatalog","text":"Read a TextCatalogCollection for a repository.\n\ntextcatalog(repo; catalogname, delimiter)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.texturns","page":"API documentation","title":"EditorsRepo.texturns","text":"Find CTS URNs of all texts cataloged as online.\n\ntexturns(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.archivalcorpus","page":"API documentation","title":"EditorsRepo.archivalcorpus","text":"Create a citable corpus of all archival text in a repo.\n\narchivalcorpus(r)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.diplomaticcorpus","page":"API documentation","title":"EditorsRepo.diplomaticcorpus","text":"Create diplomatic editions of all texts in a repo.\n\ndiplomaticcorpus(r)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.normalizedcorpus","page":"API documentation","title":"EditorsRepo.normalizedcorpus","text":"Create normalized editions of all texts in a repo.\n\nnormalizedcorpus(r)\n\n\n\n\n\n\n","category":"function"},{"location":"man/","page":"API documentation","title":"API documentation","text":"Classified tokenization:","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"tokencorpus","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"DSE records:","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"dsetriples\npassageurnsforsurface\ndiplomaticforsurface\nimagesforpassage","category":"page"},{"location":"man/#EditorsRepo.dsetriples","page":"API documentation","title":"EditorsRepo.dsetriples","text":"dsetriples(repo)\n\n\nList .cex files in DSE directory.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.passageurnsforsurface","page":"API documentation","title":"EditorsRepo.passageurnsforsurface","text":"passageurnsforsurface(r, u)\n\n\nCompute list of passages in DSE records for a given surface.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.diplomaticforsurface","page":"API documentation","title":"EditorsRepo.diplomaticforsurface","text":"diplomaticforsurface(r, u)\n\n\nAssemble citable passages in diplomatic edition for a given surface.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.imagesforpassage","page":"API documentation","title":"EditorsRepo.imagesforpassage","text":"imagesforpassage(r, u)\n\n\nCompute list of images in DSE records for a given passage.\n\n\n\n\n\n","category":"function"},{"location":"man/","page":"API documentation","title":"API documentation","text":"HTML utilities:","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"htmltoken","category":"page"},{"location":"man/#EditorsRepo.htmltoken","page":"API documentation","title":"EditorsRepo.htmltoken","text":"Format an orthographic token in HTML.\n\nhtmltoken(psg, tokentype, ok)\n\n\nAdds appropriate whitespace to non-punctuation tokens, and wraps orthographically failed tokens in span element.\n\n\n\n\n\n","category":"function"},{"location":"man/#Internal-functions","page":"API documentation","title":"Internal functions","text":"","category":"section"},{"location":"man/","page":"API documentation","title":"API documentation","text":"EditorsRepo.xmlfiles\nEditorsRepo.textpassages\nEditorsRepo.isref\nEditorsRepo.passages_for_tokens\nEditorsRepo.analyzedtokens","category":"page"},{"location":"man/#EditorsRepo.xmlfiles","page":"API documentation","title":"EditorsRepo.xmlfiles","text":"xmlfiles(repository)\n\n\nFind names of XML files in editing directory.\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.textpassages","page":"API documentation","title":"EditorsRepo.textpassages","text":"Select from a corpus those matching a given URN, omitting ref passages conventionally used for non-textual metadata.\n\ntextpassages(c, u)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.isref","page":"API documentation","title":"EditorsRepo.isref","text":"True if last component of CTS URN passage is \"ref\". MID convention is to exclude elements, like notes on HMT scholia,   with this identifier.\n\nisref(urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.passages_for_tokens","page":"API documentation","title":"EditorsRepo.passages_for_tokens","text":"Create a list of CitablePassages from a list of OrthographicTokens  and a passage URN.\n\npassages_for_tokens(tkns, urn)\n\n\nPassage URNs are extended with an additional level of citation for the individual token.  This citation tier is made up of sequential numbers for lexical tokens, and token number + a character for other kinds of tokens (1a, 1b, etc.).\n\n\n\n\n\n","category":"function"},{"location":"man/#EditorsRepo.analyzedtokens","page":"API documentation","title":"EditorsRepo.analyzedtokens","text":"Compute a list of OrthographicTokens based on the normalized edition of all texts in the repository.  The result is a list of tuples pairing a citable text passage for the token and its type.\n\nanalyzedtokens(r)\n\n\n\n\n\n\nFor a single token citable as a CitablePassage, find its token class and determine if it is orthographically valid.\n\nanalyzedtokens(r, cn)\n\n\nReturns a tuple of a token type and a boolean value.\n\n\n\n\n\n","category":"function"}]
}
