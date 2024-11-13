package Shared.AS3.Data
{
	public class UIDataShuttleConnector
	{
		public var _Watch:Function;

		public var _RemoveWatch:Function;

		public function UIDataShuttleConnector()
		{
			super();
		}

		public function AttachToDataManager():Boolean
		{
			var connector:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
			return connector == this;
		}

		public function Watch(providerName:String, dispatchImmediately:Boolean, existingClient:UIDataFromClient = null):UIDataFromClient
		{
			var propertyName:String = null;
			var payload:Object = new Object();
			var fromClient:UIDataFromClient = existingClient;
			if (!fromClient)
			{
				fromClient = new UIDataFromClient(payload);
			}
			else
			{
				payload = fromClient.data;
				for (propertyName in payload)
				{
					payload[propertyName] = undefined;
				}
			}
			if (this._Watch(providerName, payload))
			{
				fromClient.isTest = false;
				fromClient.SetReady(dispatchImmediately);
				return fromClient;
			}
			return null;
		}

		public function onFlush(...providers):void
		{
			BSUIDataManager.Flush(providers);
		}
	}
}
