# API documentation


## The basic Type

The starting point for EditorsRepo.jl is a directory in a local file system that includes subdirectories for standard kinds of content: editions of texts, indexing of texts to citable images and surfaces, and configuration files.


```@docs
EditingRepository
repository
configdir
dsedir
editionsdir
```

Text configuration:

```@docs
citationconfig
filename
o2converter,
diplomaticbuilder
normalizedbuilder
orthography
```    

Text catalog and contents:

```@docs
textcatalog
texturns
archivalcorpus
diplomaticcorpus
normalizedcorpus
```

Classified tokenization:

```@docs
tokencorpus
```

DSE records:

```@docs
dsetriples
```

HTML utilities:

```@docs
htmltoken
```

## Internal functions

```@docs
EditorsRepo.xmlfiles
EditorsRepo.textpassages
EditorsRepo.isref
EditorsRepo.passages_for_tokens
EditorsRepo.tokenanalysis
```