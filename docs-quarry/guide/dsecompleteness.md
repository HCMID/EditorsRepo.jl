# DSE completeness

```@setup dse
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```

To verify the *completeness* of indexing for a given surface, the Pluto notebook needs the DSE records for that surface.  Here's how to get a DataFrame of DSE triples.

```@example dse
using CitableObject
surface = Cite2Urn("urn:cite2:hmt:burney86pages.v1:73r")

surfdse = surfaceDse(townley, surface)
```

Note this.

!!! note

    The validator notebook then uses the `CitableImage` library to construct URLs overlaying regions indexed on this page to the HMT image citation tool.  They look like <http://www.homermultitext.org/ict2/?urn=urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f073r@0.1703,0.3014,0.3983,0.03259&>.  See the [documentation for the CitableImage.jl module](https://cite-architecture.github.io/CitableImage.jl/stable/).



DSE accuracy is more complex.