describe("JsonParser", function()
  local JsonParser = {}
  before_each(function ()
    JsonParser = require("../src/json_parser")

    mockedNgxDict = {}
    function mockedNgxDict:get (key)
      return mockedNgxDict[key]
    end
    function mockedNgxDict:set (key, val)
      mockedNgxDict[key] = val
    end
    function mockedNgxDict:dropFunctions ()
      mockedNgxDict['set'] = nil
      mockedNgxDict['get'] = nil
      mockedNgxDict['dropFunctions'] = nil
    end
  end)

  it("should pass table", function()
    local expected = JsonParser:ensure_nonnegative_values('{"test1":1, "test2":2}', mockedNgxDict)
    expected:dropFunctions()
    assert.are.same({["test1"] = 1., ["test2"] = 2.}, expected)
  end)

  it("it should return empty dictionary when empty file", function()
    local expected = JsonParser:ensure_nonnegative_values('', mockedNgxDict)
    expected:dropFunctions()
    assert.are.same({}, expected)
  end)
end)
