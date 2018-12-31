package
{
   import away3d.core.base.Mesh;
   import flash.utils.ByteArray;
   
   public class _kp594
   {
       
      
      public var visible:Boolean;
      
      public var _aw315:Array;
      
      public var _sh756:int;
      
      public var _gm1300:Array;
      
      public var _nr1242:Array;
      
      public var _dj234:Array;
      
      public var model:_hg665;
      
      public var _uf1370:Array;
      
      public var _xy319:int;
      
      public var _ao170:Array;
      
      public function _kp594(param1:ByteArray, param2:_hg665)
      {
         var _loc6_:int = 0;
         super();
         var _loc3_:_ap392 = new _ap392(param1);
         var _loc4_:_ap392 = new _ap392(param1);
         this._sh756 = _loc3_._us904;
         this._xy319 = _loc4_._us904;
         this._uf1370 = [];
         this._aw315 = [];
         this._ao170 = [];
         this._nr1242 = [];
         var _loc5_:int = param1.position;
         var _loc7_:Array = _wl552._ou1381(param1,_loc4_._af843);
         var _loc8_:Array = _wl552._ou1381(param1,_loc4_._rb697);
         if(_loc7_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_.length)
            {
               this._ao170[_loc6_] = _wl552._xv388(param1,_loc7_[_loc6_]);
               this._nr1242[_loc6_] = _wl552._pr536(param1,_loc8_[_loc6_]);
               _loc6_++;
            }
         }
         param1.position = _loc5_;
         this.model = param2;
         this._dj234 = [];
         this._gm1300 = [];
         this.visible = true;
      }
      
      public function _gg1157(param1:_pg792, param2:Mesh) : void
      {
         this._dj234.push(param2);
         this._gm1300.push(param1);
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Mesh = null;
         var _loc6_:_pg792 = null;
         if(this._dj234.length == 0)
         {
            return;
         }
         if(this._ao170.length > 0)
         {
            if(param2 > this._ao170.length)
            {
               param2 = 0;
            }
            _loc3_ = param1 % this._nr1242[param2][this._nr1242[param2].length - 1];
            _loc4_ = _wl552._ni1117(_loc3_,this._ao170[param2],this._nr1242[param2]);
            if(_loc4_ < 1024 && this.visible)
            {
               for each(_loc5_ in this._dj234)
               {
                  _loc5_.visible = false;
               }
               for each(_loc6_ in this._gm1300)
               {
                  this.model._tm1411(_loc6_);
               }
               this.visible = false;
               return;
            }
            if(_loc4_ >= 1024 && !this.visible)
            {
               for each(_loc5_ in this._dj234)
               {
                  _loc5_.visible = true;
               }
               for each(_loc6_ in this._gm1300)
               {
                  this.model._me1162(_loc6_);
               }
               this.visible = true;
            }
         }
      }
   }
}
