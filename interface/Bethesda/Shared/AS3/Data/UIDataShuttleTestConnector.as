package Shared.AS3.Data
{
	import com.adobe.serialization.json.JSONDecoder;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class UIDataShuttleTestConnector extends UIDataShuttleConnector
	{
		public function UIDataShuttleTestConnector()
		{
			super();
		}

		override public function Watch(providerName:String, dispatchImmediately:Boolean, existingClient:UIDataFromClient = null):UIDataFromClient
		{
			var fromClient:UIDataFromClient = new UIDataFromClient(new Object());
			var loader:TestProviderLoader = new TestProviderLoader(providerName, fromClient);
			loader.addEventListener(Event.COMPLETE, this.onLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailedPrimaryLocation);
			loader.load(new URLRequest("Providers/" + providerName + ".json"));
			fromClient.isTest = true;
			return fromClient;
		}

		internal function onLoadComplete(event:Event):void
		{
			var key:String = null;
			var loader:TestProviderLoader = event.target as TestProviderLoader;
			var fromClient:UIDataFromClient = loader.fromClient;
			var jsonData:Object = new JSONDecoder(loader.data, true).getValue();
			var clientData:Object = fromClient.data;
			for (key in jsonData)
			{
				clientData[key] = jsonData[key];
			}
			loader.fromClient.SetReady(true);
		}

		internal function onLoadFailedPrimaryLocation(errorEvent:IOErrorEvent):*
		{
			var failedLoader:TestProviderLoader = errorEvent.target as TestProviderLoader;
			var newLoader:TestProviderLoader = new TestProviderLoader(failedLoader.providerName, failedLoader.fromClient);
			newLoader.addEventListener(Event.COMPLETE, this.onLoadComplete);
			newLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			newLoader.load(new URLRequest("../Interface/Providers/" + failedLoader.providerName + ".json"));
		}

		internal function onLoadFailed(errorEvent:IOErrorEvent):*
		{
			var loader:TestProviderLoader = TestProviderLoader(errorEvent.target);
			var providerName:String = loader.providerName;
			trace("WARNING - UIDataShuttleTestConnector.onLoadFailed - TEST PROVIDER: " + providerName + " NOT FOUND");
		}
	}
}
