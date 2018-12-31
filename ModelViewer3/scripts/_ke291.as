package
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class _ke291
   {
       
      
      private var _gj1374:String;
      
      private var _fb606:int = 10;
      
      public var error:Boolean = false;
      
      public var _xp426:Array;
      
      public var components:Array;
      
      public var _sp553:Boolean = true;
      
      public var _uo542:Array;
      
      public var _kg1025:Number = 1.0;
      
      public var _dk154:Number = 0.0;
      
      public var _nm696:Array;
      
      public var _jg1045:int = 0;
      
      public var listeners:Array;
      
      public var _qq212:int = 0;
      
      private var _iv1170:Boolean = false;
      
      private var _uv798:String;
      
      public var _sb154:Array;
      
      public var _in1348:Boolean = true;
      
      public var _tg728:Boolean = false;
      
      private var _cq513:String;
      
      public var _ui1229:Number = 0.0;
      
      public var _oh540:String = null;
      
      public var _fa511:Boolean = true;
      
      public function _ke291(param1:String, param2:String, param3:String, param4:String, param5:String = null, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false)
      {
         this._uo542 = [];
         this._xp426 = [];
         this.components = [];
         this._nm696 = [];
         this._sb154 = [];
         this.listeners = [];
         super();
         if(param5)
         {
            this._gj1374 = param5;
         }
         else
         {
            this._gj1374 = param3 + "character-model.xml?n=" + param1 + "&r=" + param2;
         }
         if(param6)
         {
            this._gj1374 = this._gj1374 + (!!param7?"&cape=1":"&cape=0");
         }
         if(param8)
         {
            this._fa511 = param9;
            this._gj1374 = this._gj1374 + (!!param9?"&tabard=1":"&tabard=0");
         }
         if(param10)
         {
            this._fa511 = param11;
            this._gj1374 = this._gj1374 + (!!param11?"&helm=1":"&helm=0");
         }
         this._cq513 = param4;
      }
      
      public function _ch1297() : Array
      {
         return this._sb154;
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
      }
      
      public function _wy114() : Number
      {
         var _loc3_:_cd1218 = null;
         if(this.error)
         {
            return 0;
         }
         var _loc1_:Number = this._fb606;
         var _loc2_:Number = !!this._iv1170?Number(this._fb606):Number(0);
         for each(_loc3_ in this._uo542)
         {
            _loc1_ = _loc1_ + _loc3_._qp1405();
            _loc2_ = _loc2_ + _loc3_._yq1112();
         }
         if(_loc1_ == 0)
         {
            return 0;
         }
         return _loc2_ / _loc1_;
      }
      
      public function _et516() : _hg665
      {
         return this._uo542[0]._am1119();
      }
      
      public function _ec1358(param1:String) : void
      {
         var _loc2_:Object = null;
         this.error = true;
         for each(_loc2_ in this.listeners)
         {
            _loc2_._rd34(param1);
         }
      }
      
      public function _vu576() : Array
      {
         return this._nm696;
      }
      
      private function _ug634(param1:Event) : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:XML = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Array = null;
         var _loc15_:XMLList = null;
         var _loc16_:XMLList = null;
         var _loc17_:Array = null;
         var _loc18_:XMLList = null;
         var _loc19_:_cd1218 = null;
         var _loc20_:int = 0;
         var _loc21_:String = null;
         var _loc22_:XMLList = null;
         var _loc23_:Array = null;
         var _loc24_:_xy565 = null;
         var _loc25_:XML = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:_xr701 = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:String = null;
         var _loc36_:String = null;
         var _loc37_:int = 0;
         var _loc38_:_xy565 = null;
         var _loc39_:Array = null;
         var _loc40_:_cd1218 = null;
         var _loc41_:XML = null;
         var _loc42_:String = null;
         var _loc43_:String = null;
         var _loc44_:String = null;
         var _loc45_:_vq97 = null;
         this._iv1170 = true;
         var _loc2_:XML = new XML(param1.target.data);
         _loc3_ = _loc2_.character.models..model;
         var _loc7_:int = 0;
         if(_loc2_.character.@owned)
         {
            this._tg728 = int(_loc2_.character.@owned) == 1;
         }
         if(!_loc3_ || _loc3_.length() <= 0)
         {
            this._ec1358("characterNotFound");
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc10_ = _loc3_[_loc4_];
            _loc11_ = _loc10_.@name;
            _loc12_ = _loc10_.@modelFile;
            _loc13_ = _loc10_.@skinFile;
            if(_loc10_.@baseY)
            {
               this._dk154 = _loc10_.@baseY;
            }
            if(_loc10_.@facedY)
            {
               this._ui1229 = _loc10_.@facedY;
            }
            if(_loc10_.@scale)
            {
               this._kg1025 = _loc10_.@scale;
            }
            if(_loc10_.@hideCape)
            {
               this._in1348 = int(_loc10_.@hideCape) == 0;
            }
            if(_loc10_.@hideHelm)
            {
               this._sp553 = int(_loc10_.@hideHelm) == 0;
            }
            _loc12_ = this._cq513 + _loc12_.toLowerCase();
            _loc13_ = this._cq513 + _loc13_.toLowerCase();
            this._uv798 = _loc12_.replace(".m2","");
            _loc14_ = [];
            _loc15_ = _loc3_[_loc4_].components..component;
            _loc5_ = 0;
            while(_loc5_ < _loc15_.length())
            {
               _loc14_.push(_loc15_[_loc5_].@n);
               _loc5_++;
            }
            _loc16_ = _loc3_[_loc4_].textures..texture;
            _loc5_ = 0;
            while(_loc5_ < _loc16_.length())
            {
               _loc20_ = _loc16_[_loc5_].@id;
               _loc21_ = _loc16_[_loc5_].@file;
               _loc21_ = this._cq513 + _loc21_.toLowerCase();
               _loc22_ = _loc16_[_loc5_]..subTexture;
               _loc23_ = [];
               if(_loc22_ != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc22_.length())
                  {
                     _loc25_ = _loc22_[_loc6_];
                     _loc26_ = _loc25_.@file;
                     _loc27_ = _loc25_.@fileBackup;
                     if(_loc27_ != null && _loc27_.length <= 0)
                     {
                        _loc27_ = null;
                     }
                     _loc28_ = _loc25_.@x;
                     _loc29_ = _loc25_.@y;
                     _loc30_ = _loc25_.@w;
                     _loc31_ = _loc25_.@h;
                     _loc26_ = this._cq513 + _loc26_.toLowerCase();
                     if(_loc27_)
                     {
                        _loc27_ = this._cq513 + _loc27_.toLowerCase();
                     }
                     _loc32_ = new _xr701(-1,_loc26_,_loc27_,null,_loc28_,_loc29_,_loc30_,_loc31_);
                     if(_loc32_)
                     {
                        _loc23_.push(_loc32_);
                     }
                     _loc6_++;
                  }
               }
               _loc24_ = new _xy565(_loc20_,_loc21_,null,_loc23_);
               this._xp426.push(_loc24_);
               _loc5_++;
            }
            _loc17_ = [];
            _loc18_ = _loc3_[_loc4_].attachments..attachment;
            _loc5_ = 0;
            while(_loc5_ < _loc18_.length())
            {
               _loc33_ = _loc18_[_loc5_].@modelFile;
               _loc34_ = _loc18_[_loc5_].@skinFile;
               _loc35_ = _loc18_[_loc5_].@texture;
               _loc36_ = _loc18_[_loc5_].@type;
               _loc33_ = this._cq513 + _loc33_.toLowerCase();
               _loc34_ = this._cq513 + _loc34_.toLowerCase();
               _loc35_ = this._cq513 + _loc35_.toLowerCase();
               _loc37_ = _loc18_[_loc5_].@linkPoint;
               _loc38_ = new _xy565(2,_loc35_);
               _loc39_ = [];
               _loc39_.push(_loc38_);
               _loc40_ = new _cd1218(-1,this._cq513,_loc33_,_loc34_,null,_loc39_,null,_loc37_,_loc36_);
               _loc17_.push(_loc40_);
               _loc5_++;
            }
            this.components[_loc7_] = _loc14_;
            _loc19_ = new _cd1218(_loc7_,this._cq513,_loc12_,_loc13_,this.components,this._xp426,_loc17_);
            _loc19_._al1052 = true;
            _loc19_._qg81(this);
            this._qq212++;
            _loc19_.load();
            this._uo542.push(_loc19_);
            _loc4_++;
         }
         var _loc8_:XMLList = _loc2_..animation;
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length())
         {
            _loc41_ = _loc8_[_loc5_];
            _loc42_ = _loc41_.@key;
            _loc43_ = _loc41_.@id;
            _loc44_ = _loc41_.@weapons;
            if(_loc41_ && _loc43_ && _loc42_ && _loc44_)
            {
               _loc45_ = new _vq97(_loc41_);
               this._nm696.push(_loc45_);
            }
            _loc5_++;
         }
         var _loc9_:XMLList = _loc2_..background;
         _loc5_ = 0;
         while(_loc5_ < _loc9_.length())
         {
            this._sb154.push(new _bs710(_loc9_[_loc5_],this._cq513));
            _loc5_++;
         }
      }
      
      private function _wk404() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:_cd1218 = null;
         var _loc4_:_hg665 = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:_cd1218 = null;
         if(this.error)
         {
            return false;
         }
         if(this._qq212 == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._uo542.length)
            {
               _loc3_ = this._uo542[_loc1_];
               _loc4_ = _loc3_._am1119();
               _loc5_ = _loc3_._hp1175();
               _loc6_ = this.components[_loc1_];
               _loc7_ = _loc3_._ju514();
               if(_loc4_ != null)
               {
                  if(_loc6_ != null)
                  {
                     for each(_loc8_ in _loc6_)
                     {
                        _loc4_._tg39(_loc8_,_loc5_);
                     }
                     _loc4_._tg39(1,_loc5_);
                  }
                  if(_loc7_ != null)
                  {
                     for each(_loc9_ in _loc7_)
                     {
                        if(_loc9_._am1119() != null)
                        {
                           _loc4_.attach(_loc9_);
                        }
                     }
                  }
                  _loc4_._uv798 = this._uv798;
                  _loc4_.cleanUp();
               }
               _loc1_++;
            }
            for each(_loc2_ in this.listeners)
            {
            }
            this.listeners = null;
            return true;
         }
         return false;
      }
      
      public function load() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         if(this._gj1374 != null)
         {
            _loc1_ = new URLLoader();
            _loc1_.addEventListener(Event.COMPLETE,this._ug634,false,0,true);
            _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this._ql664,false,0,true);
            _loc1_.addEventListener(IOErrorEvent.NETWORK_ERROR,this._ql664,false,0,true);
            _loc2_ = new URLRequest(this._gj1374);
            _loc1_.load(_loc2_);
         }
      }
      
      public function _bk654(param1:_cd1218) : void
      {
         if(param1.id == 0)
         {
            this._ec1358("modelLoadError");
            return;
         }
         this._qq212--;
         this._uo542[param1.id] = param1;
         this._wk404();
      }
      
      public function _qg81(param1:Object) : void
      {
         this.listeners.push(param1);
      }
      
      public function _bl744() : String
      {
         var _loc2_:_cd1218 = null;
         var _loc1_:String = "";
         for each(_loc2_ in this._uo542)
         {
            _loc1_ = _loc1_ + _loc2_._bl744();
         }
         return _loc1_;
      }
      
      public function _ql664(param1:Event) : void
      {
         this._ec1358("connectionError");
      }
      
      public function _vt1344(param1:_cd1218) : void
      {
         this._qq212--;
         this._uo542[param1.id] = param1;
         this._wk404();
      }
   }
}
