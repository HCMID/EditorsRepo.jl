# Orthography


```@setup ortho
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```

We want to test whether the text is valid within the configured orthographic system.

We can get a DataFrame with the citation data like this 

```@example ortho
textconfig = citation_df(townley)
```

To find the correct orthography for a passage, we'll use `baseurn` to clean up any range or subreference annotations.

```@example ortho
using CitableText
urn = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.burney86:8.title")
tidy = EditorsRepo.baseurn(urn)
```

Get the orthography for our passage:

```@example ortho
ortho = orthographyforurn(textconfig, tidy)
```

We'll validate the orthography by white-spaced chunks to make it easy to display and read in the notebook.


```@example ortho
chunks = normednodetext(townley, tidy) |> split
```

The validator notebook then uses the Orthography.jl module's `validstring` function to determine how to display the chunk.



```@example ortho
using Orthography, ManuscriptOrthography
validstring(ortho, chunks[1])
```