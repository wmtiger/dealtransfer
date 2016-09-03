package
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 网络传输用的整包
	 * @author weism
	 */
	public class NetPacket
	{
		private static const SIZE_BYTES_HEAD:int = 6;
		
		private var _cmdId:uint = 0;
		private var _content:ByteArray;
		private var _dataRaw:Array;
		
		public function NetPacket(cmdId:uint)
		{
			_cmdId = cmdId;
			_content = new ByteArray();
			_content.endian = Endian.LITTLE_ENDIAN;
			_dataRaw = [];
		}
		
		public function get cmdId():uint
		{
			return _cmdId;
		}
		
		public function get content():ByteArray
		{
			return _content;
		}
		
		public function get dataRaw():Array 
		{
			return _dataRaw;
		}
		
		public static function buildPacket(buf:ByteArray):NetPacket
		{
			var pk:NetPacket = new NetPacket(0);
			if (pk.unpack(buf))
			{
				return pk;
			}
			return null;
		}
		
		public function unpack(buf:ByteArray):Boolean
		{
			if (buf.bytesAvailable < SIZE_BYTES_HEAD)
			{
				return false; // 长度不够，默认是6位至少
			}
			var pos:int = buf.position;
			var len:uint = buf.readUnsignedInt();
			if (buf.bytesAvailable < len + SIZE_BYTES_HEAD - 4)
			{
				buf.position = pos;
				return false;
			}
			_cmdId = buf.readShort();
			if (len > 0)
			{
				_content.writeBytes(buf, buf.position, len);
				buildDataRaw();
				buf.position += len;
				_content.position = 0;
			}
			return true;
		}
		
		private function buildDataRaw():void
		{
			if (_content && _content.length > 0) 
			{
				var len:int = CmdHandler.CMD_FMT[cmdId].length;
				for (var i:int = 0; i < len; i++) 
				{
					var type:String = CmdHandler.CMD_FMT[cmdId].charAt(i);
					switch (type) 
					{
						case "I":
							_dataRaw.push(_content.readUnsignedInt());
						break;
						case "H":
							_dataRaw.push(_content.readUnsignedShort());
						break;
						case "i":
							_dataRaw.push(_content.readInt());
						break;
						case "d":
							_dataRaw.push(_content.readDouble());
						break;
						case "s":
							_dataRaw.push(_content.readUTF());
						break;
						default:
						break;
					}
				}
			}
		}
		
		public function pack():ByteArray
		{
			var sendByt:ByteArray = new ByteArray();
			sendByt.writeUnsignedInt(_content.length);
			sendByt.writeShort(_cmdId);
			sendByt.writeBytes(_content);
			return sendByt;
		}
	
	}

}