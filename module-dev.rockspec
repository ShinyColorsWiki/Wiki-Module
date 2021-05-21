package = "module"
version = "dev"
source = {
   url = ""
}
description = {
   summary = "A module repository of shinycolors.wiki",
   detailed = [[
A Mediawiki Scribunto Module Repository for Shinycolors Wiki.
]],
   homepage = "",
   license = "CC-BY-NC-SA-4.0"
}
dependencies = {
   "lua >= 5.1, < 5.2",
}
build = {
   type = "builtin",
}