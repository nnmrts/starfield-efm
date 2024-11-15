package
{
	import Shared.AS3.Data.BSUIDataManager;
	import Shared.AS3.Data.FromClientDataEvent;
	import Shared.AS3.Events.CustomEvent;
	import Shared.GlobalFunc;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import FavoritesMenu.*;

	public class DebugPanel extends MovieClip
	{
		// Stage Instances
		public var Tabs_mc:MovieClip;
		public var Command_tf:TextField;
		public var Content_tf:TextField;

		// The primary menu instance.
		private var Menu_mc:MovieClip;


		public function DebugPanel()
		{
			trace("DebugPanel::constructor");

			this.visible = false; // Hide by default

			addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStageEvent);

			BSUIDataManager.Subscribe("FavoritesData", this.OnFavoritesData);

			BSUIDataManager.Subscribe("ControlMapData", function(controlData:FromClientDataEvent):*
			{
				OnControlMapChanged(controlData.data);
			});

			BSUIDataManager.Subscribe("PlatformData", function(platformData:FromClientDataEvent):*
			{
				OnPlatformChanged(platformData.data);
			});

			Command_tf.addEventListener(Event.CHANGE, OnCommand);
			Tabs_mc.Button1_mc.addEventListener(MouseEvent.CLICK, OnMouseClick1);
			Tabs_mc.Button2_mc.addEventListener(MouseEvent.CLICK, OnMouseClick2);
			Tabs_mc.Button3_mc.addEventListener(MouseEvent.CLICK, OnMouseClick3);
		}


		private function OnAddedToStageEvent(event:Event):void
		{
			trace("DebugPanel::OnAddedToStageEvent(): " + event);
		}


		// public var count:uint = 0;
		private function onFavEntryMouseover(event:Event):void
		{
			trace("DebugPanel::onFavEntryMouseover: " + event);
			// count++;
			// BSUIDataManager.dispatchEvent(new CustomEvent("FavoritesMenu_UseQuickkey", {"uQuickkeyIndex": count}));
		}


		// Command
		//---------------------------------------------

		public var CommandString:String;

		public const COMMAND_MODE_DEBUG:String = "MODE-DEBUG";

		private function OnCommand(event:Event):void
		{
			var command:String = Command_tf.text;
			trace("DebugPanel::OnCommand: " + command);
			if (command.toUpperCase() == COMMAND_MODE_DEBUG)
			{
				Menu_mc = MovieClip(root).Menu_mc;
				Menu_mc.DebugButton_mc.visible = true;
			}
		}


		// Panel
		//---------------------------------------------

		public function Toggle():void
		{
			trace("DebugPanel::Toggle()");
			this.visible = !this.visible;
		}


		// Data
		//---------------------------------------------

		private function OnFavoritesData(clientDataEvent:FromClientDataEvent):void
		{
			trace("DebugPanel::OnFavoritesData(): " + clientDataEvent.toString());
			Content_tf.text = clientDataEvent.toString();

			// var type:FavoritesData = FavoritesData.From(clientDataEvent.data);
			// GlobalFunc.InspectObject(type, true, true);
		}

		private function OnControlMapChanged(controlData:Object):void
		{
			trace("DebugPanel::OnControlMapChanged(): " + controlData.toString());
		}

		private function OnPlatformChanged(platformData:Object):void
		{
			trace("DebugPanel::OnPlatformChanged(): " + platformData.toString());
		}


		// Buttons
		//---------------------------------------------

		private function OnMouseClick1(event:Event)
		{
			trace("DebugPanel::OnMouseClick1(): " + event);
			Content_tf.text = event.toString();
			GlobalFunc.AddMovieExploreFunctions();
		}


		private function OnMouseClick2(event:Event)
		{
			trace("DebugPanel::OnMouseClick2(): " + event);
			Content_tf.text = event.toString();
			GlobalFunc.UserEvent("FavoritesMenu", "MyEventID-HelloWorld");
		}


		private function OnMouseClick3(event:Event)
		{
			trace("DebugPanel::OnMouseClick3(): " + event);
			Content_tf.text = event.toString();
			GlobalFunc.InspectObject(event, true, true);
		}


	}
}
