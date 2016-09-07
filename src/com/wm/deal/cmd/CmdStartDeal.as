package com.wm.deal.cmd 
{
	import com.wm.deal.cmd.core.BaseCmdHandler;
	import com.wm.net.py.Packet;
	
	/**
	 * 开始发牌
	 * @author weism
	 */
	public class CmdStartDeal extends BaseCmdHandler 
	{
		
		public function CmdStartDeal() 
		{
			super();
			
		}
		
		override public function cmdHandler(p:Packet = null):void
		{
			
		}
		
		override public function sendCmd(params:Array = null):void
		{
			// 主动向client推送开始发牌，即是：向client要牌面数据
			var p:Packet = new Packet(2004);// h
			if (params == null) 
			{
				p.data = [0];
			}else
			{
				p.data = params;// 这里看是否有参数过来，有0,1,2,3，的参数，意义不同
			}
			
			_clientConn.send(p);
		}
		
	}

}