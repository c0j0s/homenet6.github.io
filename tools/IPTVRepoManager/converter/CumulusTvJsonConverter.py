from lib.Converter import Converter
from lib.Channel import Channel
import json
import fileinput

class CumulusTvJsonConverter (Converter): 

    def __init__(self):
        super(CumulusTvJsonConverter,self).__init__()
        self.name = "Cumulus Tv Json Converter"
        self.canImport = True
        self.canExport = True
        self.fileType = "*.json"

    def convert(self,channel):
        data = {
            "number":channel.Index,
            "name":channel.Name,
            "logo":channel.LogoUrl,
            "url": channel.StreamUrl,
            "splashscreen":"",
            "genres":channel.Category,
            "source":"",
            "epgUrl":""
        }
        return data

    def toChannel(self, raw):
        new_channel = Channel()
        new_channel.Index = raw["number"]
        new_channel.Name = raw["name"]
        new_channel.Category = raw["genres"]
        new_channel.LogoUrl = str(raw["logo"]).replace("\/","/") 
        new_channel.StreamUrl = str(raw["url"]).replace("\/","/") 
        return new_channel

    def exportPlaylist(self,f,listOfChannels):
        try:
            data = {
            "channels":[],
            "possibleGenres":[],
            "modified":1
            }

            for idx,channel in enumerate(listOfChannels):
                channel.Index = idx + 1
                data["channels"].append(self.convert(channel))

                if channel.Category not in data["possibleGenres"]:
                    if channel.Category != "":
                        data["possibleGenres"].append(channel.Category)
            
            json.dump(data,f,ensure_ascii=False,indent=4)   
            f.close()
            filedata = f.read()
            newdata = filedata.replace("/","\/")
            f.write(newdata)
            f.close()

            return True
        except Exception as e:
            print(e)
        
    def importPlaylist(self,inputPath):
        try:
            channelList = []
            data = json.load(inputPath, encoding='utf-8')

            if data["channels"] is not None:
                for channel in data["channels"]:
                    channelList.append(self.toChannel(channel))
            
            return channelList
        except Exception as e:
            print(e)