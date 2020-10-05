function parse_duration(input)
  -- TODO: make parts optional
  days, hours, minutes, seconds = string.match(input, "^P(%d*)DT(%d*)H(%d*)M(%d*)S$")
  assert(days or hours or minutes or seconds)

  return tonumber(days) or 0,tonumber(hours) or 0, tonumber(minutes) or 0, tonumber(seconds) or 0
end

if ngx.var.request_method == "GET" then
  local cjson = require "cjson"
  local representation = {}

  for _, key in pairs(ngx.shared.restricted_uris:get_keys(0)) do
    representation[key] = ngx.shared.restricted_uris:get(key)
  end

  ngx.status = ngx.HTTP_OK
  ngx.header.content_type = "application/json; charset=utf-8"
  ngx.say(cjson.encode(representation))
  return ngx.exit(ngx.HTTP_OK)
else
  ngx.log(ngx.STDERR, "only GET requests allowed")
  ngx.exit(ngx.HTTP_NOT_ALLOWED)
end
