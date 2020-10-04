local RateLimiter = {};

function RateLimiter:getLastAccessForUri(last_access_dict, uri)
  return last_access_dict:get(uri)
end

function RateLimiter:addLastAccessForUri(last_access_dict, uri)
  last_access_dict:set(uri, os.time())
end

function RateLimiter:timeOutPassed(last_access, rate_limit)
  if last_access == nil then
    return true
  end
  local now = os.time()
  local time_since_last_request = now - last_access
  local rate_limit_seconds = RateLimiter:hoursToSeconds(rate_limit)
  local time_remaining = rate_limit_seconds - time_since_last_request
  return time_since_last_request >= rate_limit_seconds, time_remaining
end

function RateLimiter:reject(time_remaining)
  ngx.header["Content-Type"] = "text/plain"
  ngx.header["X-RateLimit:Limit"] = "1" -- maximum requests per time period
  ngx.header["X-RateLimit-Remaining"] = "0"
  ngx.header["X-RateLimit-Reset"] = string.format("%.1f", time_remaining / 3600) .. " seconds"
  ngx.log(ngx.STDERR, "requested too often; request got rate limited")
  ngx.exit(ngx.HTTP_TOO_MANY_REQUESTS)
end

function RateLimiter:toSeconds(days, hours, minutes, seconds)
  return hours * 60 * 60;
end

function RateLimiter:hoursToSeconds(hours)
  return hours * 60 * 60;
end

return RateLimiter;
