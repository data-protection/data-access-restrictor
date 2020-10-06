if ngx.var.request_method == "PUT" then
  local duration = require("duration")
  days, hours, minutes, seconds = duration:parse(ngx.var.rate)

  local rate = (((days * 60 + hours) * 60) + minutes) * 60 + seconds
  if (rate == nil) or (rate <= 0) then
    ngx.log(ngx.STDERR, "rate cannot be parsed or negative")
    ngx.exit(ngx.HTTP_BAD_REQUEST)
  end
  ngx.shared.restricted_uris:set(ngx.var.configure_uri, rate)
  ngx.log(ngx.INFO, "added rate limit for uri " .. ngx.var.configure_uri .. " with rate " .. rate)
elseif ngx.var.request_method == "DELETE" then
  ngx.shared.restricted_uris:delete(ngx.var.configure_uri)
  ngx.log(ngx.INFO, "deleted rate limit for uri " .. ngx.var.configure_uri)
  ngx.shared.last_access:delete(ngx.var.configure_uri)
else
  ngx.log(ngx.STDERR, "only PUT and DELETE requests allowed")
  ngx.exit(ngx.HTTP_NOT_ALLOWED)
end

local json_persister = require("json_persister")
json_persister:store_json("/config/rate_limited_uris.json", ngx.shared.restricted_uris)
