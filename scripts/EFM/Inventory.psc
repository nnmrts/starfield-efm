Scriptname EFM:Inventory extends ReferenceAlias
{A reference alias for the player Actor type.}

; The favorites menu script.
EFM:FavoritesMenu FavoritesMenu


; Alias
;---------------------------------------------

Event OnAliasStarted()
	Debug.Trace(self+".OnAliasStarted()")
	FavoritesMenu = GetOwningQuest() as EFM:FavoritesMenu
EndEvent

Event OnAliasShutdown()
	Debug.Trace(self+".OnAliasShutdown()")
EndEvent


; Player
;---------------------------------------------

; Event received when this actor activates a ref
Event OnActorActivatedRef(ObjectReference akActivatedRef)
	Debug.Trace(self+".OnActorActivatedRef(akActivatedRef="+akActivatedRef+")")
	FavoritesMenu.SetDebugText("Activated: " + akActivatedRef)
EndEvent


; Event received when this actor equips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event OnItemEquipped(Form akBaseObject, ObjectReference akReference)
	Debug.Trace(self+".OnItemEquipped(akBaseObject="+akBaseObject+", akReference="+akReference+")")
	FavoritesMenu.SetDebugText(akBaseObject)
EndEvent

; Event received when this actor unequips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event OnItemUnequipped(Form akBaseObject, ObjectReference akReference)
	Debug.Trace(self+".OnItemUnequipped(akBaseObject="+akBaseObject+", akReference="+akReference+")")
	FavoritesMenu.SetDebugText(akBaseObject)
EndEvent


; Item
;---------------------------------------------

; Event received when this reference is activated
Event ObjectReference.OnActivate(ObjectReference sender, ObjectReference akActionRef)
	Debug.Trace(self+".OnActivate(sender="+sender+", akActionRef="+akActionRef+")")
EndEvent

; Event received when this object is equipped by an actor
Event ObjectReference.OnEquipped(ObjectReference sender, Actor akActor)
	Debug.Trace(self+".OnEquipped(sender="+sender+", akActor="+akActor+")")
EndEvent

; Event received when this object is grabbed by the player
Event ObjectReference.OnGrab(ObjectReference sender)
	Debug.Trace(self+".OnActorActivatedRef(sender="+sender+")")
EndEvent

; Event received when a spell is cast by this object
Event ObjectReference.OnSpellCast(ObjectReference sender, Form akSpell)
	Debug.Trace(self+".OnSpellCast(sender="+sender+", akSpell="+akSpell+")")
EndEvent
