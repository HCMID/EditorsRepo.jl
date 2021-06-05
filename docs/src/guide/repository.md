# Creating an `EditingRepository`

```@setup sample1
docsroot = pwd() |> dirname |> dirname
reporoot = docsroot * "/data/splitdocs/"
burney86root = docsroot * "/data/burney86/"
editionsdir = reporoot * "editions"
dsedir = reporoot * "dse"
configdir = reporoot * "config"
```


You will work with an `EditingRepository` which expects to find your work in three directories:

1. a directory with your source editions (typically in XML, or simple Markdown), from which you can generate diplomatic and normalized editions
2. a directory with delimited-text files indexing citable passages of text to citable regions of an image, and to a physical surface
3. a directory with configuration files named `catalog.cex` and `citation.cex`

You can directly supply paths to these three directories:

```@example sample1
using EditorsRepo
fullpathrepo = EditingRepository(editionsdir, dsedir, configdir)
```



but if you group the three directories in the same parent directory and give them the default names "editions", "dse" and "config", you can simply pass the parent directory name to the `repository` function:

```@example sample1
using EditorsRepo
repo = repository(reporoot)
```

The `repository` function can also optionally take names for any of the three, relative to the parent.

```@example sample1
using EditorsRepo

townley = repository(burney86root; dse = "indextables")
```
