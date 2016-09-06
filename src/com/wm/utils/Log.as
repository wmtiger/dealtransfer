package com.wm.utils 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author wmTiger
	 */
	public class Log 
	{
		private static var _log:TextField;
		private static var _thumbView:Sprite;
		
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
		
		public static function showThumb(bitmap:Bitmap):void
		{
			var num:int = _thumbView.numChildren;
			var toX:int = (num % 3) * 100;
			var toY:int = getY(num, 3);
			_thumbView.addChild(bitmap);
			bitmap.x = toX;
			bitmap.y = toY;
		}
		
		private static function getY(total:int, step:int):int
		{
			var num1:int = int(total / step);
			var num2:Number = total / step;
			if (num2 > num1) 
			{
				return num1 + 1;
			}
			return num1;
		}
		
		static public function set log(value:TextField):void 
		{
			_log = value;
		}
		
		static public function set thumbView(value:Sprite):void 
		{
			_thumbView = value;
		}
	}

}