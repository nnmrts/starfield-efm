CALL "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Tools\Papyrus Compiler\PapyrusCompiler.exe" "EFM.ppj"
ROBOCOPY /E "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data\Scripts\EFM" "..\dist\scripts\EFM"
@REM COPY "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data\Scripts\EFM\FavoritesMenu.pex" "..\dist\scripts"
@REM COPY "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data\efm.esp" "..\dist"
