function OnNavigateComplete(Object)

--m_simpleTV.jsUnpacker.EncodeText
local scr = "var idd = document.getElementById('dtext');if (idd != null) idd.innerHTML = " .. m_simpleTV.jsUnpacker.EncodeText
 
 --debug_in_file(scr .. '\n') 
 m_simpleTV.Config.ExecScript(Object,scr,"javascript")
 m_simpleTV.jsUnpacker.DecodeText =  m_simpleTV.Config.GetElementHtml(Object,'dtext')
 
 if m_simpleTV.jsUnpacker.NotHide==true then return end
 m_simpleTV.Config.Close(Object);
end