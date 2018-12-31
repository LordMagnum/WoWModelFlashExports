package
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class _xy565
   {
      
      public static var _ko1298:BitmapData;
      
      private static var _in1109:Number = 256;
       
      
      public var _pb123:int;
      
      public var _rs618:Array;
      
      public var loaded:Boolean = false;
      
      public var error:Boolean = false;
      
      public var _sv412:Loader;
      
      public var _is829:Boolean = false;
      
      public var id:int;
      
      public var _sv1144:String;
      
      public var _xj1181:String = null;
      
      public var _fl640:Boolean = false;
      
      private var _vv543:Number = 1.0;
      
      public var _wc348:ByteArray = null;
      
      public var _jg1045:int;
      
      public var listeners:Array;
      
      public var _vg116:URLLoader;
      
      public var _pa1353:Loader;
      
      public var _kp263:URLLoader;
      
      public var _fu1213:String;
      
      public var _il104:BitmapData;
      
      public var _lj886:ByteArray = null;
      
      public var _yy958:BitmapData;
      
      public function _xy565(param1:int, param2:String, param3:String = null, param4:Array = null)
      {
         this.listeners = [];
         super();
         var _loc5_:RegExp = / /g;
         param2 = param2.replace(_loc5_,"");
         if(param3)
         {
            param3 = param3.replace(_loc5_,"");
         }
         this.id = param1;
         this._fu1213 = param2;
         this._xj1181 = param3;
         if(param4 != null)
         {
            this._rs618 = param4;
         }
         else
         {
            this._rs618 = [];
         }
         this._jg1045 = 4 + this._rs618.length;
         this._pb123 = this._jg1045;
      }
      
      public function _ha1405(param1:Event) : void
      {
         this._lj886 = this._vg116.data;
         this._jg1045--;
         this._sv412 = new Loader();
         this._sv412.contentLoaderInfo.addEventListener(Event.COMPLETE,this._hp786);
         this._sv412.loadBytes(this._lj886);
      }
      
      public function _bl744() : String
      {
         var _loc2_:_xr701 = null;
         var _loc1_:String = "";
         if(this._jg1045 == 0)
         {
            return _loc1_;
         }
         if(this.loaded)
         {
         }
         for each(_loc2_ in this._rs618)
         {
            _loc1_ = _loc1_ + _loc2_._bl744();
         }
         return _loc1_;
      }
      
      public function release() : void
      {
         var _loc1_:_xr701 = null;
         for each(_loc1_ in this._rs618)
         {
            _loc1_.release();
         }
         this._rs618 = null;
         this.listeners = null;
      }
      
      public function _ti836(param1:Event) : void
      {
         this._wc348 = this._kp263.data;
         this._jg1045--;
         this._pa1353 = new Loader();
         this._pa1353.contentLoaderInfo.addEventListener(Event.COMPLETE,this._ut1300);
         this._pa1353.loadBytes(this._wc348);
      }
      
      public function _hp908(param1:_xy565) : void
      {
         this._jg1045--;
         this._wk404();
      }
      
      public function _mu405(param1:_xy565) : void
      {
         this._jg1045--;
         this._wk404();
      }
      
      public function getBitmap(param1:Boolean) : BitmapData
      {
         if(!param1 && this._yy958)
         {
            return this._yy958;
         }
         if(param1 && this._il104)
         {
            return this._il104;
         }
         if(!this._lj886)
         {
            return null;
         }
         var _loc2_:Loader = new Loader();
         if(!this._yy958)
         {
            _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._hp786);
            _loc2_.loadBytes(this._lj886);
            this._yy958 = new BitmapData(_loc2_.width,_loc2_.height,false,16777215);
            this._yy958.draw(_loc2_);
            _loc2_.unload();
         }
         if(!param1)
         {
            return this._yy958;
         }
         _loc2_.loadBytes(this._wc348);
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,false,0);
         _loc3_.draw(_loc2_);
         _loc2_.unload();
         this._il104 = this._yy958.clone();
         this._il104.copyChannel(_loc3_,_loc3_.rect,new Point(0,0),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         _loc3_.dispose();
         return this._il104;
      }
      
      public function _yd1254(param1:Event) : void
      {
         var _loc2_:String = null;
         if(this._jg1045 == 0)
         {
            return;
         }
         this.error = true;
         if(this._xj1181 != null && this._xj1181.length != 0 && !this._fl640)
         {
            this._fl640 = true;
            _loc2_ = this._xj1181;
            this._kp263.load(new URLRequest(_loc2_));
            return;
         }
         this._jg1045 = this._jg1045 - 2;
         this._wk404();
      }
      
      public function _qp1405() : int
      {
         return this._pb123;
      }
      
      public function _sg1320(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         this.error = true;
         if(this._xj1181 != null && this._xj1181.length != 0 && !this._is829)
         {
            this._is829 = true;
            _loc3_ = this._xj1181.replace(".png",".jpg");
            this._vg116.load(new URLRequest(_loc3_));
            return;
         }
         this._jg1045 = 0;
         for each(_loc2_ in this.listeners)
         {
            _loc2_._mu405(this);
         }
      }
      
      public function _ut1300(param1:Event) : void
      {
         this._il104 = new BitmapData(this._pa1353.width,this._pa1353.height,false,16777215);
         this._il104.draw(this._pa1353);
         this._pa1353.unload();
         this._pa1353 = null;
         this._jg1045--;
         this._wk404();
      }
      
      public function _wk404() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Object = null;
         var _loc3_:_xr701 = null;
         var _loc4_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Matrix = null;
         if(this._jg1045 == 0)
         {
            _loc1_ = this._il104;
            this._il104 = this._yy958.clone();
            this._il104.copyChannel(_loc1_,_loc1_.rect,new Point(0,0),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
            _loc1_.dispose();
            if(this._rs618 && this._rs618.length > 0)
            {
               for each(_loc3_ in this._rs618)
               {
                  _loc4_ = _loc3_.getBitmap(true);
                  if(_loc4_ != null)
                  {
                     _loc5_ = this._yy958.width;
                     _loc6_ = this._yy958.height;
                     _loc7_ = _loc4_.width;
                     _loc8_ = _loc4_.height;
                     _loc9_ = new Matrix(_loc5_ * _loc3_.w / _loc7_,0,0,_loc6_ * _loc3_.h / _loc8_,_loc5_ * _loc3_.x,_loc6_ * _loc3_.y);
                     this._il104.draw(_loc4_,_loc9_);
                  }
               }
               this._yy958 = this._il104;
            }
            for each(_loc2_ in this.listeners)
            {
               _loc2_._hp908(this);
            }
            this.listeners = null;
         }
      }
      
      public function load() : void
      {
         var _loc2_:_xr701 = null;
         var _loc1_:String = this._fu1213.replace(".png",".jpg");
         this._vg116 = new URLLoader();
         this._vg116.addEventListener(Event.COMPLETE,this._ha1405,false,0,false);
         this._vg116.addEventListener(IOErrorEvent.IO_ERROR,this._sg1320,false,0,false);
         this._vg116.addEventListener(IOErrorEvent.NETWORK_ERROR,this._sg1320,false,0,false);
         this._vg116.dataFormat = URLLoaderDataFormat.BINARY;
         this._vg116.load(new URLRequest(_loc1_));
         this._kp263 = new URLLoader();
         this._kp263.addEventListener(Event.COMPLETE,this._ti836,false,0,false);
         this._kp263.addEventListener(IOErrorEvent.IO_ERROR,this._yd1254,false,0,false);
         this._kp263.addEventListener(IOErrorEvent.NETWORK_ERROR,this._yd1254,false,0,false);
         this._kp263.dataFormat = URLLoaderDataFormat.BINARY;
         this._kp263.load(new URLRequest(this._fu1213));
         for each(_loc2_ in this._rs618)
         {
            _loc2_._qg81(this);
            _loc2_.load();
         }
      }
      
      public function _hp786(param1:Event) : void
      {
         this._yy958 = new BitmapData(this._sv412.width,this._sv412.height,true,16777215);
         this._yy958.draw(this._sv412);
         this._sv412.unload();
         this._sv412 = null;
         this._jg1045--;
         this._wk404();
      }
      
      public function _qg81(param1:Object) : void
      {
         this.listeners.push(param1);
      }
      
      public function _yq1112() : int
      {
         return this._pb123 - this._jg1045;
      }
   }
}
