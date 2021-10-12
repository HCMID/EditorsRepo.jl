var documenterSearchIndex = {"docs":
[{"location":"man/dse/#Indexing-texts,-images-and-surfaces-(DSE-records)","page":"Indexing texts, images and surfaces (DSE records)","title":"Indexing texts, images and surfaces (DSE records)","text":"","category":"section"},{"location":"man/dse/","page":"Indexing texts, images and surfaces (DSE records)","title":"Indexing texts, images and surfaces (DSE records)","text":"Exported:","category":"page"},{"location":"man/dse/","page":"Indexing texts, images and surfaces (DSE records)","title":"Indexing texts, images and surfaces (DSE records)","text":"dsefiles\ndse_df\nsurfaces\npassages\nimages\nsurfaceDse","category":"page"},{"location":"man/dse/#EditorsRepo.dsefiles","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.dsefiles","text":"dsefiles(repository)\n\n\nList .cex files in DSE directory.\n\n\n\n\n\n","category":"function"},{"location":"man/dse/#EditorsRepo.dse_df","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.dse_df","text":"dse_df(repository)\n\n\nMerge all DSE data into a single dataframe.\n\n\n\n\n\n","category":"function"},{"location":"man/dse/#EditorsRepo.surfaces","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.surfaces","text":"surfaces(repo)\n\n\nCompute list of unique surfaces in DSE records.\n\n\n\n\n\n","category":"function"},{"location":"man/dse/#EditorsRepo.passages","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.passages","text":"passages(repo)\n\n\nCompute list of passages in DSE records.\n\n\n\n\n\n","category":"function"},{"location":"man/dse/#EditorsRepo.images","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.images","text":"images(repo)\n\n\nCompute list of passages in DSE records.\n\n\n\n\n\n","category":"function"},{"location":"man/dse/#EditorsRepo.surfaceDse","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.surfaceDse","text":"Find DSE records for surface currently selected in popup menu.\n\nsurfaceDse(repo, surfurn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/dse/","page":"Indexing texts, images and surfaces (DSE records)","title":"Indexing texts, images and surfaces (DSE records)","text":"Internal:","category":"page"},{"location":"man/dse/","page":"Indexing texts, images and surfaces (DSE records)","title":"Indexing texts, images and surfaces (DSE records)","text":"EditorsRepo.baseurn","category":"page"},{"location":"man/dse/#EditorsRepo.baseurn","page":"Indexing texts, images and surfaces (DSE records)","title":"EditorsRepo.baseurn","text":"Find URN for a single passage from DSE record, which could include a range with subrefs within a single passage.\n\nbaseurn(urn)\n\n\n\n\n\n\n","category":"function"},{"location":"guide/dseaccuracy/#DSE-accuracy","page":"DSE accuracy","title":"DSE accuracy","text":"","category":"section"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"docsroot = pwd() |> dirname |> dirname\nburney86root = docsroot * \"/data/burney86/\"\nusing EditorsRepo\ntownley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"To verify the accuracy of DSE indexing, the validator notebook juxtaposes, for each indexed passage, the indexed region of the image with a diplomatic text of the passage.","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"We'll get a DataFrame of DSE records for the surface, as we did in constructing a view for completeness.","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"using CitableObject\nsurface = Cite2Urn(\"urn:cite2:hmt:burney86pages.v1:73r\")\n\nsurfdse = surfaceDse(townley, surface)","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"For each row in the DSE DataFrame, the notebook uses the CitableImage.jl module to embed an image of the selected region.","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"To collect the diplomatic text for a passage, use the diplomatic_passagetext function.","category":"page"},{"location":"guide/dseaccuracy/","page":"DSE accuracy","title":"DSE accuracy","text":"using CitableText\npsg = CtsUrn(\"urn:cts:greekLit:tlg0012.tlg001.burney86:8.title\")\ndiplomatic_passagetext(townley, psg)","category":"page"},{"location":"guide/surfaces/#Surfaces","page":"Surfaces","title":"Surfaces","text":"","category":"section"},{"location":"guide/surfaces/","page":"Surfaces","title":"Surfaces","text":"We validate and verify our work in progress one surface at a time.","category":"page"},{"location":"guide/surfaces/","page":"Surfaces","title":"Surfaces","text":"Get a list of surfaces appearing in this repository's DSE tables","category":"page"},{"location":"guide/surfaces/","page":"Surfaces","title":"Surfaces","text":"docsroot = pwd() |> dirname |> dirname\nburney86root = docsroot * \"/data/burney86/\"\nusing EditorsRepo\ntownley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/surfaces/","page":"Surfaces","title":"Surfaces","text":"surfs = surfaces(townley)","category":"page"},{"location":"guide/cataloging/#Cataloging:-completeness-and-accuracy","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"","category":"section"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"docsroot = pwd() |> dirname |> dirname\nburney86root = docsroot * \"/data/burney86/\"","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"Use same repository as before.","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"using EditorsRepo\ntownley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"Get a DataFrame with citation info","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"cites = citation_df(townley)","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"Test if files in catalog match those in editing directory","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"filesmatch(townley, cites)","category":"page"},{"location":"guide/cataloging/","page":"Cataloging: completeness and accuracy","title":"Cataloging: completeness and accuracy","text":"Other functions list differences between files found and files cataloged.","category":"page"},{"location":"man/textcatalog/#Text-configuration","page":"Text configuration","title":"Text configuration","text":"","category":"section"},{"location":"man/textcatalog/#Loading-and-verifying-the-text-configuration","page":"Text configuration","title":"Loading and verifying the text configuration","text":"","category":"section"},{"location":"man/textcatalog/","page":"Text configuration","title":"Text configuration","text":"citation_df\ntextcatalog\ntextcatalog_df\ntexturns\nmissingcitation\nfilesmatch\ncatalogonly\ncitedonly","category":"page"},{"location":"man/textcatalog/#EditorsRepo.citation_df","page":"Text configuration","title":"EditorsRepo.citation_df","text":"Read citation configuration into a DataFrame.\n\ncitation_df(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.textcatalog","page":"Text configuration","title":"EditorsRepo.textcatalog","text":"Loads catalog of texts from file as an Array of CSV Rows.\n\ntextcatalog(repo, catalogname)\ntextcatalog(repo, catalogname, delimiter)\n\n\nArguments\n\nrepo The editorial repository.\ncatalogname Name of the text catalog file.\ndelimiter Delimiting string in the text catalog.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.textcatalog_df","page":"Text configuration","title":"EditorsRepo.textcatalog_df","text":"Load catalog of texts from file as a DataFrame\n\ntextcatalog_df(repo)\n\n\nArguments\n\nrepo The editorial repository.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.texturns","page":"Text configuration","title":"EditorsRepo.texturns","text":"Find CTS URNs of all texts cataloged as online.\n\ntexturns(repo)\n\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.missingcitation","page":"Text configuration","title":"EditorsRepo.missingcitation","text":"missingcitation(repo)\n\n\nList entries with missing values in citation configuration.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.filesmatch","page":"Text configuration","title":"EditorsRepo.filesmatch","text":"True if files on disk match listing in citation configuration.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.catalogonly","page":"Text configuration","title":"EditorsRepo.catalogonly","text":"List texts in catalog but missing from citation config.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.citedonly","page":"Text configuration","title":"EditorsRepo.citedonly","text":"List configured files not found in file system.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#Reading-configuration-settings","page":"Text configuration","title":"Reading configuration settings","text":"","category":"section"},{"location":"man/textcatalog/","page":"Text configuration","title":"Text configuration","text":"filename\no2converter\ndiplomaticbuilder\nnormalizedbuilder\northography\nohco2forurn\northographyforurn\ndiplomaticforurn\nnormalizerforurn","category":"page"},{"location":"man/textcatalog/#EditorsRepo.filename","page":"Text configuration","title":"EditorsRepo.filename","text":"filename(repo, u)\n\n\nLookup file name in a repository for a text identified by URN.\n\n\n\n\n\nfilename(df, u)\n\n\nLookup file name in a DataFame for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.o2converter","page":"Text configuration","title":"EditorsRepo.o2converter","text":"o2converter(repo, u)\n\n\nLookup ohco2 converter in a repository for a text identified by URN.\n\n\n\n\n\no2converter(df, u)\n\n\nLookup ohco2 converter in a DataFrame for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.diplomaticbuilder","page":"Text configuration","title":"EditorsRepo.diplomaticbuilder","text":"diplomaticbuilder(repo, u)\n\n\nLookup in a repository the builder for diplomatic edition for a text identified by URN.\n\n\n\n\n\ndiplomaticbuilder(df, u)\n\n\nLookup in a DataFrame the builder for diplomatic edition for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.normalizedbuilder","page":"Text configuration","title":"EditorsRepo.normalizedbuilder","text":"normalizedbuilder(repo, u)\n\n\nLookup in a repository the builder for diplomatic edition for a text identified by URN.\n\n\n\n\n\nLookup in a DataFrame the builder for diplomatic edition for a text identified by URN.\n\nnormalizedbuilder(df, u)\n\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.orthography","page":"Text configuration","title":"EditorsRepo.orthography","text":"Lookup in a repository the orthographic system for a text identified by URN.\n\northography(repo, u)\n\n\n\n\n\n\northography(df, u)\n\n\nLookup in a DataFrame the orthographic system for a text identified by URN.\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.ohco2forurn","page":"Text configuration","title":"EditorsRepo.ohco2forurn","text":"Eval the string expression for the OHCO2 converter configured for a URN.\n\nohco2forurn(textconfig, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.orthographyforurn","page":"Text configuration","title":"EditorsRepo.orthographyforurn","text":"Eval the string expression for the orthography system configured for a URN.\n\northographyforurn(textconfig, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.diplomaticforurn","page":"Text configuration","title":"EditorsRepo.diplomaticforurn","text":"Eval the string expression for the diplomatic builder configured for a URN.\n\ndiplomaticforurn(textconfig, urn)\n\n\nArguments\n\ntextconfig configuration file\nurn text to retrieve\n\n\n\n\n\n","category":"function"},{"location":"man/textcatalog/#EditorsRepo.normalizerforurn","page":"Text configuration","title":"EditorsRepo.normalizerforurn","text":"Eval the string expression for the normalized builder configured for a URN.\n\n\n\n\n\n","category":"function"},{"location":"guide/dsecompleteness/#DSE-completeness","page":"DSE completeness","title":"DSE completeness","text":"","category":"section"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"docsroot = pwd() |> dirname |> dirname\nburney86root = docsroot * \"/data/burney86/\"\nusing EditorsRepo\ntownley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"To verify the completeness of indexing for a given surface, the Pluto notebook needs the DSE records for that surface.  Here's how to get a DataFrame of DSE triples.","category":"page"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"using CitableObject\nsurface = Cite2Urn(\"urn:cite2:hmt:burney86pages.v1:73r\")\n\nsurfdse = surfaceDse(townley, surface)","category":"page"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"Note this.","category":"page"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"note: Note\nThe validator notebook then uses the CitableImage library to construct URLs overlaying regions indexed on this page to the HMT image citation tool.  They look like http://www.homermultitext.org/ict2/?urn=urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f073r@0.1703,0.3014,0.3983,0.03259&.  See the documentation for the CitableImage.jl module.","category":"page"},{"location":"guide/dsecompleteness/","page":"DSE completeness","title":"DSE completeness","text":"DSE accuracy is more complex.","category":"page"},{"location":"man/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"man/#The-basic-Type","page":"API documentation","title":"The basic Type","text":"","category":"section"},{"location":"man/","page":"API documentation","title":"API documentation","text":"The starting point for EditorsRepo.jl is a directory in a local file system that includes subdirectories for standard kinds of content: editions of texts, indexing of texts to citable images and surfaces, and configuration files.","category":"page"},{"location":"man/","page":"API documentation","title":"API documentation","text":"EditingRepository","category":"page"},{"location":"man/#EditorsRepo.EditingRepository","page":"API documentation","title":"EditorsRepo.EditingRepository","text":"File organization of a repository for HMT editors.\n\nMembers\n\neditions Full path to directory with source files for textual editions.\ndse  Full path to directory with delimited text files recording text, image and surface relations.\nconfigs Full path to directory with catalog.cex and citation.cex files.\n\n\n\n\n\n","category":"type"},{"location":"guide/orthography/#Orthography","page":"Orthography","title":"Orthography","text":"","category":"section"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"docsroot = pwd() |> dirname |> dirname\nburney86root = docsroot * \"/data/burney86/\"\nusing EditorsRepo\ntownley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"We want to test whether the text is valid within the configured orthographic system.","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"We can get a DataFrame with the citation data like this ","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"textconfig = citation_df(townley)","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"To find the correct orthography for a passage, we'll use baseurn to clean up any range or subreference annotations.","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"using CitableText\nurn = CtsUrn(\"urn:cts:greekLit:tlg0012.tlg001.burney86:8.title\")\ntidy = EditorsRepo.baseurn(urn)","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"Get the orthography for our passage:","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"ortho = orthographyforurn(textconfig, tidy)","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"We'll validate the orthography by white-spaced chunks to make it easy to display and read in the notebook.","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"chunks = normalized_passagetext(townley, tidy) |> split","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"The validator notebook then uses the Orthography.jl module's validstring function to determine how to display the chunk.","category":"page"},{"location":"guide/orthography/","page":"Orthography","title":"Orthography","text":"using Orthography, ManuscriptOrthography\nvalidstring(chunks[1], ortho)","category":"page"},{"location":"man/texts/#Reading-texts-from-the-repository","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"","category":"section"},{"location":"man/texts/#Finding-editions","page":"Reading texts from the repository","title":"Finding editions","text":"","category":"section"},{"location":"man/texts/","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"xmlfiles\nxmlfiles_df","category":"page"},{"location":"man/texts/#EditorsRepo.xmlfiles","page":"Reading texts from the repository","title":"EditorsRepo.xmlfiles","text":"xmlfiles(repository)\n\n\nFind names of XML files in editing directory.\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.xmlfiles_df","page":"Reading texts from the repository","title":"EditorsRepo.xmlfiles_df","text":"xmlfiles_df(repository)\n\n\nFind names of XML files in editing directory.\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#Reading-text-contents","page":"Reading texts from the repository","title":"Reading text contents","text":"","category":"section"},{"location":"man/texts/","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"Exported functions:","category":"page"},{"location":"man/texts/","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"diplomatic_passages\nnormalized_passages\ndiplomatic_passagetext\nnormalized_passagetext\ntextpassages\nnormalized_tokens\nlextokens","category":"page"},{"location":"man/texts/#EditorsRepo.diplomatic_passages","page":"Reading texts from the repository","title":"EditorsRepo.diplomatic_passages","text":"Compose an array of CitablePassages for a diplomatic reading of a text identified by CtsUrn.\"\n\ndiplomatic_passages(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.normalized_passages","page":"Reading texts from the repository","title":"EditorsRepo.normalized_passages","text":"Compose an array of CitablePassages for a normalized reading of a text identified by CtsUrn.\n\nnormalized_passages(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.diplomatic_passagetext","page":"Reading texts from the repository","title":"EditorsRepo.diplomatic_passagetext","text":"Collect diplomatic text for a single text passage identified by URN. The URN should either match a citable passage, or be a containing passage for one or more citable passage.  Ranges URNs are not supported.\n\ndiplomatic_passagetext(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.normalized_passagetext","page":"Reading texts from the repository","title":"EditorsRepo.normalized_passagetext","text":"Collect diplomatic text for a text passage identified by URN. The URN should either match a citable passage, or be a containing passage for one or more citable passages.  Ranges URNs are not supported.\n\nnormalized_passagetext(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.textpassages","page":"Reading texts from the repository","title":"EditorsRepo.textpassages","text":"Select from a list passages those URN matching a given URN, and omit \"ref\" passages conventionally used for non-text content.\n\ntextpassages(psgs, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.normalized_tokens","page":"Reading texts from the repository","title":"EditorsRepo.normalized_tokens","text":"Compose an edition of normalized tokens for allt exts in repository.\n\nnormalized_tokens(repo)\n\n\n\n\n\n\nCompose an edition of normalized tokens matching urn.\n\nnormalized_tokens(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.lextokens","page":"Reading texts from the repository","title":"EditorsRepo.lextokens","text":"Compose an edition of lexical tokens matching urn.\n\nlextokens(repo, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"Internal functions:","category":"page"},{"location":"man/texts/","page":"Reading texts from the repository","title":"Reading texts from the repository","text":"EditorsRepo.isref\nEditorsRepo.passage_text\nEditorsRepo.passages_for_tokens\nEditorsRepo.lexpassages_for_tokens","category":"page"},{"location":"man/texts/#EditorsRepo.isref","page":"Reading texts from the repository","title":"EditorsRepo.isref","text":"True if last component of CTS URN passage is \"ref\". MID convention is to exclude elements, like notes on HMT scholia,   with this identifier.\n\nisref(urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.passage_text","page":"Reading texts from the repository","title":"EditorsRepo.passage_text","text":"Collect text from a list of passages for a text passage identified by URN. The URN should either match a citable passage, or be a containing passage for one or more citable passages.  Ranges URNs are not supported.\n\npassage_text(psgs, urn)\n\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.passages_for_tokens","page":"Reading texts from the repository","title":"EditorsRepo.passages_for_tokens","text":"Create a list of CitablePassages from a list of OrthographicTokens  and a passage URN.\n\npassages_for_tokens(tkns, urn)\n\n\nPassage URNs are extended with an additional level of citation for the individual token.  This citation tier is made up of sequential numbers for lexical tokens, and token number + a character for other kinds of tokens (1a, 1b, etc.).\n\n\n\n\n\n","category":"function"},{"location":"man/texts/#EditorsRepo.lexpassages_for_tokens","page":"Reading texts from the repository","title":"EditorsRepo.lexpassages_for_tokens","text":"Create a list of CitablePassages for all lexical tokens in a list of OrthographicTokens  for a given URN.\n\nlexpassages_for_tokens(tkns, urn)\n\n\nPassages URNs are extended with an additional level of citation for the individual token.  This citation tier is made up of sequential numbers for lexical tokens, and token number + a character for other kinds of tokens (1a, 1b, etc.).\n\n\n\n\n\n","category":"function"},{"location":"guide/repository/#Creating-an-EditingRepository","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"","category":"section"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"docsroot = pwd() |> dirname |> dirname\nreporoot = docsroot * \"/data/splitdocs/\"\nburney86root = docsroot * \"/data/burney86/\"\neditionsdir = reporoot * \"editions\"\ndsedir = reporoot * \"dse\"\nconfigdir = reporoot * \"config\"","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"You will work with an EditingRepository which expects to find your work in three directories:","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"a directory with your source editions (typically in XML, or simple Markdown), from which you can generate diplomatic and normalized editions\na directory with delimited-text files indexing citable passages of text to citable regions of an image, and to a physical surface\na directory with configuration files named catalog.cex and citation.cex","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"You can directly supply paths to these three directories:","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"using EditorsRepo\nfullpathrepo = EditingRepository(editionsdir, dsedir, configdir)","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"but if you group the three directories in the same parent directory and give them the default names \"editions\", \"dse\" and \"config\", you can simply pass the parent directory name to the repository function:","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"using EditorsRepo\nrepo = repository(reporoot)","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"The repository function can also optionally take names for any of the three, relative to the parent.","category":"page"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"townley = repository(burney86root; dse = \"indextables\")","category":"page"},{"location":"guide/repository/#The-data-in-these-examples","page":"Creating an EditingRepository","title":"The data in these examples","text":"","category":"section"},{"location":"guide/repository/","page":"Creating an EditingRepository","title":"Creating an EditingRepository","text":"The datasets used in this walkthrough are in the EditorsRepo.jl github repository at https://github.com/HCMID/EditorsRepo.jl/tree/main/docs/data/.","category":"page"},{"location":"#EditorsRepo.jl","page":"Home","title":"EditorsRepo.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = EditorsRepo","category":"page"},{"location":"","page":"Home","title":"Home","text":"Manage editing of digital scholarly editions.","category":"page"},{"location":"","page":"Home","title":"Home","text":"docsroot = pwd() |> dirname\nreporoot = docsroot * \"/data/splitdocs/\"","category":"page"},{"location":"","page":"Home","title":"Home","text":"EditorsRepo.jl lets you work with files of editing work in progress in a local file system using more abstract structures such as \"a corpus of citable texts\" (CitableText.Corpus) or \"a record associating texts, image and physical surface\" (from the CitablePhysicalText module).","category":"page"},{"location":"","page":"Home","title":"Home","text":"One important application built with EditorsRepo.jl is the Pluto notebook providing interactive validation and verification of work in progress.  The next section of this documentation illustrates most of the functionality of EditorsRepo.jl by walking you through how the MID validator notebook uses the module.","category":"page"},{"location":"#Briefest-possible-example","page":"Home","title":"Briefest possible example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Create an EditingRepository.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using EditorsRepo\nrepo = repository(reporoot)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Collect a corpus of normalized texts from the repository.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using CitableText, CitableCorpus\nurn = CtsUrn(\"urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1\")\nnormalized_passages(repo, urn) |> CitableTextCorpus","category":"page"}]
}
