# EditorsRepo.jl
```@meta
CurrentModule = EditorsRepo
```


>  *Manage editing of digital scholarly editions.*

```@setup sample1
docsroot = pwd() |> dirname
reporoot = docsroot * "/data/splitdocs/"
```

EditorsRepo.jl lets you work with files of editing work in progress in a local file system using more abstract structures such as "a corpus of citable texts" (`CitableText.Corpus`) or "a record associating texts, image and physical surface" (from the `CitablePhysicalText` module).

One important application built with EditorsRepo.jl is the Pluto notebook providing interactive validation and verification of work in progress.  The next section of this documentation illustrates most of the functionality of EditorsRepo.jl by walking you through how the MID validator notebook uses the module.




## Briefest possible example



Create an `EditingRepository`.


```@example sample1
using EditorsRepo
repo = repository(reporoot)
```

Collect a corpus of normalized texts from the repository.


```@example sample1
using CitableText, CitableCorpus
urn = CtsUrn("urn:cts:greekLit:tlg5026.e3.hmt:10.124r_1")
normalized_passages(repo, urn) |> CitableTextCorpus
```

