--get address

--debug_in_file(m_simpleTV.Control.CurrentAdress .. '\n')
  
 
dofile (m_simpleTV.MainScriptDir .. "user/video/video.lua")
dofile (m_simpleTV.MainScriptDir .. "user/UdpProxy/UdpProxy.lua")
dofile (m_simpleTV.MainScriptDir .. "user/Rtmpdump/Rtmpdump.lua")


ExecuteFilesByReason('getaddress')