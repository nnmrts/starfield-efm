package Shared.AS3.Events
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		public static const ACTION_HOVERCHARACTER:String = "HoverCharacter";

		public var params:Object;

		public function CustomEvent(eventType:String, parameters:Object, bubbling:Boolean = false, cancelable:Boolean = false)
		{
			super(eventType, bubbling, cancelable);
			this.params = parameters;
		}

		override public function clone():Event
		{
			return new CustomEvent(type, this.params, bubbles, cancelable);
		}
	}
}
