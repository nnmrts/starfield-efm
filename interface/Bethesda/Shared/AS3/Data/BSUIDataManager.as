package Shared.AS3.Data
{
	import Shared.AS3.Events.CustomEvent;
	import flash.events.Event;

	public final class BSUIDataManager extends UsesEventDispatcherBackend
	{
		private static var _instance:BSUIDataManager;

		private var m_DataShuttleConnector:UIDataShuttleConnector;

		private var m_TestConnector:UIDataShuttleTestConnector;

		private var m_Providers:Object;

		public function BSUIDataManager()
		{
			super();
			if (_instance != null)
			{
				throw new Error(this + " is a Singleton. Access using getInstance()");
			}
			this.m_TestConnector = new UIDataShuttleTestConnector();
			this.m_Providers = new Object();
		}

		private static function GetInstance():BSUIDataManager
		{
			if (!_instance)
			{
				_instance = new BSUIDataManager();
			}
			return _instance;
		}

		public static function ConnectDataShuttleConnector(connector:UIDataShuttleConnector):UIDataShuttleConnector
		{
			var fromClient:UIDataFromClient = null;
			var providerName:String = null;
			var providers:Array = null;
			var instance:BSUIDataManager = GetInstance();
			if (instance.m_DataShuttleConnector == null)
			{
				instance.m_DataShuttleConnector = connector;
				fromClient = null;
				providers = new Array();
				for (providerName in instance.m_Providers)
				{
					fromClient = instance.m_Providers[providerName];
					connector.Watch(providerName, false, fromClient);
				}
				for (providerName in instance.m_Providers)
				{
					fromClient = instance.m_Providers[providerName];
					if (!fromClient.isTest)
					{
						fromClient.DispatchChange();
					}
				}
			}
			return instance.m_DataShuttleConnector;
		}

		public static function InitDataManager(backend:BSUIEventDispatcherBackend):void
		{
			GetInstance().eventDispatcherBackend = backend;
		}

		public static function Subscribe(providerName:String, callback:Function, enableTestMode:Boolean = false):Function
		{
			var providerExists:Boolean = GetInstance().DoesProviderExist(providerName);
			var fromClient:UIDataFromClient = BSUIDataManager.GetDataFromClient(providerName, true, enableTestMode);
			if (fromClient != null)
			{
				fromClient.addEventListener(Event.CHANGE, callback);
				if (providerExists && fromClient.dataReady)
				{
					callback(new FromClientDataEvent(fromClient));
				}
				return callback;
			}
			throw Error("Couldn't subscribe to data provider: " + providerName);
		}

		public static function Flush(providerNames:Array):*
		{
			var provider:UIDataFromClient = null;
			var count:Number = providerNames.length;
			var instance:BSUIDataManager = GetInstance();
			var i:uint = 0;
			while (i < count)
			{
				provider = instance.m_Providers[providerNames[i]];
				provider.DispatchChange();
				i++;
			}
		}

		public static function Unsubscribe(providerName:String, callback:Function, enableTestMode:Boolean = false):void
		{
			var fromClient:UIDataFromClient = BSUIDataManager.GetDataFromClient(providerName, true, enableTestMode);
			if (fromClient != null)
			{
				fromClient.removeEventListener(Event.CHANGE, callback);
			}
		}

		public static function GetDataFromClient(providerName:String, createIfMissing:Boolean = true, enableTestMode:Boolean = false):UIDataFromClient
		{
			var connector:UIDataShuttleConnector = null;
			var testConnector:UIDataShuttleTestConnector = null;
			var fromClient:UIDataFromClient = null;
			var instance:BSUIDataManager = GetInstance();
			if (!instance.DoesProviderExist(providerName) && createIfMissing)
			{
				connector = instance.m_DataShuttleConnector;
				testConnector = instance.m_TestConnector;
				fromClient = null;
				if (connector)
				{
					fromClient = connector.Watch(providerName, true);
				}
				if (!fromClient)
				{
					if (enableTestMode)
					{
						fromClient = testConnector.Watch(providerName, true);
					}
					else
					{
						fromClient = new UIDataFromClient(new Object());
					}
				}
				instance.m_Providers[providerName] = fromClient;
			}
			return instance.m_Providers[providerName];
		}

		public static function addEventListener(eventName:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			GetInstance().addEventListener(eventName, listener, useCapture, priority, useWeakReference);
		}

		public static function removeEventListener(eventName:String, listener:Function, useCapture:Boolean = false):void
		{
			GetInstance().removeEventListener(eventName, listener, useCapture);
		}

		public static function dispatchEvent(event:Event):Boolean
		{
			return GetInstance().dispatchEvent(event);
		}

		public static function dispatchCustomEvent(eventName:String, eventData:Object = null):Boolean
		{
			return dispatchEvent(new CustomEvent(eventName, eventData));
		}

		public static function hasEventListener(eventName:String):Boolean
		{
			return GetInstance().hasEventListener(eventName);
		}

		public static function willTrigger(eventName:String):Boolean
		{
			return GetInstance().willTrigger(eventName);
		}

		private function DoesProviderExist(providerName:String):Boolean
		{
			return this.m_Providers[providerName] != null;
		}
	}
}
