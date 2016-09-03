package com.wm.net.py {
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class ClientConnect 
	{
		private var _bufData:ByteArrayLittle;
		private var _cliSkt:Socket;
		
		public function ClientConnect(cliSkt:Socket) 
		{
			_cliSkt.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_cliSkt.addEventListener(Event.CLOSE, onClosed);
			_bufData  = new ByteArrayLittle();
		}
		
		protected function onSocketData(event:ProgressEvent):void
		{
			var cliSkt:Socket = event.target as Socket;
			cliSkt.readBytes(_bufByts, _bufByts.length);
		}
		
		private function onClosed(e:Event):void
		{
			var cliSkt:Socket = e.target as Socket;
			disposeClient(cliSkt);
		}
		
		private function disposeClient(cliSkt:Socket):void
		{
			cliSkt.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			cliSkt.removeEventListener(Event.CLOSE, onClosed);
			cliSkt.close();
		}
		
		public function send(p:Packet):void
		{
			
		}
		
		
	}

}