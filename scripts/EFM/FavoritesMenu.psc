ScriptName EFM:FavoritesMenu extends Quest
{An abstraction for the extended favorites menu.}


; Events
;---------------------------------------------

Event OnQuestInit()
	Debug.Trace(self+".OnQuestInit()")
EndEvent

Event OnQuestStarted()
	Debug.Trace(self+".OnQuestStarted()")
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
