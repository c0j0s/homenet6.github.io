local base = _G

module ('playlistparse')

-------------------------------------------------------------------------------------
function SaveXml(hfile,XmlObject)

local xmlstr = XmlObject:strnoencode()
if xmlstr==nil then return false end

hfile:write('<?xml version="1.0" encoding="utf-8"?>')
--hfile:write('<?xml version="1.0"?>')
--hfile:write('<?xml version="1.0" encoding="windows-1251"?>')
--hfile:write('<?xml version="1.0" encoding="iso-8859-1"?>')


hfile:write(xmlstr)
return true
end
-------------------------------------------------------------------------------------
function CreateEmptyXml()

local SimpleTVXml = base.xml.new('SimpleTVXml')

if SimpleTVXml==nil then return nil end

SimpleTVXml.ver = "1.0"

local playlistXml = SimpleTVXml:append("playlist")

return SimpleTVXml,playlistXml

end
-------------------------------------------------------------------------------------

--load and parse m3U format playlist into XML
function ParseM3u(infile, ExtFilter,TypeMedia)


local fhandle = base.io.open (infile , "r")
if fhandle==nil then return end

fhandle:seek ("set",0)

local StrFile = fhandle:read("*l")

while true do
StrFile = fhandle:read("*l")
if StrFile == nil then return nil end
if StrFile:find('#EXTM3U') == nil then break end
end


local mainxml,xmlpls = CreateEmptyXml()

if xmlpls==nil then return nil end

local channelnode
local nameC,urlC,tmpU,NumberStr,LastGroup

LastGroup = nil
NumberStr = -1

--default arguments
if base.type(TypeMedia)~='string' then TypeMedia=nil end
if base.type(ExtFilter)~='string' then ExtFilter=nil end

while true do

tmpC = fhandle:read("*l")
if tmpC == nil then break end

 if tmpC:find('%S') ~= nil  then

	 urlC = fhandle:read("*l")  --URL
	 if urlC==nil then break end

	   tmpU = base.findpattern(tmpC,'^#EXTINF:[%d%-]',1,8,0)
	   if tmpU ~= nil then
		   NumberStr = base.tonumber(tmpU)
		   if NumberStr == nil then NumberStr=-1 end

		   tmpU = base.findpattern(tmpC,'group%-title%=%b""',1,13,1)
		   if tmpU ~= nil then LastGroup = tmpU end

		   nameC = base.findpattern(tmpC,',.+',1,1,0)


		   channelnode = xmlpls:append("channel")
		   if channelnode==nil then return nil end

		   channelnode.Name = TestforSpecialSimbol(nameC)
		   channelnode.Adress = TestforSpecialSimbol(urlC)
		   if NumberStr~=0 and NumberStr~=-1 then channelnode.Number='' .. NumberStr end

		   if LastGroup~=nil then channelnode.GroupName = TestforSpecialSimbol(LastGroup) end
           if ExtFilter~=nil then channelnode.ExtFilterName = TestforSpecialSimbol(ExtFilter) end

		   if TypeMedia~=nil then channelnode.TypeMedia = TypeMedia end

	   end

 end

end --while

fhandle:close()

return mainxml
end
-----------------------------------------------------------------------------------------------------------
function TestforSpecialSimbol(instr)

if base.type(instr)~='string' then return '' end

local outstr
outstr = instr:gsub('&','&amp;')
outstr = outstr:gsub('"','&quot;')
outstr = outstr:gsub('<','&lt;')
outstr = outstr:gsub('>','&gt;')
outstr = outstr:gsub("'",'&apos;')

return outstr

end

-----------------------------------------------------------------------------------------------------------
