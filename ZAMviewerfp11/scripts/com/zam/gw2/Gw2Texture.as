package com.zam.gw2
{
   import com.zam.FileLoadEvent;
   import com.zam.Viewer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Gw2Texture
   {
      
      public static const DIFFUSE:int = 1;
      
      public static const NORMAL:int = 2;
      
      public static const LIGHTMAP:int = 3;
       
      
      public var _url:String;
      
      private var _alphaUrl:String;
      
      private var _loaded:Boolean;
      
      private var _failed:Boolean;
      
      private var _viewer:Viewer;
      
      private var _mesh:Gw2Model;
      
      private var _rgbBitmap:Bitmap;
      
      private var _alphaBitmap:Bitmap;
      
      private var _rgbaData:ByteArray;
      
      private var _width:uint;
      
      private var _height:uint;
      
      private var _texture:Texture;
      
      private var _index:int;
      
      private var _type:int;
      
      public function Gw2Texture(param1:Gw2Model, param2:int, param3:String, param4:int = 1)
      {
         var rgbLoader:Loader = null;
         var alphaLoader:Loader = null;
         var event:FileLoadEvent = null;
         var mesh:Gw2Model = param1;
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
            this._alphaUrl = url.replace(".png",".a.png");
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
               rgbLoader.load(new URLRequest(this._mesh.viewer.contentPath + "textures/" + this._url));
               alphaLoader.load(new URLRequest(this._mesh.viewer.contentPath + "textures/" + this._alphaUrl));
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
      
      public function refresh() : void
      {
         this.uploadTexture();
      }
      
      public function uploadTexture() : void
      {
         if(!this.good)
         {
            return;
         }
         if(this._texture)
         {
            this._texture.dispose();
         }
         this._texture = this._mesh.context.createTexture(this._width,this._height,Context3DTextureFormat.BGRA,false);
         this._texture.uploadFromByteArray(this._rgbaData,0);
      }
      
      private function createBlankAlpha() : Bitmap
      {
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
         this._width = _loc3_.width;
         this._height = _loc3_.height;
         this._rgbaData = new ByteArray();
         this._rgbaData.length = this._width * this._height * 4;
         this._rgbaData.endian = Endian.LITTLE_ENDIAN;
         _loc3_.lock();
         _loc4_.lock();
         _loc6_ = 0;
         while(_loc6_ < this._height)
         {
            _loc5_ = 0;
            while(_loc5_ < this._width)
            {
               _loc2_ = _loc3_.getPixel(_loc5_,_loc6_);
               _loc2_ = _loc2_ | _loc4_.getPixel(_loc5_,_loc6_) << 24;
               this._rgbaData.writeUnsignedInt(_loc2_);
               _loc5_++;
            }
            _loc6_++;
         }
         _loc3_.unlock();
         _loc4_.unlock();
         _loc3_.dispose();
         _loc4_.dispose();
         this._rgbBitmap = null;
         this._alphaBitmap = null;
         this._loaded = true;
         this.uploadTexture();
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

class Pixel#16
{
    
   
   protected var r:Number;
   
   protected var g:Number;
   
   protected var b:Number;
   
   protected var a:Number;
   
   function Pixel#16(param1:uint = 4.294967295E9)
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
   
   public function blend(param1:Pixel#16, param2:Pixel#16) : Pixel#16
   {
      param2.r = this.clamp(this.r * this.a + param1.r * param1.a * (1 - this.a));
      param2.g = this.clamp(this.g * this.a + param1.g * param1.a * (1 - this.a));
      param2.b = this.clamp(this.b * this.a * param1.b * param1.a * (1 - this.a));
      param2.a = this.clamp(this.a + param1.a * (1 - this.a));
      return param2;
   }
}
