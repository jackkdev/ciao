ciao = ciao or {}

local Schema = ciao.class("Schema")

function Schema:initialize(name)
  self.name_ = name
  self.fields_ = {}
end

function Schema:get_name()
  return self.name_
end

function Schema:get_fields()
  return self.fields_
end

do
  local allowed_types = {
    "string",
    "number",
    "boolean",
    "table",
  }

  for _, kind in pairs(allowed_types) do
    Schema[kind] = function(self, key, options)
      options = options or {}

      table.insert(self.fields_, {
        kind = kind,
        key = key,
        options = options,
      })

      return self
    end
  end
end

ciao.Schema = Schema

local s = Schema:new("test")

s
  :string("steamid", { primary = true, nullable = false, length = 17 })
  :number("money", { nullable = false })
  :table("stats", { nullable = true })

local sb = ciao.impl.mysqloo.SchemaBuilder:new()
print(sb:build(s))