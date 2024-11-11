ScriptName EFM:FavoritesMenu extends Quest
{An abstraction for the extended favorites menu.}

; The item name for each of the EXTRA slots.
; string[] Property Slots Auto Hidden


; Events
;---------------------------------------------

Event OnQuestInit()
	Debug.Trace(self+".OnQuestInit()")
EndEvent

Event OnQuestStarted()
	Debug.Trace(self+".OnQuestStarted()")
	; Slots = new string[8]
	; Slots[0] = "Dummy Item 1"
	; Slots[1] = "Dummy Item 2"
	; Slots[2] = "Dummy Item 3"
	; Slots[3] = "Dummy Item 4"
	; Slots[4] = "Dummy Item 5"
	; Slots[5] = "Dummy Item 6"
	; Slots[6] = "Dummy Item 7"
	; Slots[7] = "Dummy Item 8"
	RegisterForMenuOpenCloseEvent(Name)
EndEvent

Event OnQuestShutdown()
	Debug.Trace(self+".OnQuestShutdown()")
	UnregisterForMenuOpenCloseEvent(Name)
EndEvent


; UI Event
;---------------------------------------------

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	Debug.Trace(self+".OnMenuOpenCloseEvent(asMenuName="+asMenuName+", abOpening="+abOpening+")")
	If (abOpening)
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

string Property DebugText Hidden
	{Represents a debug textfield on the root favorites menu stage root.}
	string Function Get()
		return "root1.DebugText_tf.text"
	EndFunction
EndProperty

string Property Command Hidden
	{Represents a string property on the favorites menu.}
	string Function Get()
		return "root1.Menu_mc.Command"
	EndFunction
EndProperty
