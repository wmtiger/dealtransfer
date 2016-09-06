package com.wm.deal.cmd 
{
	import com.wm.deal.cmd.core.BaseCmdHandler;
	import com.wm.net.py.Packet;
	import com.wm.utils.Log;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class CmdLoginResult extends BaseCmdHandler
	{
		
		public function CmdLoginResult() 
		{
			
		}
		
		override public function cmdHandler(p:Packet = null):void
		{
			Log.info(this + p.data[0] + "has login!==>p.cmdId: " + p.cmdId + "p.data: " + p.data);
			
			_clientConn.user.userName = p.data[0];
			
			sendCmd();// 返回成功登陆到客户端
		}
		
		override public function sendCmd(params:Array = null):void
		{
			var p:Packet = new Packet(2001);// h
			if (params == null) 
			{
				p.data = [1];
			}
			
			_clientConn.send(p);
		}
		
		
	}

}