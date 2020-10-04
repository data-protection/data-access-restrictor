describe("RateLimit", function()
  local RateLimit = {}
  before_each(function ()
    RateLimit = require("../src/ratelimit")
  end)

  it("should convert to seconds", function()
    local oneHourInSeconds = RateLimit:hoursToSeconds(1);
    assert.are.same(60*60, oneHourInSeconds)
  end)
end)
