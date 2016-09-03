package
{
	import com.wm.net.py.ByteArrayLittle;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	public class Main extends Sprite
	{
		static public const SIZE_BYTES_HEAD:int = 6;
		
		private var svrSkt:ServerSocket;
		private var _log:TextField;
		private var _bufByts:ByteArray;
		private var _sktHandlers:Dictionary;
		
		public function Main()
		{
			var byt:ByteArrayLittle = new ByteArrayLittle();
			byt.writeShort(1);
			byt.writeInt(2);
			byt.writeUTFBytes("abc");
			byt.position = 0;
			byt.writeUTFBytes("hi3s");
			byt.position = 0;
			trace(byt.readUTFBytes(4));
			trace(byt.readShort());
			trace(byt.readInt());
			trace(byt.readUTFBytes(3));
			return ;
			svrSkt = new ServerSocket();
			svrSkt.addEventListener(ServerSocketConnectEvent.CONNECT, onClientConnect);
			svrSkt.bind(9986);
			svrSkt.listen();
			
			_bufByts = new ByteArray();
			_bufByts.endian = Endian.LITTLE_ENDIAN;
			_sktHandlers = new Dictionary(true);
			
			_log = new TextField()
			addChild(_log)
			_log.width = 400;
			_log.height = 400;
			_log.border = true;
			trace(_log.scrollV);
			info('==** server socket start **=='); 
		}
		
		protected function onClientConnect(event:ServerSocketConnectEvent):void
		{
			var cliSkt:Socket = event.socket;
			info("=========on socket connect=========");
			cliSkt.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			cliSkt.addEventListener(Event.CLOSE, onClosed);
			
			//var p:NetPacket = new NetPacket(1);
			//p.content.writeUTFBytes("hello");
			//send(cliSkt, p);
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
			info("onClosed ==== >: " + cliSkt);
		}
		
		protected function onSocketData(event:ProgressEvent):void
		{
			var cliSkt:Socket = event.target as Socket;
			cliSkt.readBytes(_bufByts, _bufByts.length);
			//var len:uint = _bufByts.readUnsignedInt();
			//info('len: '+len);
			var np:NetPacket = NetPacket.buildPacket(_bufByts);
			while (np != null)
			{
				info("np.cmdId: " + np.cmdId);
				if (np.cmdId == 404)
				{
					info("recieved close message");
					disposeClient(cliSkt);
					return;
				}
				CmdHandler.ins.cmdHandler(cliSkt, np, send);
				
				if (_bufByts.bytesAvailable == 0)
				{
					//ended at the end of message; reset the buffer
					_bufByts.position = 0;
					_bufByts.length = 0;
					return;
				}
				
				np = NetPacket.buildPacket(_bufByts);
			}
		}
		
		private function send(clientSkt:Socket, np:NetPacket):void
		{
			var data:ByteArray = np.pack();
			try
			{
				clientSkt.writeBytes(data);
				clientSkt.flush();
			}
			catch (e:IOError)
			{
				err("send to client error" + e.getStackTrace());
			}
		}
		
		private function info(msg:String):void
		{
			_log.appendText("[info]" + msg + "\n");
		}
		
		private function err(msg:String):void
		{
			_log.appendText("[err]" + msg + "\n");
		}
	}
}