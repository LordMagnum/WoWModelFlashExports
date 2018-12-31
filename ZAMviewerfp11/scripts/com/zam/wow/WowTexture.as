package com.zam.wow
{
   import com.zam.FileLoadEvent;
   import com.zam.Viewer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class WowTexture
   {
      
      public static const NORMAL:int = 1;
      
      public static const SPECIAL:int = 2;
      
      public static const BAKED:int = 3;
      
      public static const ARMOR:int = 4;
       
      
      public var _url:String;
      
      public var _fakeAlpha:Boolean;
      
      private var _alphaUrl:String;
      
      private var _loaded:Boolean;
      
      private var _failed:Boolean;
      
      private var _viewer:Viewer;
      
      private var _mesh:WowModel;
      
      public var _rgbBitmap:Bitmap;
      
      public var _alphaBitmap:Bitmap;
      
      private var _compositeBitmap:Bitmap;
      
      private var _texture:Texture;
      
      private var _index:int;
      
      private var _type:int;
      
      public function WowTexture(param1:WowModel, param2:int, param3:String, param4:int = 1)
      {
         var rgbLoader:Loader = null;
         var alphaLoader:Loader = null;
         var event:FileLoadEvent = null;
         var mesh:WowModel = param1;
         var index:int = param2;
         var url:String = param3;
         var type:int = param4;
         super();
         this._mesh = mesh;
         this._index = index;
         this._type = type;
         this._url = url;
         if(url)
         {
            this._alphaUrl = url.replace(".png",".alpha.png");
            rgbLoader = new Loader();
            rgbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onRgbLoaded,false,0,true);
            rgbLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress,false,0,true);
            rgbLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
            alphaLoader = new Loader();
            alphaLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAlphaLoaded,false,0,true);
            alphaLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onAlphaLoadProgress,false,0,true);
            alphaLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onAlphaLoadError,false,0,true);
            try
            {
               rgbLoader.load(new URLRequest(this._mesh.viewer.contentPath + "textures2/" + this._url));
               alphaLoader.load(new URLRequest(this._mesh.viewer.contentPath + "textures2/" + this._alphaUrl));
               event = new FileLoadEvent(FileLoadEvent.LOAD_START,this._url);
               this._mesh.viewer.dispatchEvent(event);
               return;
            }
            catch(ex:Error)
            {
               return;
            }
         }
      }
      
      public function get loaded() : Boolean
      {
         return this._loaded;
      }
      
      public function get failed() : Boolean
      {
         return this._failed;
      }
      
      public function get good() : Boolean
      {
         return this._loaded && !this._failed;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function get composite() : Bitmap
      {
         if(!this._compositeBitmap)
         {
            this.generateComposite();
         }
         return this._compositeBitmap;
      }
      
      public function refresh() : void
      {
         this.onLoaded(false);
      }
      
      public function copyFromTexture(param1:WowTexture) : void
      {
         this._rgbBitmap = new Bitmap(param1._rgbBitmap.bitmapData.clone());
         this._alphaBitmap = new Bitmap(param1._alphaBitmap.bitmapData.clone());
      }
      
      public function drawTexture(param1:WowTexture, param2:int) : void
      {
         var _loc3_:Array = null;
         if(this._rgbBitmap.width == this._rgbBitmap.height)
         {
            _loc3_ = WowModel.TextureRegions[param2];
         }
         else
         {
            _loc3_ = WowModel.NewTextureRegions[param2];
         }
         var _loc4_:Matrix = new Matrix();
         _loc4_.scale(this._rgbBitmap.width / (param1._rgbBitmap.width / _loc3_[2]),this._rgbBitmap.height / (param1._rgbBitmap.height / _loc3_[3]));
         _loc4_.translate(this._rgbBitmap.width * _loc3_[0],this._rgbBitmap.height * _loc3_[1]);
         this._rgbBitmap.bitmapData.draw(param1.composite.bitmapData,_loc4_,null,BlendMode.NORMAL);
      }
      
      public function uploadTexture() : void
      {
         this.onLoaded();
      }
      
      private function generateComposite() : Bitmap
      {
         var _loc1_:int = this._rgbBitmap.width;
         var _loc2_:int = this._rgbBitmap.height;
         var _loc3_:BitmapData = new BitmapData(_loc1_,_loc2_,true,4294967295);
         var _loc4_:Rectangle = new Rectangle(0,0,_loc1_,_loc2_);
         var _loc5_:Point = new Point(0,0);
         _loc3_.copyPixels(this._rgbBitmap.bitmapData,_loc4_,_loc5_);
         _loc3_.copyChannel(this._alphaBitmap.bitmapData,_loc4_,_loc5_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         this._compositeBitmap = new Bitmap(_loc3_);
         return this._compositeBitmap;
      }
      
      private function createBlankAlpha() : Bitmap
      {
         this._fakeAlpha = true;
         var _loc1_:Bitmap = new Bitmap(new BitmapData(this._rgbBitmap.width,this._rgbBitmap.height,false,4294967295));
         return _loc1_;
      }
      
      private function onRgbLoaded(param1:Event) : void
      {
         this._rgbBitmap = param1.target.content;
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this._url);
         this._mesh.viewer.dispatchEvent(_loc2_);
         if(this._failed)
         {
            this._failed = false;
            this._alphaBitmap = this.createBlankAlpha();
         }
         if(this._alphaBitmap != null)
         {
            this.onLoaded();
         }
      }
      
      private function onAlphaLoaded(param1:Event) : void
      {
         this._alphaBitmap = param1.target.content;
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this._alphaUrl);
         this._mesh.viewer.dispatchEvent(_loc2_);
         if(this._rgbBitmap != null)
         {
            this.onLoaded();
         }
      }
      
      private function onLoaded(param1:Boolean = true) : void
      {
         var _loc2_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this._texture)
         {
            this._texture.dispose();
            this._texture = null;
         }
         var _loc3_:BitmapData = this._rgbBitmap.bitmapData;
         var _loc4_:BitmapData = this._alphaBitmap.bitmapData;
         var _loc7_:int = _loc3_.width;
         var _loc8_:int = _loc3_.height;
         var _loc9_:ByteArray = new ByteArray();
         _loc9_.length = _loc7_ * _loc8_ * 4;
         _loc9_.endian = Endian.LITTLE_ENDIAN;
         _loc3_.lock();
         _loc4_.lock();
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc2_ = _loc3_.getPixel(_loc5_,_loc6_);
               _loc2_ = _loc2_ | _loc4_.getPixel(_loc5_,_loc6_) << 24;
               _loc9_.writeUnsignedInt(_loc2_);
               _loc5_++;
            }
            _loc6_++;
         }
         _loc3_.unlock();
         _loc4_.unlock();
         this._texture = this._mesh.context.createTexture(this._rgbBitmap.width,this._rgbBitmap.height,Context3DTextureFormat.BGRA,false);
         this._texture.uploadFromByteArray(_loc9_,0);
         this._loaded = true;
         if(param1)
         {
            this._mesh.onTextureLoaded(this,this._type,this._index);
         }
      }
      
      private function onAlphaLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this._alphaUrl);
         this._mesh.viewer.dispatchEvent(_loc2_);
         if(this._rgbBitmap != null)
         {
            this._alphaBitmap = this.createBlankAlpha();
            this.onLoaded();
         }
      }
      
      private function onLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,this._url,-1,-1,param1.text);
         this._mesh.viewer.dispatchEvent(_loc2_);
         this._failed = true;
         this._loaded = true;
      }
      
      private function onAlphaLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this._alphaUrl,param1.bytesLoaded,param1.bytesTotal);
         this._mesh.viewer.dispatchEvent(_loc2_);
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this._url,param1.bytesLoaded,param1.bytesTotal);
         this._mesh.viewer.dispatchEvent(_loc2_);
      }
   }
}

class Pixel#17
{
    
   
   protected var r:Number;
   
   protected var g:Number;
   
   protected var b:Number;
   
   protected var a:Number;
   
   function Pixel#17(param1:uint = 4.294967295E9)
   {
      super();
      this.argb = param1;
   }
   
   public function get argb() : uint
   {
      return this.b | this.g << 8 | this.r << 16 | this.a << 24;
   }
   
   public function get rgb() : uint
   {
      return uint(this.b * 255) | uint(this.g * 255) << 8 | uint(this.r * 255) << 16 | 255 << 24;
   }
   
   public function get alpha() : uint
   {
      var _loc1_:uint = int(this.a * 255);
      return _loc1_ | _loc1_ << 8 | _loc1_ << 16 | _loc1_ << 24;
   }
   
   public function set argb(param1:uint) : void
   {
      this.a = (param1 >> 24 & 255) / 255;
      this.r = (param1 >> 16 & 255) / 255;
      this.g = (param1 >> 8 & 255) / 255;
      this.b = (param1 & 255) / 255;
   }
   
   public function set rgb(param1:uint) : void
   {
      this.r = (param1 >> 16 & 255) / 255;
      this.g = (param1 >> 8 & 255) / 255;
      this.b = (param1 & 255) / 255;
   }
   
   public function set alpha(param1:uint) : void
   {
      this.a = (param1 >> 8 & 255) / 255;
   }
   
   public function clamp(param1:Number) : Number
   {
      return param1 > 1?Number(1):Number(param1);
   }
   
   public function blend(param1:Pixel#17, param2:Pixel#17) : Pixel#17
   {
      param2.r = this.clamp(this.r * this.a + param1.r * param1.a * (1 - this.a));
      param2.g = this.clamp(this.g * this.a + param1.g * param1.a * (1 - this.a));
      param2.b = this.clamp(this.b * this.a * param1.b * param1.a * (1 - this.a));
      param2.a = this.clamp(this.a + param1.a * (1 - this.a));
      return param2;
   }
}
