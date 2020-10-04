local json_persister = {}

function json_persister:store_json(filename, dictionary)
  local io = require "io"
  local file = assert(io.open(filename .. ".tmp", "w+"))
  local cjson = require "cjson"
  local representation = {}

  for _, key in pairs(dictionary:get_keys(0)) do
    representation[key] = dictionary:get(key)
  end
  file:write(cjson.encode(representation))
  file:close()
  os.rename(filename .. ".tmp", filename)
end

return json_persister
