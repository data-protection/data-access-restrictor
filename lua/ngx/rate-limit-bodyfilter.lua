if ngx.status == 200 then
  ngx.log(ngx.INFO, "request was forwarded successfully, saving last access")
  ngx.shared.last_access:set(ngx.var.request_path, os.time())
end
