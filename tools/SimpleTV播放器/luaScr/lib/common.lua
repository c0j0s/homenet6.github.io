math.randomseed( os.time() ) 
m_simpleTV.user = {}
dofile (m_simpleTV.MainScriptDir .. "lib/chname.lua")
dofile (m_simpleTV.MainScriptDir .. "lib/executehelper.lua")
dofile (m_simpleTV.MainScriptDir .. "lib/XmlParser.lua")
dofile (m_simpleTV.MainScriptDir .. 'lib\\jsdecode\\jsUnpacker.lua')
----------------------------------------------------------------------------------
function findpattern(text, pattern, start,delstart,delend)

  local i,t = string.find(text, pattern, start)
  if i == nil then return nil end
  return string.sub(text, i+delstart,t - delend)

end
----------------------------------------------------------------------------------
function debug_in_file( output_str , filename, setnew )

 if filename == nil then filename = 'C:\\LuaDebug.txt' end

 local fhandle
 if setnew ~= nil then
    fhandle = io.open (filename , "w+")
  else 
  fhandle = io.open (filename , "a+")
 end
 
 fhandle:write(output_str)
 fhandle:close()

end
----------------------------------------------------------------------------------
function unescape (s)
  s = string.gsub(s, "%%(%x%x)", function (h) return string.char(tonumber(h, 16)) end)
 return s
end
----------------------------------------------------------------------------------
function escape (s)
      s = string.gsub(s, '.', function (c)
            return string.format("%%%02X", string.byte(c))
          end)
      return s
 end
----------------------------------------------------------------------------------
function unescape1 (s)
  s = string.gsub(s, "\\u04(%x%x)", function (h)
         local s = tonumber(h,16)
		  if s < 64 then
		           return string.char(0xD0,s+0x80)
		   else return string.char(0xD1,s+0x40)
		  end
		 end)
 return s
end
----------------------------------------------------------------------------------
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end
----------------------------------------------------------------------------------
function decode64(data)
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end
------------------------------------------------------------------------------------
function encode64(data)
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
------------------------------------------------------------------------------------




