local rate_limit = ngx.shared.restricted_uris:get(ngx.var.request_path)

if rate_limit == nil then
  ngx.log(ngx.INFO, "uri not rate limited")
  return
end

local ratelimit = require "ratelimit"
local last_access = ratelimit:getLastAccessForUri(ngx.shared.last_access, ngx.var.request_path)

local allowed, time_remaining = ratelimit:timeOutPassed(last_access, rate_limit)
if not allowed then
  ratelimit:reject(time_remaining)
end
