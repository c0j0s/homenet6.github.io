--input
--m_simpleTV.Control.Reason              Error|EndReached|Stopped|Playing|Sleeping
--m_simpleTV.Control.CurrentAdress      Address from database
--m_simpleTV.Control.RealAdress			 Real Address

--output
--m_simpleTV.Control.CurrentAddress      Address from database
--m_simpleTV.Control.Action              dodefault|repeat

--m_simpleTV.Control.Reason=Sleeping - comp going to sleep, all other fields are undefined   

--m_simpleTV.OSD.ShowMessage('r - ' .. m_simpleTV.Control.Reason .. ',addr= ' .. m_simpleTV.Control.CurrentAdress .. ',radr=' .. m_simpleTV.Control.RealAdress ,255,60)

--if m_simpleTV.Control.Reason == 'Sleeping' then
   --dgdg.sdfgsd=45
--end



ExecuteFilesByReason('events')


