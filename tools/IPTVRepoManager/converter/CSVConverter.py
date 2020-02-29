from lib.Converter import Converter
from lib.Channel import Channel
import csv

class CSVConverter (Converter): 
    

    def __init__(self):
        super(CSVConverter,self).__init__()
        self.name = "CSV Converter"
        self.canImport = True
        self.canExport = False
        self.fileType = "*.csv"

    def convert(self, channel):
        raise NotImplementedError
    
    def toChannel(self, raw):
        new_channel = Channel()

        if len(raw) > 0:
            new_channel.Name = str(raw[0]).replace(" ","")

        if len(raw) > 1:
            new_channel.StreamUrl = str(raw[1]).replace(" ","")
            
        if len(raw) > 2:
            new_channel.Category = str(raw[2]).replace(" ","")
        
        if len(raw) > 3:
            new_channel.LogoUrl = str(raw[3]).replace(" ","")

        if len(raw) > 0 and raw[0] != "":
            return new_channel
        else:
            raise Exception


    def exportPlaylist(self,outputPath,listOfChannels):
        raise NotImplementedError
    
    def importPlaylist(self,inputPath):
        try:
            channelList = []
            spamreader = csv.reader(inputPath, delimiter=',')           
            if spamreader is not None:
                for channel in spamreader:
                    try:
                        channelList.append(self.toChannel(channel))
                    except:
                        pass
                
            return channelList
        except Exception as e:
            print(e)