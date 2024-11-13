Scriptname EFM:FavoritesMenuType extends Quest Native Const Hidden

string Property SelfName = "EFM:FavoritesMenuType" AutoReadOnly Hidden
string Property InventoryMenu_ToggleFavorite = "InventoryMenu_ToggleFavorite" AutoReadOnly Hidden
string Property PowersMenu_FavoritePower = "PowersMenu_FavoritePower" AutoReadOnly Hidden
string Property FavoritesMenu_UseQuickkey = "FavoritesMenu_UseQuickkey" AutoReadOnly Hidden
string Property FavoritesMenu_AssignQuickkey = "FavoritesMenu_AssignQuickkey" AutoReadOnly Hidden

; Cassiopeia
;---------------------------------------------

Function RegisterForCassiopeia()
	CassiopeiaPapyrusExtender.RegisterForNativeEvent(SelfName, InventoryMenu_ToggleFavorite)
	CassiopeiaPapyrusExtender.RegisterForNativeEvent(SelfName, PowersMenu_FavoritePower)
	CassiopeiaPapyrusExtender.RegisterForNativeEvent(SelfName, FavoritesMenu_UseQuickkey)
	CassiopeiaPapyrusExtender.RegisterForNativeEvent(SelfName, FavoritesMenu_AssignQuickkey)
EndFunction

Function UnregisterForCassiopeia()
	CassiopeiaPapyrusExtender.UnregisterForNativeEvent(SelfName, InventoryMenu_ToggleFavorite)
	CassiopeiaPapyrusExtender.UnregisterForNativeEvent(SelfName, PowersMenu_FavoritePower)
	CassiopeiaPapyrusExtender.UnregisterForNativeEvent(SelfName, FavoritesMenu_UseQuickkey)
	CassiopeiaPapyrusExtender.UnregisterForNativeEvent(SelfName, FavoritesMenu_AssignQuickkey)
EndFunction

EFM:FavoritesMenu Function GetSelf() Global
	return Game.GetFormFromFile(0x00000807, "efm.esp") as EFM:FavoritesMenu
EndFunction

Function InventoryMenu_ToggleFavorite() Global
	EFM:FavoritesMenu this = EFM:FavoritesMenuType.GetSelf()
	this.OnGameEvent(this.InventoryMenu_ToggleFavorite)
EndFunction

Function PowersMenu_FavoritePower() Global
	EFM:FavoritesMenu this = EFM:FavoritesMenuType.GetSelf()
	this.OnGameEvent(this.PowersMenu_FavoritePower)
EndFunction

Function FavoritesMenu_UseQuickkey() Global
	EFM:FavoritesMenu this = EFM:FavoritesMenuType.GetSelf()
	this.OnGameEvent(this.FavoritesMenu_UseQuickkey)
EndFunction

Function FavoritesMenu_AssignQuickkey() Global
	EFM:FavoritesMenu this = EFM:FavoritesMenuType.GetSelf()
	this.OnGameEvent(this.FavoritesMenu_AssignQuickkey)
EndFunction

Event OnGameEvent(string eventName)
	Debug.Trace(SelfName+".OnGameEvent(eventName="+eventName+")")
EndEvent
