package 
{
	import flash.net.Socket;
	/**
	 * ...
	 * @author weism
	 */
	public class CmdHandler 
	{
		private static var _ins:CmdHandler;
		
		public static var CMD_FMT:Object =
		{
			1001: 'ss',		// login : name | pwd
			1002: 's',		// send card info to server : carddata
			
			2001: 'h',		// login result: 0 or 1
			2002: 'h'		// send card info result: 0 or 1
		};
		
		public function CmdHandler() 
		{
			
		}
		
		static public function get ins():CmdHandler 
		{
			if (_ins == null) 
			{
				_ins = new CmdHandler();
			}
			return _ins;
		}
		
		public function cmdHandler(client:Socket, np:NetPacket, callback:Function):void
		{
			if (!np.cmdId in CMD_FMT) 
			{
				throw new Error(np.cmdId + " no defined in fmt");
				return;
			}
			var sendNp:NetPacket;
			switch (np.cmdId) 
			{
				case 1001:
					sendNp = new NetPacket(2001);
					sendNp.content.writeShort(1);
				break;
				case 1002:
					sendNp = new NetPacket(2002);
					sendNp.content.writeShort(1);
				break;
				default:
				break;
			}
			
			// send sendNp to client
			if (callback != null) 
			{
				callback.apply(null, [client, sendNp]);
			}
		}
		
		public function getDataFromClient(client:Socket, np:NetPacket):void {
			
		}
		
	}

}