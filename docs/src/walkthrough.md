# A fuller walkthrough

```@setup walkthrough
ghroot = pwd() |> dirname
```

!!! note 

    The examples in this walkthrough use sample data in the `test/data` directory of this package's github repository.


## Define a repository

An `EditingRepository` works with three kinds of data: text editions, indexes of text passages to images and physical surfaces, and configuration data specifying how to transform the edition files into citable texts. The repository expects each type of data to be managed in a separate directory.  By default, their names are `editions`, `config` and `dse`.

```@setup walkthrough
repopath = joinpath(ghroot, "test", "data", "splitdocs")
using EditorsRepo
repo = repository(repopath)
```

You can optionally provide non-default names for any of these three directories.

```@setup walkthrough
path = joinpath(ghroot, "test", "data", "mixedrepo")
repository(path, editions = "editing")
```
