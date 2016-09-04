package com.wm.utils 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class Log 
	{
		private static var _log:TextField;
		
		public function Log() 
		{
			
		}
		public static function info(msg:String):void
		{
			_log.appendText("[info]" + msg + "\n");
		}
		
		public static function err(msg:String):void
		{
			_log.appendText("[err]" + msg + "\n");
		}
		
		static public function set log(value:TextField):void 
		{
			_log = value;
		}
	}

}