--get adress
if m_simpleTV.Control.ChangeAdress ~= 'No' then return end

if m_simpleTV.Config.GetConfigInt(m_simpleTV.Defines.ID_PROXY_USE)~=1 then return end

local proxyip=m_simpleTV.Config.GetConfigString(m_simpleTV.Defines.ID_PROXY_IP)
local proxyport=m_simpleTV.Config.GetConfigString(m_simpleTV.Defines.ID_PROXY_PORT)
local inAdr =  m_simpleTV.Control.CurrentAdress

--local inAdr = "rtp://@233.33.210.92:5050"
--local proxyip="111.222.333.444"
--local proxyport="1234"

if inAdr==nill then return end

local tmpName,tmpOut

if not string.match( proxyip, 'http://' ) then proxyip = 'http://' .. proxyip end
tmpOut = proxyip 
if proxyport==nil or proxyport=='' then 
      do end
else
   tmpOut = tmpOut ..":" .. proxyport
end

tmpName = findpattern(inAdr,"^rtp://@",1,7,-256)

if tmpName~=nil then
   tmpOut = tmpOut .. "/udp/" .. tmpName
   m_simpleTV.Control.ChangeAdress='Yes'
   m_simpleTV.Control.CurrentAdress = tmpOut
   return
end

tmpName = findpattern(inAdr,"^udp://@",1,7,-256)
if tmpName~=nil then
   tmpOut = tmpOut .. "/udp/" .. tmpName
   m_simpleTV.Control.ChangeAdress='Yes'
   m_simpleTV.Control.CurrentAdress = tmpOut
   return
 
end
