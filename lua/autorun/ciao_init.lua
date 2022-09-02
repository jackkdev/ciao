---
--- ciao v0.1.0 - A Garry's Mod ORM.
---

if not SERVER then return end

ciao = ciao or {
  __version = "0.1.0",
  __author = "jackk",
}

include("ciao/class.lua")

include("ciao/abst/schema_builder.lua")
include("ciao/impl/mysqloo/schema_builder.lua")

include("ciao/schema.lua")