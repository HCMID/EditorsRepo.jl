# EditorsRepo.jl


>  *Manage editing of digital scholarly editions.*

```@setup sample1
ghroot = pwd() |> dirname

```

EditorsRepo.jl lets you work with files of editing work in progress in a local file system using more abstract structures such as "a corpus of citable texts" (`CitableText.Corpus`) or "a record associating texts, image and physical surface" (from the `CitablePhysicalText` module).

One important application built with EditorsRepo.jl is the Pluto notebook providing interactive validation and verification of work in progress. (You can find it in the `notebooks` directory of the template github repository [here](https://github.com/HCMID/validatormodel).)


## Briefest possible example

Create an `EditingRepository` by giving the `repository` function the root directory of your editing repository.


```@example sample1
repopath = joinpath(ghroot, "data", "splitdocs")
using EditorsRepo
repo = repository(repopath)
```




Collect a corpus of normalized texts from the repository.


```@example sample1
using CitableText, CitableCorpus
normalizedcorpus(repo)
```


