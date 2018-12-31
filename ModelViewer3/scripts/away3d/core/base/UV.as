package away3d.core.base
{
   import away3d.core.utils.ValueObject;
   
   public class UV extends ValueObject
   {
       
      
      public var extra:Object;
      
      var _u:Number;
      
      var _v:Number;
      
      public function UV(param1:Number = 0, param2:Number = 0)
      {
         super();
         this._u = param1;
         this._v = param2;
      }
      
      static function median(param1:UV, param2:UV) : UV
      {
         if(param1 == null)
         {
            return null;
         }
         if(param2 == null)
         {
            return null;
         }
         return new UV((param1._u + param2._u) / 2,(param1._v + param2._v) / 2);
      }
      
      static function weighted(param1:UV, param2:UV, param3:Number, param4:Number) : UV
      {
         if(param1 == null)
         {
            return null;
         }
         if(param2 == null)
         {
            return null;
         }
         var _loc5_:Number = param3 + param4;
         var _loc6_:Number = param3 / _loc5_;
         var _loc7_:Number = param4 / _loc5_;
         return new UV(param1._u * _loc6_ + param2._u * _loc7_,param1._v * _loc6_ + param2._v * _loc7_);
      }
      
      override public function toString() : String
      {
         return "new UV(" + this._u + ", " + this._v + ")";
      }
      
      public function get v() : Number
      {
         return this._v;
      }
      
      public function set u(param1:Number) : void
      {
         if(param1 == this._u)
         {
            return;
         }
         this._u = param1;
         notifyChange();
      }
      
      public function set v(param1:Number) : void
      {
         if(param1 == this._v)
         {
            return;
         }
         this._v = param1;
         notifyChange();
      }
      
      public function get u() : Number
      {
         return this._u;
      }
      
      public function clone() : UV
      {
         return new UV(this._u,this._v);
      }
   }
}
