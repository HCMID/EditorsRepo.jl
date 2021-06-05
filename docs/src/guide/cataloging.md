# Cataloging


```@setup cataloging
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
```

Use same repository as before.


```@example cataloging
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```

Get a DataFrame with citation info

```@example cataloging
cites = citation_df(townley)
```

Test if files in catalog match those in editing directory

```@example cataloging
filesmatch(townley, cites)
```

Other functions list differences between files found and files cataloged.