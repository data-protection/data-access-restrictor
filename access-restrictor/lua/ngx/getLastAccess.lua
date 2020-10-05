if ngx.var.request_method == "GET" then
  -- TODO: use uri provided
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
