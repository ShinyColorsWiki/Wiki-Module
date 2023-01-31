# Scribunto Module Repository
[![codecov](https://codecov.io/github/ShinyColorsWiki/Wiki-Module/branch/master/graph/badge.svg?token=36H6NZDYNF)](https://codecov.io/github/ShinyColorsWiki/Wiki-Module)

This Repository contains Modules of Shinycolors Wiki.

## Directory listing
```dir
/doc 
 - [name].txt           # Documentation of [name].lua (with Mediawiki Format.)
/src
 - [name].lua           # A various scripts of `Module:[name]`
/spec
 - [name]_spec.lua      # test suite for each [name].lua
```

## Test Suite

Test Suite using
* [LuaCheck] for linting and static analyzing.
* [busted](https://olivinelabs.com/busted/) for unit testing.

Install both with `luarocks` to run test.

| Module Name | Wiki Page |
|-------------|-----------|
| CardCode    | `Module:CardCode` |
| Skill       | `Module:Skill`    |
|             |           |

## License

### `src/*` and `doc/*` 
`CC BY-NC-SA 4.0` (Shinycolors wiki's license)

See [LICENSE-CC-BY-NC_SA.40.md](LICENSE-CC-BY-NC-SA-4.0.md)

### Other than `src*` and `doc/*`
MIT License

Copyright (c) 2022-present ShinyColorsWiki and contributers

See [LICENSE](LICENSE)
