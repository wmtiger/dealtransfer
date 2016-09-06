package com.wm.deal.cmd.core {
	import com.wm.net.py.ClientConnect;
	import com.wm.net.py.Packet;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class BaseCmdHandler implements ICmdHandler
	{
		protected var _cmdId:int;
		protected var _clientConn:ClientConnect;
		
		public function BaseCmdHandler() 
		{
		}
		
		/* INTERFACE com.wm.deal.cmd.ICmdHandler */
		
		public function cmdHandler(p:Packet = null):void 
		{
			
		}
		
		public function sendCmd(params:Array = null):void 
		{
			
		}
		
		public function set clientConn(value:ClientConnect):void 
		{
			_clientConn = value;
		}
		
		public function set cmdId(value:int):void 
		{
			_cmdId = value;
		}
		
	}

}