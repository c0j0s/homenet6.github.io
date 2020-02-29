class Converter(object):
    def __init__(self):
        self.name = "Converter"
        self.canImport = False
        self.canExport = False
        self.fileType = "*.txt"
        pass

    def convert(self, channel):
        raise NotImplementedError

    def toChannel(self, raw):
        raise NotImplementedError

    def exportPlaylist(self,outputPath,listOfChannels):
        raise NotImplementedError
    
    def importPlaylist(self,inputPath):
        raise NotImplementedError