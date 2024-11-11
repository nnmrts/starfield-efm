ScriptName EFM extends Quest
{This class will monitor the favorites menu.}

Event OnInit()
  Debug.Trace(self+".OnInit()")
  FixFavorites()
EndEvent

Event OnQuestInit()
  Debug.Trace(self+".OnQuestInit()")
  FixFavorites()
EndEvent

Event OnQuestStarted()
  Debug.Trace(self+".OnQuestStarted()")
  RegisterForMenuOpenCloseEvent("FavoritesMenu")
  FixFavorites()
EndEvent

Event OnQuestShutdown()
  Debug.Trace(self+".OnQuestShutdown()")
  UnregisterForMenuOpenCloseEvent("FavoritesMenu")
EndEvent

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
  Debug.Trace(self+".OnMenuOpenCloseEvent(asMenuName="+asMenuName+", abOpening="+abOpening+")")
  FixFavorites()
EndEvent

Function FixFavorites()
  Actor player = Game.GetPlayer()
  Form[] items = CassiopeiaPapyrusExtender.GetInventoryItems(player)

  Debug.Trace(items)
  Debug.Trace(items[0])
  ; Debug.Trace(items[0].GetPropertyValue("bFavorite"))

  ; int itemCount = items.Length
  ; int i = 0

  ; while i < itemCount
  ;   Form item = items[i]
  ;   Debug.Trace("Item " + i + ": " + item)
  ;   ; Debug.Trace("Item " + i + " keywords: " + CassiopeiaPapyrusExtender.GetKeywords(item))
  ;   ; Debug.Trace("Item " + i + " aliases: " + CassiopeiaPapyrusExtender.GetAliases(item))
  ;   Debug.Trace("Item " + i + " TESFullName: " + CassiopeiaPapyrusExtender.GetTESFullName(item))
  ;   ; Debug.Trace("Item " + i + " ReferenceName: " + CassiopeiaPapyrusExtender.GetReferenceName(item))
  ;   bool bFavorite = item.GetPropertyValue("bFavorite") as bool
  ;   Debug.Trace("Item " + i + " bFavorite: " + bFavorite)

  ;   Debug.Trace(item.GetPropertyValue("favorited"))
  ;   Debug.Trace(item.GetPropertyValue("Favorited"))
  ;   Debug.Trace(item.GetPropertyValue("favorite"))
  ;   Debug.Trace(item.GetPropertyValue("Favorite"))
  ;   Debug.Trace(item.GetPropertyValue("FavoriteSlot"))
  ;   Debug.Trace(item.GetPropertyValue("iFavoriteSlot"))


  ;   i += 1
  ; endwhile


  CassiopeiaPapyrusExtender.SetAS3Variable("FavoritesMenu", "root1.Menu_mc.ItemInfo_mc.ItemName_mc.text_tf.text", "Hello Scrivener07")

  string menuString = CassiopeiaPapyrusExtender.GetAS3VariableAsString("FavoritesMenu", "root1.Menu_mc.ItemInfo_mc.ItemName_mc.text_tf.text")

  Debug.Trace("menuString: " + menuString)

EndFunction