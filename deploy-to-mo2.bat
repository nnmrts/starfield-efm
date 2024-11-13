ROBOCOPY /E ".\dist\interface" "%LocalAppData%\ModOrganizer\Starfield\mods\efm\Interface" /NJH /NJS
ROBOCOPY /E ".\dist\scripts\EFM" "%LocalAppData%\ModOrganizer\Starfield\mods\efm\Scripts\EFM" /NJH /NJS
ROBOCOPY ".\dist"  "%LocalAppData%\ModOrganizer\Starfield\mods\efm" "*.esm" /NJH /NJS
