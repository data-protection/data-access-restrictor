local interval = 300;
local json_persister = require("json_persister");

assert(ngx.timer.every(interval, json_persister.store_json, "/state/last_access.json", ngx.shared.last_access))
