# DSE accuracy

```@setup dse
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```

Get a DataFrame of DSE records

```@example dse
surfdse = surfaceDse(townley, surface)
```
