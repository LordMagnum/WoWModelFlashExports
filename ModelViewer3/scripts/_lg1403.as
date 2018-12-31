package
{
   import flash.utils.ByteArray;
   
   public final class _lg1403
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function _lg1403()
      {
         super();
         this.x = 0;
         this.y = 0;
      }
      
      public static function _wg1203(param1:ByteArray) : _lg1403
      {
         var _loc2_:_lg1403 = new _lg1403();
         _loc2_.x = param1.readFloat();
         _loc2_.y = param1.readFloat();
         return _loc2_;
      }
   }
}
