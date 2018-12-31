package
{
   import away3d.materials.TransformBitmapMaterial;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   
   public class _rn1037
   {
       
      
      public var _eh190:Array;
      
      public var _lu1230:Array;
      
      public var _bi835:Array;
      
      public var _fe863:Array;
      
      public var materials:Array;
      
      public var _rj455:Array;
      
      public var _qg444:Array;
      
      public function _rn1037(param1:ByteArray)
      {
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         super();
         this._fe863 = [];
         this._lu1230 = [];
         this._eh190 = [];
         this._qg444 = [];
         this._rj455 = [];
         this._bi835 = [];
         this.materials = [];
         if(param1 == null)
         {
            return;
         }
         var _loc2_:_ap392 = new _ap392(param1);
         var _loc3_:_ap392 = new _ap392(param1);
         var _loc4_:_ap392 = new _ap392(param1);
         var _loc7_:int = param1.position;
         _wl552._ja279(param1,_loc2_,this._fe863,this._lu1230);
         _wl552._ja279(param1,_loc4_,this._rj455,this._bi835);
         _wl552._ih1386(param1,_loc3_,this._eh190,this._qg444);
         param1.position = _loc7_;
      }
      
      public function getRotation(param1:int) : _vc586
      {
         var _loc2_:_vc586 = _wl552._ss923(param1,this._eh190[0],this._qg444[0]);
         if(_loc2_ == null)
         {
            return new _vc586();
         }
         return _loc2_;
      }
      
      public function _yh865(param1:int) : _gs89
      {
         var _loc2_:_gs89 = _wl552._pr1196(param1,this._rj455[0],this._bi835[0]);
         return _loc2_;
      }
      
      public function updateMaterials(param1:int) : void
      {
         var _loc4_:TransformBitmapMaterial = null;
         var _loc5_:Matrix = null;
         var _loc6_:Boolean = false;
         if(this.materials.length == 0)
         {
            return;
         }
         var _loc2_:_gs89 = this._ml1282(param1);
         var _loc3_:_gs89 = this._yh865(param1);
         for each(_loc4_ in this.materials)
         {
            _loc5_ = new Matrix();
            _loc6_ = false;
            if(_loc3_ != null)
            {
            }
            if(_loc2_ != null)
            {
               _loc5_.translate(_loc2_.x * _loc4_.width,(1 - _loc2_.y) * _loc4_.height);
               _loc6_ = true;
            }
            _loc4_.transform = _loc5_;
            if(_loc6_)
            {
               _loc4_.invalidateFaces();
            }
         }
      }
      
      public function addMaterial(param1:TransformBitmapMaterial) : void
      {
         this.materials.push(param1);
      }
      
      public function _ci951(param1:int) : Matrix
      {
         return null;
      }
      
      public function _ml1282(param1:int) : _gs89
      {
         var _loc2_:_gs89 = _wl552._pr1196(param1,this._fe863[0],this._lu1230[0]);
         if(_loc2_ == null)
         {
            return new _gs89(0,0,0);
         }
         return _loc2_;
      }
   }
}
