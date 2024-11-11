# EFM | Extended Favorites Menu
The Extended Favorites Menu (EFM) provides additional favorite slots.


### End User Dependencies
- [Starfield Script Extender (SFSE) by SFSE Team](https://www.nexusmods.com/starfield/mods/106)
- [Address Library for SFSE Plugins by meh321](https://www.nexusmods.com/starfield/mods/3256)
- [Cassiopeia Papyrus Extender by LarannKiar](https://www.nexusmods.com/starfield/mods/10896)


### Tools
- [FFDec - Free Flash Decompiler by JPEXS](https://github.com/jindrapetrik/jpexs-decompiler/releases)
- [BAE - Bethesda Archive Extractor](https://www.nexusmods.com/starfield/mods/165)


# Documentation
This section has links to some useful documentation.

#### UESP Documentation
- [UESP Skyrim Wiki](https://ck.uesp.net/wiki/Main_Page)
- [UESP Fallout 4 Wiki](https://falloutck.uesp.net/wiki/Main_Page)

#### Scaleform Documentation
- [Scaleform Documentation](https://help.autodesk.com/view/SCLFRM/ENU/)
- [Scaleform AS3 Support](https://help.autodesk.com/view/SCLFRM/ENU/?guid=__scaleform_help_flash_support_as3_class_html)

#### Actionscript Documentation
- [AS3 Reference Documentation](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/index.html)
- [AS3 Compiler Errors](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/compilerErrors.html)
- [AS3 Runtime Errors](https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/runtimeErrors.html)

#### Other Links
- [Starfield UI Dump](https://github.com/Starfield-Creators/Interface/)
- [Fallout 4 UI Dump](https://github.com/F4CF/Interface)
- [AS3 System.Diagnostics](https://github.com/F4CF/Creation-Framework/tree/master/System/Interface/Source/System/System/Diagnostics)
- [FO4 Papyrus - Actor.MarkItemAsFavorite](https://falloutck.uesp.net/wiki/MarkItemAsFavorite_-_Actor)


# Menu Restoration
These were the steps taken to restore the vanilla Favorites menu to a functional state post-export from FFDec.

### Disable automatically declare stage instances
Disable the "Automatically declare stage instances" option on the Flash document publish settings.

### Set item icon background alpha to zero
The item icon background, known as FFDec export `Symbol 40`, should have the shape's alpha color set to zero.
This shape is intended to be invisible, but it needs to exist for some code based bounds testing for the actual loaded icon art.

### Restore the fonts configuration
You will notice that all the `TextField` object are set to use `Times New Roman` after FFDec export, but this is incorrect.
That is merely the operating system default because FFDec doesn't export the text linkage to external RSL font libraries correctly.
First create a new `Font` symbol which is a Flash library object like `MovieClip` and `Shape`.
This `Font` symbol by default will specify meta data about a font on your OS, and then directly embed that font TTF directly into your published SWF.
Make sure to visit the "Actionscript" tab of the font embed window and find the **Linkage** section.
Make sure the font has a unique class definition and has `Export for Actionscript` and `Export in frame 1` checked.

Then you would then go back to all the `TextField` in the menu and change it from `Times New Roman`, to your `Font` symbol.
You will see these appear in the font selection drop down as entries suffixed with a `*`. Choose those.
The favorites menu should use the class name `$MAIN_Font_Bold`, which represents the `NB Architekt` font, for all text fields in the menu.


# Notes
Some useful notes worth writing down.


### Log Tailing
To read log files as they are written to, you must use a text editor or shell capable of "tailing" a text file.
By default, Windows Notepad, VS Code, and many other text editors don't support reading live log files.
A program like [SnakeTail for Windows](https://github.com/snakefoot/snaketail-net/releases) or your choice between several VSC extensions can handle this well. Without a text editor capable of log tailing, the text within the log file will not appear to update until the game is closed, or whatever application has a file-lock on any given text file.


### Scaleform Logging
Use SFSE to re-enable Scaleform logging.
Create the `\Data\SFSE\SFSE.ini` file and save this setting.
```ini
[Scaleform]
EnableLog=1
```

### Papyrus Command Line
You can override individual PPJ settings on the command line.
```bat
PapyrusCompiler.exe "MyProject.ppj" --output="x:\some\other\directory"
```

### Developer Console
In the event of a soft-lock or intention to debug, it is possible to open/close a menu by name using the in-game developer console.

#### Open a menu by name.
```
ShowMenu FavoritesMenu
```

#### Close a menu by name.
```
HideMenu FavoritesMenu
```

#### Find the name of all currently open menus.
```
PAM
```

#### Force reload a Papyrus script.
Force reloads a Papyrus script while the game is running.
Each changed script in a script's inheritance chain needs to be reloaded separately.
Quotes are required when the script has a namespace represented by the `:` character
```
ReloadScript "EFM:FavoritesMenuType"
ReloadScript "EFM:FavoritesMenu"
```
