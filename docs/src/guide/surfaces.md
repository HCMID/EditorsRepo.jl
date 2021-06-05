# Surfaces

We validate and verify our work in progress one surface at a time.


Get a list of surfaces appearing in this repository's DSE tables



```@setup surfaces
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```



```@example surfaces
surfs = surfaces(townley)
```
