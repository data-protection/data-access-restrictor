describe("Duration", function()
    local Duration = {}
    before_each(function ()
        Duration = require("../src/duration")
    end)

    it("should parse all", function()
        days, hours, minutes, seconds = Duration:parse("P1DT2H3M4S");
        assert.are.same(1, days);
        assert.are.same(2, hours);
        assert.are.same(3, minutes);
        assert.are.same(4, seconds);
    end)

    it("should parse only one", function()
        days, hours, minutes, seconds = Duration:parse("P1H");
        assert.are.same(0, days);
        assert.are.same(1, hours);
        assert.are.same(0, minutes);
        assert.are.same(0, seconds);
    end)

    it("should fail if wrong format", function()
        assert.has_error(function() Duration:parse("P1S1H") end, "wrong duration format")
    end)
end)
