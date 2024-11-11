ScriptName EFM extends Quest
{This class will monitor the favorites menu.}

Event OnInit()
  Debug.Trace(self+".OnInit()")
EndEvent

Event OnQuestInit()
  Debug.Trace(self+".OnQuestInit()")
EndEvent

Event OnQuestStarted()
  Debug.Trace(self+".OnQuestStarted()")
  RegisterForMenuOpenCloseEvent("FavoritesMenu")
EndEvent

Event OnQuestShutdown()
  Debug.Trace(self+".OnQuestShutdown()")
  UnregisterForMenuOpenCloseEvent("FavoritesMenu")
EndEvent

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  Debug.Trace(self+".OnMenuOpenCloseEvent(asMenuName="+asMenuName+", abOpening="+abOpening+")")
EndEvent