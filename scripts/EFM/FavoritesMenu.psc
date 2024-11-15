ScriptName EFM:FavoritesMenu extends EFM:FavoritesMenuType
{An abstraction for interactions with the extended favorites menu.}

;/ Cassiopeia Events
- FavoritesMenu_AssignQuickkey
- FavoritesMenu_UseQuickkey
- InventoryMenu_ToggleFavorite
- PowersMenu_FavoritePower
/;
;/ Cassiopeia Functions
- RegisterForNativeEvent
- UnregisterForNativeEvent
- GetIsFormFlagSet
- GetIsChangeFlagSet
- GetReferenceName
- GetInventoryItems
/;

Actor Player


; Events
;---------------------------------------------

Event OnQuestInit()
	Debug.Trace(self+".OnQuestInit()")
EndEvent

Event OnQuestStarted()
	Debug.Trace(self+".OnQuestStarted()")
	Player = Game.GetPlayer()
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnItemUnequipped")
	RegisterForCassiopeia()
EndEvent

Event OnQuestShutdown()
	Debug.Trace(self+".OnQuestShutdown()")
	UnregisterForMenuOpenCloseEvent(Name)
	UnregisterForRemoteEvent(Player, "OnItemEquipped")
	UnregisterForRemoteEvent(Player, "OnItemUnequipped")
	UnregisterForCassiopeia()
EndEvent


; Cassiopeia
;---------------------------------------------

Event OnGameEvent(string eventName)
    Debug.Trace(self+".OnGameEvent(eventName="+eventName+")")
    SetDebugText("EVENT::" + eventName)

	If (eventName == FavoritesMenu_AssignQuickkey)
		SetDebugText("AssignQuickkey")

	ElseIf (eventName == FavoritesMenu_UseQuickkey)
		SetDebugText("UseQuickkey")

	ElseIf (eventName == InventoryMenu_ToggleFavorite)
		Weapon weap = Player.GetEquippedWeapon(9) ; 9:Gun
		If (weap)
			Player.MarkItemAsFavorite(weap, aiSlot=3)
			SetDebugText("ToggleFavorite::WEAPON::" + weap)
		EndIf

	ElseIf (eventName == PowersMenu_FavoritePower)
		Spell power = Player.GetEquippedSpell(2) ; 2:Other
		If (power)
			SetDebugText("FavoritePower::POWER::" + power)
		EndIf
	EndIf
EndEvent


; Player
;---------------------------------------------

; Event received when this actor equips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event Actor.OnItemEquipped(Actor sender, Form akBaseObject, ObjectReference akReference)
	Debug.Trace(self+".OnItemEquipped(akBaseObject="+akBaseObject+", akReference="+akReference+")")
	SetDebugText(akBaseObject)
EndEvent

; Event received when this actor unequips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event Actor.OnItemUnequipped(Actor sender, Form akBaseObject, ObjectReference akReference)
	Debug.Trace(self+".OnItemUnequipped(akBaseObject="+akBaseObject+", akReference="+akReference+")")
	SetDebugText(akBaseObject)
EndEvent


; UI Event
;---------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	Debug.Trace(self+".OnMenuOpenCloseEvent(asMenuName="+asMenuName+", abOpening="+abOpening+")")
	If (abOpening)
		; SendCommand("MODE-DEBUG")
		SetDebugText("Hello Scrivener07")
	EndIf
EndEvent


; UI Interface
;---------------------------------------------

string Function GetDebugText()
	return CassiopeiaPapyrusExtender.GetAS3VariableAsString(Name, DebugText)
EndFunction

Function SetDebugText(string text)
	CassiopeiaPapyrusExtender.SetAS3Variable(Name, DebugText, text)
EndFunction

Function SendCommand(string argument)
	CassiopeiaPapyrusExtender.SetAS3Variable(Name, Command, argument)
EndFunction


; Properties
;---------------------------------------------

string Property Name Hidden
	{The registration name for the favorites menu.}
	string Function Get()
		return "FavoritesMenu"
	EndFunction
EndProperty

string Property DebugPanel Hidden
	{Represents a movieclip debug panel on the favorites menu stage root.}
	string Function Get()
		return "root1.Menu_mc.DebugPanel_mc"
	EndFunction
EndProperty

string Property Command Hidden
	{Represents a string property on the favorites menu `IMenu` AS3 class.}
	string Function Get()
		return DebugPanel + ".Command_tf.text"
	EndFunction
EndProperty

string Property DebugText Hidden
	{Represents a textfield content on the debug panel.}
	string Function Get()
		return DebugPanel + ".Content_tf.text"
	EndFunction
EndProperty
