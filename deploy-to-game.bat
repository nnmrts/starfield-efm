ROBOCOPY /E ".\dist\interface" "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data\Interface" /NJH /NJS
ROBOCOPY /E ".\dist\scripts\EFM" "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data\Scripts\EFM" /NJH /NJS
ROBOCOPY ".\dist" "C:\Program Files (x86)\Steam\steamapps\common\Starfield\Data" "*.esm" /NJH /NJS
