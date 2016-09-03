package com.wm.net.py 
{
	/**
	 * ...
	 * @author wmTiger
	 */
	public class CmdConst 
	{
		/** 命令id对应的传输参数格式,eg:iihss;3i2hsss;iiihhsss;... */
		public static const CMD_FMT:Object =
		{
			1001: 'ss',		// login : name | pwd
			1002: 's',		// send card info to server : carddata
			
			2001: 'h',		// login result: 0 or 1
			2002: 'h'		// send card info result: 0 or 1
		};
		
		public function CmdConst() 
		{
			
		}
		
	}

}