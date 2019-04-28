#!/usr/bin/env lua

function totime(datestr)
	local r = os.date("*t")
	r["wday"] = nil
	r["yday"] = nil
	local h, m, s = datestr:match("(%d+):(%d+):(%d+)")
	if h and m and s then
		r["hour"] = h
		r["min"] = m
		r["sec"] = s
	else
		h, m = datestr:match("(%d+):(%d+)")
		if h and m then
			r["hour"] = h
			r["min"] = m
			r["sec"] = 0
		end
	end
	local y, i, d = datestr:match("(%d+)-(%d+)-(%d+)")
	if y and i and d then
		r["year"] = y
		r["month"] = i
		r["day"] = d
	end
	return r
end

function at(timespec, cmd)
	delay = os.time(timespec) - os.time();
	if delay > 0 then
		print("Sleeping for " .. delay .. " seconds");
		os.execute("sleep " .. delay);
		os.execute(cmd)
	else
		print("Event was " .. delay .. " seconds in the past")
	end
end

local datestr, cmd = ...
if not datestr then
	print("No time specified")
elseif not cmd then
	print("No command specified")
else
	at(totime(datestr), cmd)
end
