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
EndEvent

; Received when the player gains an item in their inventory
; aeAcquireType is one of the following:
; 0: None
; 1: Steal
; 2: Buy
; 3: Pickpocket
; 4: Pickup
; 5: Container
; 6: Dead body
Event OnPlayerItemAdded(Form akBaseObject, ObjectReference akOwner, ObjectReference akSourceContainer, int aeAcquireType)
	Debug.Trace(self+".OnActorActivatedRef(akBaseObject="+akBaseObject + ", akOwner="+akOwner + ", akSourceContainer="+akSourceContainer + ", aeAcquireType="+aeAcquireType + ")")
EndEvent

; Event received when this actor equips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event OnItemEquipped(Form akBaseObject, ObjectReference akReference)
	Debug.Trace(self+".OnItemEquipped(akBaseObject="+akBaseObject+", akReference="+akReference+")")
	FavoritesMenu.SetDebugText(akReference)
EndEvent

; Event received when this actor unequips something - akReference may be None if object is not persistent (only if this alias points at an actor)
Event OnItemUnequipped(Form akBaseObject, ObjectReference akReference)
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
