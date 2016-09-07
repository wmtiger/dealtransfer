package
{
	import com.wm.net.py.ClientConnect;
	import com.wm.utils.Log;
	import flash.display.Sprite;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.text.TextField;
	
	public class Main extends Sprite
	{
		private var svrSkt:ServerSocket;
		private var _log:TextField;
		private var _thumb:Sprite;
		
		public function Main()
		{
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
			Log.log = _log;
			
			_thumb = new Sprite();
			addChild(_thumb);
			_thumb.x = 400;
			Log.thumbView = _thumb;
			
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