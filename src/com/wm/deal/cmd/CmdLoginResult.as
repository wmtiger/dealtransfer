package com.wm.deal.cmd 
{
	import com.wm.deal.cmd.core.BaseCmdHandler;
	import com.wm.deal.cmd.core.CmdFactory;
	import com.wm.net.py.Packet;
	import com.wm.utils.Log;
	import flash.utils.setTimeout;
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
			
			_clientConn.user.userPosition = p.data[0];
			_clientConn.user.userName = p.data[1];
			
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
			
			//setTimeout(testStartDeal, 3000);// 延迟3秒要求client发手牌数据来,test
		}
		
		private function testStartDeal():void
		{
			CmdFactory.addCmd(2004, _clientConn, CmdStartDeal).sendCmd([0]);// 为0，要求client发送手牌数据过来
		}
		
	}

}