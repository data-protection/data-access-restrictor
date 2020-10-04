local io = require "io"
local json_parser = require "json_parser"

function read(path)
  local file = assert(io.open(path, "r"))
  local result = file:read("*a")
  file:close()
  return result
end

json_parser:ensure_nonnegative_values(read("/config/rate_limited_uris.json"), ngx.shared.restricted_uris)
json_parser:ensure_nonnegative_values(read("/state/last_access.json"), ngx.shared.last_access)
