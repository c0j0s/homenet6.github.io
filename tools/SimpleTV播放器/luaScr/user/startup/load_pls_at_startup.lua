
--load 
local ProviderName = '��� ���������' --������ ������ ���� �� �����
local FileUrl = ''   --!! ������� url ���������

if FileUrl==nil or FileUrl=='' then return end

local tmpName = m_simpleTV.Common.DownloadFileInTmp (FileUrl,'simpleTVtmp.tmp')

if tmpName==nil then
  m_simpleTV.OSD.ShowMessage(ProviderName .. " ������ - �� ���� �������� ����" ,255,10)
  m_simpleTV.Common.Wait(2000)
  return
end

--�����  ��� �������� ��������� 
p={}
p.TypeSourse = 1
p.DeleteBeforeLoad = 0
p.TypeSkip   = 1
p.TypeFind =   0
p.AutoSearch = 1
p.NumberM3U =  0
p.Find_Group = 1
p.TypeCoding = -1  --  -1-auto  0 - plane text  1- UTF8  2- unicode
p.ExtFilter = ProviderName

local err = m_simpleTV.Common.LoadPlayList (tmpName,p,0,true,false)
os.remove(tmpName)

if err then 
   m_simpleTV.OSD.ShowMessage(ProviderName ..  " - �������� ���������" ,0xFF00,5)
else    
 m_simpleTV.OSD.ShowMessage(ProviderName .. " ������ - �� ���� ��������� ����" ,255,10)
 m_simpleTV.Common.Wait(2000)
end
 


