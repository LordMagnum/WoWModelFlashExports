package
{
   import flash.utils.ByteArray;
   
   public class _be715
   {
       
      
      public var animation:_vq97;
      
      public var listeners:Array;
      
      public var model:_hg665;
      
      public var _yn641:int;
      
      public var _im1393:String;
      
      public var _by324:Array;
      
      public function _be715(param1:_hg665, param2:_vq97, param3:String)
      {
         this.listeners = [];
         this._by324 = [];
         super();
         this.animation = param2;
         this.model = param1;
         this._im1393 = param3;
         var _loc4_:int = param2.id;
         var _loc5_:int = param1._ft1167[_loc4_];
         var _loc6_:_nm1047 = param1._nm696[_loc5_];
         this._by324[0] = _loc5_;
         var _loc7_:int = 1;
         while(_loc6_)
         {
            if(_loc6_._le375 == _md341._qi1135)
            {
               break;
            }
            this._by324[_loc7_] = _loc6_._le375;
            _loc6_ = param1._nm696[_loc6_._le375];
            _loc7_++;
         }
         this._yn641 = _loc7_;
      }
      
      public static function _ty159(param1:_hg665, param2:_vq97, param3:String) : _be715
      {
         var _loc4_:int = param1._ft1167[param2.id];
         if(_loc4_ < 0)
         {
            return null;
         }
         return new _be715(param1,param2,param3);
      }
      
      public function load() : void
      {
         var _loc2_:_qk1030 = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._by324.length)
         {
            _loc2_ = new _qk1030(_loc1_,this._im1393 + _wl552._lv815(this.animation.id) + "-" + _wl552._rs277(_loc1_) + ".anim");
            _loc2_._qg81(this);
            _loc2_.load();
            _loc1_++;
         }
      }
      
      public function loadBytes(param1:int, param2:ByteArray) : void
      {
         var _loc3_:Object = null;
         this.model._ai693(this._by324[param1],param2);
         this._yn641--;
         if(this._yn641 <= 0)
         {
            for each(_loc3_ in this.listeners)
            {
               _loc3_._oj1063(this.animation);
            }
            this.model._cr1245[this.animation.id] = true;
         }
      }
      
      public function _qg81(param1:Object) : void
      {
         this.listeners.push(param1);
      }
   }
}
