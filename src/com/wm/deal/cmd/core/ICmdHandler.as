package com.wm.deal.cmd.core {
	import com.wm.net.py.ClientConnect;
	import com.wm.net.py.Packet;
	
	/**
	 * ...
	 * @author wmTiger
	 */
	public interface ICmdHandler 
	{
		function set cmdId(value:int):void;
		
		/** 设置客户端的链接 */
		function set clientConn(v:ClientConnect):void;
		
		/** 处理对应的命令回调, 处理完毕后，可以直接调用发送命令，简便而已 */
		function cmdHandler(p:Packet = null):void;
		
		/** 发送命令 */
		function sendCmd(params:Array = null):void;
	}
	
}