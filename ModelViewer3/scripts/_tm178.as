package
{
   import flash.utils.Dictionary;
   
   public class _tm178
   {
      
      private static var _vn17:Dictionary = new Dictionary();
       
      
      public function _tm178()
      {
         super();
      }
      
      public static function init(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:XMLList = param1..string;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc4_.@key;
            _loc6_ = _loc4_.@string;
            if(_loc5_ && _loc6_)
            {
               _vn17[_loc5_] = _loc6_;
            }
            _loc3_++;
         }
      }
      
      public static function get(param1:String) : String
      {
         var _loc2_:Object = _vn17[param1];
         if(!_loc2_)
         {
            return param1;
         }
         var _loc3_:String = String(_loc2_);
         trace(param1 + " : " + _loc3_);
         return _loc3_;
      }
   }
}
