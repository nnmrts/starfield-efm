CALL "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Tools\Papyrus Compiler\PapyrusCompiler.exe" ".\scripts\EFM.ppj"
ROBOCOPY /E ".\plugins" ".\dist" /NJH /NJS

:: TODO: Implement autopublishing (https://community.adobe.com/t5/animate-discussions/publish-an-animate-file-from-the-command-line/td-p/10471290, https://stackoverflow.com/questions/262192/is-it-possible-to-publish-a-fla-from-the-command-line)
ECHO "Don't forget publishing interface\EFM.FavoritesMenu\FavoritesMenu.fla\FavoritesMenu.xfl!"