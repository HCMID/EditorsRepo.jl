# EditorsRepo.jl Documentation
```@meta
CurrentModule = EditorsRepo
```
```@contents
```
## Types
```@docs
EditingRepository
```

## Functions
```@docs
dsefiles(repository::EditingRepository)
dse_df(repository::EditingRepository)
xmlfiles(repository::EditingRepository)
textcatalog(repo, catalogname::AbstractString, delimiter::AbstractString="|")
surfaces(repo::EditingRepository)
passages(repo::EditingRepository)
images(repo::EditingRepository)
xmlfiles_df(repository::EditingRepository)
citation_df(repo::EditingRepository)
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
diplomaticnodes(repo, urn)
normalizednodes(repo, urn)
```
## Index
```@index
```
