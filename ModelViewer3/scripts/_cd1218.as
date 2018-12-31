package
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class _cd1218
   {
      
      public static var _lg679:Array = new Array(60,61,62,64,65,66,67,68,69,70,73,74,75,76,77,78,80,81,82,83,84,89,96,97,98,99,100,101,102,103,104,113,119,120,123,128,129,133,134,185,186,195);
       
      
      public var _xp426:Array;
      
      public var loader:URLLoader;
      
      public var components:Array;
      
      public var _uo542:Array;
      
      public var id:int;
      
      public var _jh1390:String;
      
      public var model:_hg665;
      
      public var _qq212:int = 0;
      
      public var textures:Array;
      
      public var _tp240:int;
      
      public var _jg1045:int = 0;
      
      public var _ti178:String;
      
      public var listeners:Array;
      
      public var _wy1399:Boolean = false;
      
      public var _al1052:Boolean = false;
      
      public var _hr874:Boolean = false;
      
      public var _pr398:Boolean = false;
      
      public var _fw134:String;
      
      public var _jg95:String;
      
      public function _cd1218(param1:int, param2:String, param3:String, param4:String, param5:Array, param6:Array = null, param7:Array = null, param8:int = -1, param9:String = null)
      {
         this.listeners = [];
         super();
         this.id = param1;
         this._fw134 = param2;
         this._jh1390 = param3;
         this._jg95 = param4;
         this.components = param5;
         this._xp426 = param6;
         this._uo542 = param7;
         this._tp240 = param8;
         this._ti178 = param9;
         this.textures = [];
      }
      
      public function release() : void
      {
         var _loc1_:_cd1218 = null;
         var _loc2_:_xy565 = null;
         for each(_loc1_ in this._uo542)
         {
            _loc1_.release();
         }
         for each(_loc2_ in this._xp426)
         {
            _loc2_.release();
         }
         this._uo542 = null;
         this._xp426 = null;
         this.listeners = null;
         this.model = null;
      }
      
      public function _mu405(param1:_xy565) : void
      {
         this._jg1045--;
         this._wk404();
      }
      
      public function _up953(param1:Event) : void
      {
         var _loc4_:_iq662 = null;
         var _loc5_:_xy565 = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:ByteArray = param1.target.data;
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         this.model = new _hg665(_loc2_);
         var _loc3_:int = 0;
         if(this.model != null)
         {
            this.model._ti178 = this._ti178;
            this.model._gd117 = this._tp240;
            for each(_loc4_ in this.model._ou1181)
            {
               if(_loc4_.type == 0)
               {
                  _loc5_ = new _xy565(0,this._fw134 + _loc4_._aj418.toLowerCase());
                  _loc5_._sv1144 = _loc4_._aj418;
                  this._xp426.push(_loc5_);
                  this._jg1045++;
                  _loc5_._qg81(this);
                  _loc5_.load();
               }
            }
            if(this._al1052)
            {
               _loc6_ = 0;
               _loc7_ = 0;
               while(_loc7_ < this.model._ft1167.length)
               {
                  if(_loc6_ < _lg679.length && _loc7_ == _lg679[_loc6_])
                  {
                     _loc6_++;
                  }
                  else
                  {
                     this.model._la487(_loc7_,_loc2_);
                  }
                  _loc7_++;
               }
            }
            this._wy1399 = true;
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE,this._ld46,false,0,true);
            this.loader.addEventListener(IOErrorEvent.IO_ERROR,this._ot1327,false,0,true);
            this.loader.addEventListener(IOErrorEvent.NETWORK_ERROR,this._ot1327,false,0,true);
            this.loader.dataFormat = URLLoaderDataFormat.BINARY;
            this.loader.load(new URLRequest(this._jg95));
         }
         else
         {
            this._nu586(null);
         }
      }
      
      public function _hp1175() : Array
      {
         return this.textures;
      }
      
      public function _bl744() : String
      {
         var _loc2_:_cd1218 = null;
         var _loc3_:_xy565 = null;
         var _loc1_:String = "";
         if(this._yq1112() == this._qp1405())
         {
            return "";
         }
         _loc1_ = _loc1_ + (this._jh1390.slice(40) + " " + this._yq1112() + " " + this._qp1405() + "\n");
         for each(_loc2_ in this._uo542)
         {
            _loc1_ = _loc1_ + _loc2_._bl744();
         }
         for each(_loc3_ in this._xp426)
         {
            _loc1_ = _loc1_ + _loc3_._bl744();
         }
         return _loc1_;
      }
      
      public function _am1119() : _hg665
      {
         return this.model;
      }
      
      public function _qp1405() : int
      {
         var _loc2_:_cd1218 = null;
         var _loc3_:_xy565 = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._uo542)
         {
            _loc1_ = _loc1_ + _loc2_._qp1405();
         }
         for each(_loc3_ in this._xp426)
         {
            _loc1_ = _loc1_ + _loc3_._qp1405();
         }
         return _loc1_ + 2;
      }
      
      public function _yq1112() : int
      {
         var _loc2_:_cd1218 = null;
         var _loc3_:_xy565 = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._uo542)
         {
            _loc1_ = _loc1_ + _loc2_._yq1112();
         }
         for each(_loc3_ in this._xp426)
         {
            _loc1_ = _loc1_ + _loc3_._yq1112();
         }
         if(this._wy1399)
         {
            _loc1_++;
         }
         if(this._hr874)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function _nu845() : int
      {
         return this._tp240;
      }
      
      public function _nu586(param1:Event) : void
      {
         var _loc2_:Object = null;
         trace("error loading model: " + param1);
         for each(_loc2_ in this.listeners)
         {
            _loc2_._bk654(this);
         }
      }
      
      public function _ld46(param1:Event) : void
      {
         var _loc2_:ByteArray = param1.target.data;
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         this.model._ld46(_loc2_);
         this._hr874 = true;
         this.loader = null;
         this._wk404();
      }
      
      public function _wk404() : void
      {
         var _loc1_:Object = null;
         if(this._ut669())
         {
            for each(_loc1_ in this.listeners)
            {
               _loc1_._vt1344(this);
            }
            this.listeners = null;
         }
      }
      
      public function _ot1327(param1:Event) : void
      {
         var _loc2_:Object = null;
         this.model = null;
         for each(_loc2_ in this.listeners)
         {
            _loc2_._bk654(this);
         }
      }
      
      public function _bk654(param1:_cd1218) : void
      {
         this._qq212--;
         this._wk404();
      }
      
      public function _qg81(param1:Object) : void
      {
         this.listeners.push(param1);
      }
      
      public function load() : void
      {
         var _loc1_:_xy565 = null;
         var _loc2_:_cd1218 = null;
         this.loader = new URLLoader();
         this.loader.addEventListener(Event.COMPLETE,this._up953,false,0,true);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this._nu586,false,0,true);
         this.loader.addEventListener(IOErrorEvent.NETWORK_ERROR,this._nu586,false,0,true);
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.load(new URLRequest(this._jh1390));
         if(this._xp426 != null)
         {
            for each(_loc1_ in this._xp426)
            {
               _loc1_._qg81(this);
               this._jg1045++;
               _loc1_.load();
            }
         }
         if(this._uo542 != null)
         {
            for each(_loc2_ in this._uo542)
            {
               _loc2_._qg81(this);
               this._qq212++;
               _loc2_.load();
            }
         }
         this._pr398 = false;
      }
      
      public function _hp908(param1:_xy565) : void
      {
         this._jg1045--;
         if(param1.id == 0)
         {
            this.model._cx47(param1._sv1144,param1);
         }
         else
         {
            this.textures[param1.id] = param1;
         }
         this._wk404();
      }
      
      public function _ut669() : Boolean
      {
         return this._wy1399 && this._hr874 && this._jg1045 <= 0 && this._qq212 <= 0;
      }
      
      public function _ju514() : Array
      {
         if(this._uo542 == null)
         {
            return [];
         }
         return this._uo542;
      }
      
      public function _vt1344(param1:_cd1218) : void
      {
         this._qq212--;
         this._wk404();
      }
   }
}
