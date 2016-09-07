package com.wm.net.py 
{
	import com.wm.deal.cmd.CmdLoginResult;
	import com.wm.deal.cmd.CmdSendCardInfoResult;
	import com.wm.deal.cmd.CmdStartDeal;
	import com.wm.deal.cmd.CmdTestSendImg;
	import com.wm.deal.cmd.CmdWelcome;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class CmdConst 
	{
		/** 命令id对应的传输参数格式,eg:iihss;3i2hsss;iiihhsss;... */
		public static const CMD_FMT:Object =
		{
			// client 发送过来的命令
		1001: ['ss', CmdLoginResult],		// login : name | pwd
		1002: ['hs', CmdSendCardInfoResult],		// send card info to server:h=[0,1,2,3]
			
			// 发送到client的命令
		2001: ['h', CmdLoginResult],		// login result: 0 or 1
		2002: ['h', CmdSendCardInfoResult],		// send card info result: 0 or 1
		2003: ['s', CmdWelcome],		// welcome to connect server: hello
		2004: ['h', CmdStartDeal],		// start deal, need client send card info to server:h=[0,1,2,3]
		
		3001: ['2ishhhs', null],		// test
		3003: ['iis', CmdTestSendImg]		// send img to client test
		};
		
		public function CmdConst() 
		{
			
		}
		
	}

}