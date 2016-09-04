package
{
	import com.wm.net.py.ByteArrayLittle;
	import com.wm.net.py.ClientConnect;
	import com.wm.net.py.Packet;
	import com.wm.utils.Log;
	import flash.display.Sprite;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	public class Main extends Sprite
	{
		private var svrSkt:ServerSocket;
		private var _log:TextField;
		
		public function Main()
		{
			/*
			var p:Packet = new Packet(3001);//2ishhhs
			p.data = [10, 20, "hello", 1, 2, 3, "tiger"];
			var buf:ByteArray = p.pack();
			var pk:Packet = Packet.buildPacket(buf as ByteArrayLittle);
			trace(pk.cmdId, pk.data);
			return ;
			*/ 
			
			svrSkt = new ServerSocket();
			svrSkt.addEventListener(ServerSocketConnectEvent.CONNECT, onClientConnect);
			svrSkt.bind(9986);
			svrSkt.listen();
			
			_log = new TextField()
			addChild(_log)
			_log.width = 400;
			_log.height = 500;
			_log.border = true;
			_log.scrollV = _log.maxScrollV;
			trace(_log.scrollV);
			Log.log = _log;
			Log.info('==** server socket start **=='); 
		}
		
		protected function onClientConnect(event:ServerSocketConnectEvent):void
		{
			var cliSkt:Socket = event.socket;
			ClientConnect.addConnect(cliSkt);
			Log.info("=========on socket connect=========");
			
		}
		
	}
}