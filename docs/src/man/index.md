# API documentation

The starting point for EditorsRepo.jl is a directory in a local file system that includes subdirectories for standard kinds of content: editions of texts, indexing of texts to citable images and surfaces, and configuration files.

## Types

```@docs
EditingRepository
```

## Extracting high-level data from the repository

```@docs
```

## Functions
```@docs
citation_df(repo::EditingRepository)
missingcitation(repo::EditingRepository)
filename(df, u)
o2converter(df, u)
diplomaticbuilder(df, u)
normalizedbuilder(df, u)
orthography(df, u)
textforurn(repo, u)
ohco2forurn(textconfig, urn)
orthographyforurn(textconfig, urn)
diplomaticforurn(textconfig, urn)
normalizerforurn(textconfig, urn)
filesmatch(repo, textconfig)
catalogonly(catalogedtexts, textconfig)
citedonly(repo, textconfig)
textcatalog(repo, catalogname::AbstractString, delimiter::AbstractString="|")
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

