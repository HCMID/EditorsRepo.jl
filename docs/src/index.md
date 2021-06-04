# EditorsRepo.jl
```@meta
CurrentModule = EditorsRepo
```


>  *Manage content in an editorial repository organized following HCMID conventions.*

```@setup sample1
docsroot = pwd() |> dirname
reporoot = docsroot * "/data/splitdocs/"
```


The goal of the EditorsRepo.jl package is to bridge the gap between a local file system of editing work in progress, and more general structures such as "a corpus of citable texts" (`CitableTextCorpus`) or "a record associating texts, image and physical surface" (from the `Dse` package).



## Briefest possible example



Create an `EditingRepository`.


```@example sample1
using EditorsRepo
repo = EditingRepository(reporoot, "editions", "dse", "config")
```

Collect a corpus of normalized texts from the repository.


```@example sample1
using CitableText, CitableCorpus
urn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1")
normalizednodes(repo, urn) |> CitableTextCorpus
```

## More information


```@contents
Pages = ["guide/guide.md", "man/index.md", "man/textcatalog.md", "man/texts.md"]
```
