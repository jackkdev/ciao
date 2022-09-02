--- Mysqloo implementation of the [`SchemaBuilder`].

ciao = ciao or {}
ciao.impl = ciao.impl or {}
ciao.impl.mysqloo = ciao.impl.mysqloo or {}

local SchemaBuilder = ciao.class("impl.mysqloo.SchemaBuilder", ciao.abst.SchemaBuilder)

function SchemaBuilder:initialize()
end

do
  local f = "CREATE TABLE IF NOT EXISTS `%s` (%s);"

  local kind_handlers = {
    ["string"] = function(options)
      return (options.length and "VARCHAR(" .. tostring(options.length) .. ")" or "TEXT")
    end,
    ["number"] = function(options)
      return "INTEGER"
    end,
    ["boolean"] = function(options)
      return "BOOLEAN"
    end,
    ["table"] = function(options)
      return "TEXT"
    end,
  }

  local option_handlers = {
    ["primary"] = function(value)
      return value and "PRIMARY KEY" or ""
    end,
    ["unique"] = function(value)
      return value and "UNIQUE" or ""
    end,
    ["nullable"] = function(value)
      return value and "" or "NOT NULL"
    end,
    ["auto_increment"] = function(value)
      return value and "AUTO_INCREMENT" or ""
    end
  }

  function SchemaBuilder:build(schema)
    local name = schema:get_name()
    local fields = schema:get_fields()

    local fields_q = ""
    for _, field in ipairs(fields) do
      local ty = kind_handlers[field.kind](field.options)

      local options_q = ""
      for option, value in pairs(field.options) do
        local option_handler = option_handlers[option]
        if not option_handler then continue end
        local option_q = option_handler(value)
        if option_q ~= "" then
          options_q = options_q .. " " .. option_q
        end
      end

      fields_q = fields_q .. "`" .. field.key .. "` " .. ty .. options_q .. ", "
    end

    return f:format(name, fields_q:sub(1, -3))
  end
end

ciao.impl.mysqloo.SchemaBuilder = SchemaBuilder