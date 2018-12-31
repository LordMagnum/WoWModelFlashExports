package
{
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import flash.utils.ByteArray;
   
   public class _nx958
   {
      
      private static var _br681:_gs89 = new _gs89(0,0,0);
      
      private static var _xt756:Number = 1 / 255;
       
      
      public var uv:UV;
      
      public var active:Boolean;
      
      public var normal:_gs89;
      
      public var _cx739:_lg1403;
      
      public var vertex:Vertex;
      
      public var position:_gs89;
      
      public var _gm612:Array;
      
      public var indices:Array;
      
      public var _rn255:int;
      
      public function _nx958(param1:ByteArray)
      {
         super();
         this.position = _gs89._wg1203(param1);
         this._gm612 = _wl552._ok1365(param1,4);
         this.indices = _wl552._ok1365(param1,4);
         this.normal = _gs89._wg1203(param1);
         this._cx739 = _lg1403._wg1203(param1);
         param1.position = param1.position + 8;
         this.vertex = new Vertex(this.position.x,this.position.z,-this.position.y);
         this.uv = new UV(this._cx739.x,1 - this._cx739.y);
         this.active = false;
         this._rn255 = 0;
      }
      
      public function _oh897(param1:Vector.<_ex1172>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:_ex1172 = null;
         var _loc5_:_kp1215 = null;
         if(this._rn255 <= 0)
         {
            return;
         }
         _br681.zero();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this._gm612[_loc2_];
            if(_loc3_ > 0)
            {
               _loc4_ = param1[this.indices[_loc2_]];
               _loc5_ = _loc4_._jl938;
               _loc5_._rj153(this.position,_br681,_loc3_);
            }
            _loc2_++;
         }
         _br681._ss945(_xt756);
         this.vertex.setValue(-_br681.x,_br681.z,-_br681.y);
      }
   }
}
