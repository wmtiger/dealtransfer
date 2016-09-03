package com.wm.net.py {
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * 客户端的链接
	 * @author wmTiger
	 */
	public class ClientConnect 
	{
		public static var CONNECTS:Dictionary = new Dictionary(true);
		private var _bufData:ByteArrayLittle;
		private var _cliSkt:Socket;
		
		public function ClientConnect(cliSkt:Socket) 
		{
			_cliSkt = cliSkt;
			_cliSkt.timeout = 10000;
			_cliSkt.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_cliSkt.addEventListener(Event.CLOSE, onClosed);
			_bufData  = new ByteArrayLittle();
		}
		
		public static function addConnect(cliSkt:Socket):void
		{
			var conn:ClientConnect = ClientConnect.CONNECTS[cliSkt];
			if (conn) 
			{
				trace("已经有过链接了，要删掉前面的。");
				conn.disposeClient(cliSkt);
			}
			ClientConnect.CONNECTS[cliSkt] = new ClientConnect(cliSkt);
		}
		
		protected function onSocketData(event:ProgressEvent):void
		{
			var cliSkt:Socket = event.target as Socket;
			cliSkt.readBytes(_bufData, _bufData.length);
			var pk:Packet = Packet.buildPacket(_bufData);
			while (pk != null)
			{
				if (_bufData == null) 
				{
					return;
				}
				if (_bufData.bytesAvailable == 0) 
				{
					//ended at the end of message; reset the buffer
					_bufData.position = 0;
					_bufData.length = 0;
					return;
				}
				pk = Packet.buildPacket(_bufData);
			}
		}
		
		private function onClosed(e:Event):void
		{
			var cliSkt:Socket = e.target as Socket;
			disposeClient(cliSkt);
		}
		
		public function disposeClient(cliSkt:Socket = null):void
		{
			if (cliSkt == null) 
			{
				cliSkt = _cliSkt;
			}
			cliSkt.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			cliSkt.removeEventListener(Event.CLOSE, onClosed);
			cliSkt.close();
			ClientConnect.CONNECTS[cliSkt] = null;
			delete ClientConnect.CONNECTS[cliSkt];
		}
		
		public function send(p:Packet):void
		{
			var buf:ByteArray = p.pack();
			if (_cliSkt.connected) 
			{
				try 
				{
					_cliSkt.writeBytes(buf);
					_cliSkt.flush();
				} 
				catch (e : IOError) 
				{
					trace("connect error："+e.getStackTrace());
				}
			}
		}
		
		
	}

}