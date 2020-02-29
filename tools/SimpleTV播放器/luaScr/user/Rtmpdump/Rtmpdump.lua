--get address
require'ex'
require 'json'

if m_simpleTV.Control.ChangeAdress ~= 'No' then return end

local inAdr =  m_simpleTV.Control.CurrentAdress
if inAdr==nill then return end


if not string.match(package.path,'user\\Rtmpdump\\core' , 0)  then
	package.path = package.path .. ';' .. m_simpleTV.MainScriptDir .. 'user\\Rtmpdump\\core\\?.lua'
end


local pathname = m_simpleTV.MainScriptDir .. "user\\Rtmpdump\\"


for entry in os.dir(pathname) do

  if string.match(entry.name,'.lua') and not string.match(entry.name,'Rtmpdump.lua') then

	 dofile (m_simpleTV.MainScriptDir .. "user\\Rtmpdump\\" .. entry.name)

	 if m_simpleTV.Control.ChangeAdress ~= 'No' then break end
  end
end

