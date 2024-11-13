package Shared.AS3.Data
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class TestProviderLoader extends URLLoader
	{
		private var m_ProviderName:String;

		private var m_FromClient:UIDataFromClient;

		public function TestProviderLoader(providerName:String, fromClient:UIDataFromClient)
		{
			super();
			data = new Object();
			this.m_ProviderName = providerName;
			this.m_FromClient = fromClient;
		}

		override public function load(request:URLRequest):void
		{
			super.load(request);
		}

		public function get providerName():String
		{
			return this.m_ProviderName;
		}

		public function get fromClient():UIDataFromClient
		{
			return this.m_FromClient;
		}
	}
}
