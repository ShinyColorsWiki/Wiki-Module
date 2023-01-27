Scribunto Module Repository
===========================
[![codecov](https://codecov.io/github/ShinyColorsWiki/Wiki-Module/branch/master/graph/badge.svg?token=36H6NZDYNF)](https://codecov.io/github/ShinyColorsWiki/Wiki-Module)

This Repository contains Modules of Shinycolors Wiki.

Directory listing is like:
```dir
/doc                    # contains Documentation (with Mediawiki Format.)
/src
 - [name].lua           # A various scripts of `Module:[name]`
/spec
 - [name]_spec.lua      # contains test suite
```

Test Suite
==========
Test Suite using
* [LuaCheck] for linting and static analyzing.
* [busted](https://olivinelabs.com/busted/) for unit testing.

Install both with `luarocks` to run test.

| Module Name | Wiki Page |
|-------------|-----------|
| CardCode    | `Module:CardCode` |
| Skill       | `Module:Skill`    |
|             |           |