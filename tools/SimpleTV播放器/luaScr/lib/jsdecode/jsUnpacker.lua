local base = _G
module ('jsdecode')

function DoDecode(scr,nothide)
 
 if base.m_simpleTV.jsUnpacker==nil then base.m_simpleTV.jsUnpacker={} end
 base.m_simpleTV.jsUnpacker.DecodeText = nil
 base.m_simpleTV.jsUnpacker.NotHide = false
 base.m_simpleTV.jsUnpacker.EncodeText = scr
 
 local fl=1+64
  
 if nothide==true then 
    fl=fl-64 
	base.m_simpleTV.jsUnpacker.NotHide=true

 end
 
 base.m_simpleTV.Dialog.Show('',base.m_simpleTV.MainScriptDir .. 'lib\\jsdecode\\jsunpack.html','lib\\jsdecode\\jsunpackd.lua',480,280,fl)   
 return base.m_simpleTV.jsUnpacker.DecodeText
 
 
end