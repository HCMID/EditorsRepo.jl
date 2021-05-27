# API documentation


## The basic Type

The starting point for EditorsRepo.jl is a directory in a local file system that includes subdirectories for standard kinds of content: editions of texts, indexing of texts to citable images and surfaces, and configuration files.


```@docs
EditingRepository
```


## And still more

```@docs
textforurn(repo, u)

catalogonly(catalogedtexts, textconfig)
citedonly(repo, textconfig)

xmlfiles(repository::EditingRepository)
xmlfiles_df(repository::EditingRepository)
diplomaticnodes(repo, urn)
normalizednodes(repo, urn)
dsefiles(repository::EditingRepository)
dse_df(repository::EditingRepository)
surfaces(repo::EditingRepository)
passages(repo::EditingRepository)
images(repo::EditingRepository)
```

