package
{
	import com.wm.net.py.ClientConnect;
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
			//return ;
			svrSkt = new ServerSocket();
			svrSkt.addEventListener(ServerSocketConnectEvent.CONNECT, onClientConnect);
			svrSkt.bind(9986);
			svrSkt.listen();
			
			_log = new TextField()
			addChild(_log)
			_log.width = 400;
			_log.height = 100;
			_log.border = true;
			_log.scrollV = _log.maxScrollV;
			trace(_log.scrollV);
			info('==** server socket start **=='); 
		}
		
		protected function onClientConnect(event:ServerSocketConnectEvent):void
		{
			var cliSkt:Socket = event.socket;
			ClientConnect.addConnect(cliSkt);
			info("=========on socket connect=========");
			
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