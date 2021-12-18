# Telltale Speech Extractor
Version 1.4.3<br>By Bennyboy<br>[Quick and Easy Software](https://quickandeasysoftware.net/)
  
A program that enables you to rip the voices and sfx from the games developed by Telltale Games. This includes games produced by others using the Telltale engine such as Skunkape Games' Sam & Max Save the World.

## New in this version
-  Added support for Sam and Max Beyond Time And Space
  
 ## What do I need to use this?  
Just the games themselves.

  
## How to use it

 1. Click _Open_ and either click on open folder and choose a folder
    yourself or choose one of the games and the files will automatically
    be found.
 2. Click the _Play Sound_ button or press enter to play the currently selected sound.
 3. Click _Save File_ to save a sound. You can choose to save as a WAV or OGG file or let the program automatically choose the most appropriate format. OGG files will be tagged with the annotation text.
 4. Click _Save All Files_ to save the sounds as WAV or OGG or let the program automatically choose the most appropriate format.
 5. Click the _Annotations_ button to edit annotations. See the 'Annotations' section below for more information.

  

### Filtering the sounds:

-   Click on the _View_ button to show a list of all the categories (characters), selecting one of these changes the view so that only sounds in that category are visible.
  
-   To reset the view and show all categories, click the button again and click _View All Files_.

### Searching the sounds:

-   To search just type in the search box. Searching ignores any filter that you've used. I.e. the view will be reset to 'All Files'. The search looks in file names and annotations and is an 'instant search' - the search happens as you type.
  
-   To reset the view either delete the text in the search box or click the View button and select View all files.
  
## What games are supported?
All games released so far by Telltale and Skunkape Games. Thats:

-   Back To The Future
-   Batman: The Telltale Series
-   Batman: The Enemy Within
-   Bone: Out From Boneville
-   Bone: The Great Cow Race
-   Crime Scene Investigation - 3 Dimensions of Murder
-   Crime Scene Investigation - Hard Evidence
-   Crime Scene Investigation - Deadly Intent
-   Crime Scene Investigation - Fatal Conspiracy
-   Game of Thrones
-   Guardians of the Galaxy
-   Hector: Badge Of Carnage
-   Jurassic Park
-   Law & Order: Legacies
-   Minecraft Story mode: Season 1
-   Minecraft Story mode: Season 2
-   Nelson Tethers - Puzzle Agent
-   Poker Night At The Inventory
-   Poker Night 2
-   Sam and Max: Season 1
-   Sam and Max: Season 2
-   Sam and Max: Season 3
-   Sam and Max Save the World
-   Sam and Max Beyond Time And Space
-   Strong Bad: Season 1
-   Tales From The Borderlands
-   Tales Of Monkey Island
-   The Walking Dead Season One (and 400 Days DLC)
-   The Walking Dead Season 2
-   The Walking Dead Michonne
-   The Walking Dead Season 3
-   The Walking Dead Season 4
-   The Walking Dead: The Definitive Series
-   The Wolf Among Us
-   Telltale Texas Hold’em
-   Wallace and Gromit’s Grand Adventure

## Annotations: 
The sounds do not contain any textual information about their contents beyond the filename. To assist with this problem Telltale Speech Extractor supports annotations.  
  
Annotations are descriptive names given to sounds. They list what is said and what character says it. This allows the sounds to be easily browsed, filtered and searched. They are also used when a sound is saved as an MP3. Windows imposes a limit on the length of file names, so its difficult to make a descriptive filename with the limited numbers of characters available. To counter this Telltale Speech Extractor embeds the sound's annotation inside the MP3 as an ID3 tag. This makes it much easier to identify and find the sounds in Windows and music players.  
  
The program comes with annotations for every Telltale game currently available, they are not all 100% complete though. In some games, there are some sounds that don't have annotations, however the annotations can be changed and new ones added. Clicking the _Annotations_ button brings up the annotation editing panel. In here you can edit annotations, change and add annotation categories. Remember to click the _Save Changes_ button when you're done, as the annotations are not automatically saved.  
  
If you add annotations to a game, please send me your updated annotation files so that I can add them to the next release of the program. The annotation files are just standard ini files, they can be found in the 'Annotations' folder and have the file extension '.annot'.  

  

## Bugs and limitations:
Originally each episode of a game stored its resources in separate folders. However most newer games store the resources for all episodes in the same folder. The Walking Dead Season 2 and all games released since do this. If you manually choose the game folder by clicking 'open folder' then the program cant know which episode you want. 
To fix - either choose the specific episode from the menu or choose 'open file' and select the individual file that you want to extract speech from..  
  
The tool only rips audio from the speech files. If you want to rip the music files then download Telltale Music Extractor from my [website.](https://quickandeasysoftware.net)

  

## Technical details: 
The speech files used in Telltale games have changed over time, generally speaking there are 4 types of audio file used:  

-   (.VOX) Vox V1 - These use the Speex codec to store the speech, however the Speex data is not stored in a vorbis container. The audio is divided up into 'packets', some of which are encrypted.
  
-   (.VOX) Vox V2 - These are esentially the same as Vox V1 - but the file header is different and there's no encryption.
  
-   (.AUD) Ogg audio - These are standard Ogg files with an extra header. The format of the header is not always the same and changes between games.
  
-   (.FSB) FSB audio - Seen in The Walking Dead and later games, these are standard FSB files. Different FSB versions and codecs have been used throughout the games.
  

The way the files are stored has also changed. In earlier games (those released before Strongbad) the audio files were stored individually inside the Pack\\Data\ folder. However later games packed the files inside a .ttarch bundle. To get at these files you have to get them out of the bundle first.  
  
To make things even more complicated there's also the issue of encryption. In 'VOX V1' files, packet 0 and every 64th packet are encrypted, so to get correct audio you have to decrypt these. However the encryption keys differ between games. CSI 3 Dimensions of Murder and the original releases of Sam and Max 101, Bone1, Bone2 and Texas Holdem all use the same key. However the original releases of Sam and Max 102-106 all used different keys.  
  
In the last few years though Telltale released updated versions of Sam and Max Season 1, Bone1, Bone2 and Texas Holdem. These now use the VOX V2 format, so aren't encrypted.  
  
To summarise, here is the crazy array of formats and containers that this program supports:

-   V1 VOX files that are partially encrypted, with some games using a different key.
    *  CSI: 3 Dimensions of Murder, the original releases of Sam and Max 101, Bone1, Bone2 and Texas Holdem.

-   V2 VOX files with a slightly different format and no encryption.
    * CSI: Hard Evidence, Sam and Max Season 2, the updated releases of Sam and Max 101, Bone1, Bone2 and Texas Holdem.

-   AUD (ogg) files packed inside an encrypted .ttarch bundle.
    * Strongbad Season 1.

  
-   AUD (ogg) files packed inside a different format, compressed and even more encrypted .ttarch bundle.

    *  Most games released from Strongbad until The Walking Dead.

  
-   V2 VOX files packed inside a different format, compressed and even more encrypted .ttarch bundle.

    * Poker Night At The Inventory and CSI Fatal Conspiracy.

  
-   FSB files packed inside a compressed and even more encrypted .ttarch bundle.

    * The Walking Dead and all games released since then.

  

## Credits and thanks:

-   [Anders Jakobsen](http://aezay.site11.com) for his help with the FSB files  
  
-   Annotation Icon from Buff Set by [Mattahan](http://mattahan.deviantart.com)  
  
-   Clear, Add and Undo icons from the [TiiconCollection](http://projects.ff22.de/tiicon/) by Timon Freitag  
 
-   Delphi Speex Wrapper by [Bech](http://www.sed-p.net)  
    
-   Disk and View Icons by [glyFX](http://www.glyfx.com)  
    
-   [JEDI Code Library](http://sourceforge.net/projects/jcl)  
    
  
-   [JEDI Visual Code Library](http://homepages.codegear.com/jedi/jvcl)  
    
-   MP3FileUtils by [Daniel Gaussmann](http://www.gausi.de)  
   
-   Ogg Vorbis and Opus Tag Library by [3delite](http://www.3delite.hu)  
    
-   Open icon by [Clever Icons](http://www.clevericons.com)  
    
-   Sam and Max Season One Annotations were fixed, updated and completed by [Christoph 'Aeon' Loewe](http://aeons.planetquake.gamespy.com)  
    
-   Simon Boyes - for advice and testing     
    
-   All the former staff at [Telltale Games](http://www.telltalegames.com)  
    Thanks for making such brilliant games  
    
-   [Virtual Treeview](https://www.jam-software.com/virtual-treeview) by Mike Lischke and many others since.
 
-   Wave Writer class by [Benjamin Haisch](http://gamefileformats.netfirms.com) (John_Doe)  
    

## Support: 
[Contact me](http://quickandeasysoftware.net/contact).  
  
All my software is completely free. If you find this program useful please consider making a donation. This can be done on my [website.](http://quickandeasysoftware.net)

  

Last updated 12/12/21
