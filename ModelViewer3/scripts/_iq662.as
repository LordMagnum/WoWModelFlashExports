package
{
   import flash.utils.ByteArray;
   
   public class _iq662
   {
      
      public static var _lx401:int = 3;
       
      
      public var _aj418:String;
      
      public var flags:int;
      
      public var type:int;
      
      public function _iq662(param1:ByteArray)
      {
         super();
         this.type = param1.readUnsignedInt();
         this.flags = param1.readUnsignedShort();
         var _loc2_:int = param1.readUnsignedShort();
         var _loc3_:_jk827 = new _jk827(param1);
         var _loc4_:int = param1.position;
         param1.position = _loc3_.offset;
         this._aj418 = param1.readUTFBytes(param1.length - param1.position);
         this._aj418 = this._aj418.replace("blp","png");
         this._aj418 = this._aj418.replace("BLP","png");
         while(this._aj418.indexOf("\\") >= 0)
         {
            this._aj418 = this._aj418.replace("\\","/");
         }
         param1.position = _loc4_;
      }
   }
}
