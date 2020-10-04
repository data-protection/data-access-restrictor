local cjson = require "cjson"

local json_parser = {}

function json_parser:ensure_nonnegative_values(text, dictionary)
  if text == '' then
    return dictionary
  end

  for key, value in pairs(cjson.decode(text)) do
    assert(value > 0, "error, found negative waiting period")
    dictionary:set(key, value)
  end
  return dictionary
end

return json_parser
