from lib.Converter import Converter
from lib.Channel import Channel

class M3UConverter (Converter): 
    
    def __init__(self):
        super(M3UConverter,self).__init__()
        self.name = "M3U Converter"
        self.canImport = False
        self.canExport = True
        self.fileType = "*.m3u"

    def convert(self, channel):
        firstLine = "#EXTINF:-1 group-title='"+ channel.Category +"',"+ channel.Name
        secondLine = channel.StreamUrl
        return firstLine + "\n" + secondLine + "\r\n"

    def toChannel(self, raw):
        raise NotImplementedError

    def exportPlaylist(self,outputPath,listOfChannels):
        try:
            outputPath.write("#EXTM3U\n")

            for channels in listOfChannels:
                outputPath.write(str(self.convert(channels).encode('utf-8')))
            
            outputPath.close()
            return True
        except Exception as e:
            print(e)
        
    def importPlaylist(self,inputPath):
        raise NotImplementedError