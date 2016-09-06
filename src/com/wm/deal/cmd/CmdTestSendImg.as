package com.wm.deal.cmd 
{
	import com.wm.deal.cmd.core.BaseCmdHandler;
	import com.wm.net.py.Packet;
	import com.wm.utils.Base64;
	import com.wm.utils.Log;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author wmTiger
	 */
	public class CmdTestSendImg extends BaseCmdHandler 
	{
		//[Embed(source = "../../../../assets/img.jpg")]
		//private var IMG_CLS:Class;
		//private var _img:Bitmap;
		//
		public function CmdTestSendImg() 
		{
			super();
			
		}
		
		override public function cmdHandler(p:Packet = null):void
		{
			//sendCmd()
			//return ;
			//trace(p);
			//var byt:ByteArray = Base64.decodeToByteArray(p.data[2]);
			////byt.endian = Endian.LITTLE_ENDIAN;
			//var w:int = p.data[0];
			//var h:int = p.data[1];
			//var bmd:BitmapData = new BitmapData(w, h);
			//bmd.setPixels(new Rectangle(0, 0, w, h), byt);
			//var bitmap:Bitmap = new Bitmap(bmd);
			//Log.showThumb(bitmap);
			//sendCmd();// 返回成功登陆到客户端
		}
		
		override public function sendCmd(params:Array = null):void
		{
			var p:Packet = new Packet(3003);// s
			if (params == null) 
			{
				//_img = new IMG_CLS();
				//var str64:String = _img.bitmapData.copyPixelsToByteArray
				//var byt:ByteArray = _img.bitmapData.getPixels(_img.bitmapData.rect);
				//var str:String = Base64.encodeByteArray(byt);
				//trace(str.length, str);
				//byt.position = 0;
				//byt.compress();
				//var cStr:String = Base64.encodeByteArray(byt);
				//Log.info(p.cmdId+": len: "+str.length + " === cStr.len: "+ cStr.length);
				//p.data = [_img.bitmapData.width, _img.bitmapData.height, str];
			}
			
			_clientConn.send(p);
		}
		
		
	}

}