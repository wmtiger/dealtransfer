package com.wm.net.py {
	import com.wm.utils.Log;
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
				Log.info("已经有过链接了，要删掉前面的。");
				conn.disposeClient(cliSkt);
			}
			conn = new ClientConnect(cliSkt);
			ClientConnect.CONNECTS[cliSkt] = conn;
			
			var p:Packet = new Packet(3001);//2ishhhs
			p.data = [10, 20, "hello", 1, 2, 3, "tiger"];
			//var buf:ByteArray = p.pack();
			//var pk:Packet = Packet.buildPacket(buf as ByteArrayLittle);
			//Log.info("===>pk.cmdId: "+pk.cmdId+"pk.data: "+ pk.data);
			conn.send(p);
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
			Log.info("closed connection");
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
					Log.err("connect error："+e.getStackTrace());
				}
			}
		}
		
		
	}

}