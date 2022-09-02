--- The [`SchemaBuilder`] takes an existing [`Schema`] and converts it into a backend-specific
--- statement which can be used to create the [`Schema`] within the database.

ciao = ciao or {}
ciao.abst = ciao.abst or {}

local SchemaBuilder = ciao.class("abst.SchemaBuilder")

function SchemaBuilder:initialize()
end

function SchemaBuilder:build(schema)
  error("not implemented")
end

ciao.abst.SchemaBuilder = SchemaBuilder