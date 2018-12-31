package com.zam
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class ZamTexture
   {
       
      
      public var url:String;
      
      private var _loaded:Boolean;
      
      private var _failed:Boolean;
      
      private var _viewer:Viewer;
      
      private var _bitmap:Bitmap;
      
      private var _texture:Texture;
      
      public function ZamTexture(param1:Viewer, param2:String)
      {
         var loader:Loader = null;
         var event:FileLoadEvent = null;
         var viewer:Viewer = param1;
         var u:String = param2;
         super();
         this._viewer = viewer;
         this.url = u;
         if(this.url)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded,false,0,true);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress,false,0,true);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
            try
            {
               loader.load(new URLRequest(this._viewer.contentPath + this.url));
               event = new FileLoadEvent(FileLoadEvent.LOAD_START,this.url);
               this._viewer.dispatchEvent(event);
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
      
      public function get bitmap() : Bitmap
      {
         return this._bitmap;
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function refresh() : void
      {
         if(this._texture)
         {
            this._texture.dispose();
         }
         if(this._bitmap)
         {
            this._texture = this._viewer.context.createTexture(this._bitmap.width,this._bitmap.height,Context3DTextureFormat.BGRA,false);
            this._texture.uploadFromBitmapData(this._bitmap.bitmapData);
         }
      }
      
      private function onLoaded(param1:Event) : void
      {
         this._bitmap = param1.target.content;
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this.url);
         this._viewer.dispatchEvent(_loc2_);
         this._texture = this._viewer.context.createTexture(this._bitmap.width,this._bitmap.height,Context3DTextureFormat.BGRA,false);
         this._texture.uploadFromBitmapData(this._bitmap.bitmapData);
         this._loaded = true;
      }
      
      private function onLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,this.url,-1,-1,param1.text);
         this._viewer.dispatchEvent(_loc2_);
         this._failed = true;
         this._loaded = true;
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this.url,param1.bytesLoaded,param1.bytesTotal);
         this._viewer.dispatchEvent(_loc2_);
      }
   }
}
