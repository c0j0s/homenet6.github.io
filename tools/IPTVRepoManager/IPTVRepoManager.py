from lib import *
import importlib
import os.path
import io

from tkinter import *
from tkinter import ttk
from tkinter.filedialog import askopenfilename
from tkinter.filedialog import asksaveasfile

from converter.CumulusTvJsonConverter import CumulusTvJsonConverter 
from converter.CSVConverter import CSVConverter
from converter.M3UConverter import M3UConverter

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf8')

converters = []
importedList = []

def init():
    global converters
    # load all converters
    converters.append(CumulusTvJsonConverter())
    converters.append(CSVConverter())
    converters.append(M3UConverter())

def main():
    #welcome screen
    welcome = """
====================
IPTV Repo Manager V0.1
--------------------"""

    print(welcome)

    #menu
    selected = False

    while not selected:

        menu = """
1. Import
2. Export
--------------------
0. Exit

Option[0-2]: """

        selection = input(menu)

        print("--------------------")

        #menu selection
        if selection == "1":
            importPlaylist()
        elif selection == "2":
            convertPlaylist()
        elif selection == "0":
            exit()
    
        print("--------------------")


def converterSelection(mode="import"):
    global converters
    availableConverter = []

    for c in converters:
        if mode == "import":
            if c.canImport:
                availableConverter.append(c)
        else:
            if c.canExport:
                availableConverter.append(c)

    output = "Select converter:\n"

    for idx,c in enumerate(availableConverter): 
        output = output + str(idx) + ". " + c.name + "\n"

    while True:

        try:
            selection = int(input(output + "Option: "))
            return availableConverter[selection]
        except:
            print("--------------------")
            print("invalid option")
            
    

def convertPlaylist():
    converter = converterSelection("export")
    
    global importedList

    try:
        files = [('Text Document', converter.fileType)]
        outputFilename = asksaveasfile(mode = 'w', filetypes = files, defaultextension = files) 
        converter.exportPlaylist(outputFilename,importedList)
    except:
        print("Fail to Save")




def importPlaylist():
    converter = converterSelection("import")
    #converter = CumulusTvJsonConverter()
    playlistFile = ""
    ready = False
    global importedList

    while not ready:
        playlistFile = askopenfilename(initialdir="./",
                            filetypes =(("Text File", converter.fileType),("All Files","*.*")),
                            title = "Choose a file."
                            )

        try:
            with open(playlistFile,'r', encoding='UTF-8') as UseFile:
                importedList = converter.importPlaylist(UseFile)
                print("Imported " + str(len(importedList)) + " Channels")
                ready = True
        except:
            print("No file exists")

if __name__ == "__main__":
    try:
        init()
        main()
    except KeyboardInterrupt:
        print("\n--------------------")
        print("Force quit, data might be lost!")
        print("--------------------")
        exit()