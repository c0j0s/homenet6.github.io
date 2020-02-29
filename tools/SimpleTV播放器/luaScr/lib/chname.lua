dofile (m_simpleTV.MainScriptDir .. "lib/channel_filter.lua")

function ChangeChannelName(OldName,MassNames)

if MassNames==nil then MassNames=DefaultMassNames end

local i = 1
local  tmp

while true do

 if MassNames[i] == nil then break end
 tmp = MassNames[i][1]
 if tmp == nil then break end

 if tmp==OldName then

   OldName = MassNames[i][2]
   break;
 end
 i = i+1
end

return OldName
end

