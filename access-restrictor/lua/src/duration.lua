local Duration = {};

function Duration:parse(duration)
    assert(string.match(duration, "^P(%d*)D?T?(%d*)H?(%d*)M?(%d*)S?$"), "wrong duration format");
    days = tonumber(string.match(duration, "^P(%d*)D")) or 0;
    hours = tonumber(string.match(duration, "(%d*)H")) or 0;
    minutes = tonumber(string.match(duration, "(%d*)M")) or 0;
    seconds = tonumber(string.match(duration, "(%d*)S$")) or 0;
    return days, hours, minutes, seconds;
end

return Duration;
