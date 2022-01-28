# DSE accuracy

```@setup dse
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```

To verify the accuracy of DSE indexing, the validator notebook juxtaposes, for each indexed passage, the indexed region of the image with a diplomatic text of the passage.


We'll get a DataFrame of DSE records for the surface, as we did in constructing a view for completeness.

```@example dse
using CitableObject
surface = Cite2Urn("urn:cite2:hmt:burney86pages.v1:73r")

surfdse = surfaceDse(townley, surface)
```


For each row in the DSE DataFrame, the notebook uses the `CitableImage.jl` module to embed an image of the selected region.

To collect the diplomatic text for a passage, use the `diplomatic_passagetext` function.


```@example dse
using CitableText
psg = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.burney86:8.title")
diplomatic_passagetext(townley, psg)
```