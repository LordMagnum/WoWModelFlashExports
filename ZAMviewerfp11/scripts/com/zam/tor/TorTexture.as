package com.zam.tor
{
   import com.zam.FileLoadEvent;
   import com.zam.Viewer;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display3D.Context3DTextureFormat;
   import flash.display3D.textures.Texture;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class TorTexture
   {
       
      
      private var _slot:String;
      
      private var _url:String;
      
      private var _loaded:Boolean = false;
      
      private var _failed:Boolean = false;
      
      private var _viewer:Viewer;
      
      private var _mesh:TorMesh;
      
      private var _bitmap:Bitmap;
      
      private var _texture:Texture;
      
      public function TorTexture(param1:Viewer, param2:TorMesh, param3:String, param4:String)
      {
         var event:FileLoadEvent = null;
         var viewer:Viewer = param1;
         var mesh:TorMesh = param2;
         var slot:String = param3;
         var url:String = param4;
         super();
         this._viewer = viewer;
         this._mesh = mesh;
         this._slot = slot;
         this._url = url;
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded,false,0,true);
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress,false,0,true);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
         try
         {
            url = url + ".png";
            loader.load(new URLRequest(this._viewer.contentPath + url));
            event = new FileLoadEvent(FileLoadEvent.LOAD_START,this._url);
            this._viewer.dispatchEvent(event);
            return;
         }
         catch(ex:Error)
         {
            return;
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
         this._texture = this._viewer.context.createTexture(this._bitmap.width,this._bitmap.height,Context3DTextureFormat.BGRA,false);
         this._texture.uploadFromBitmapData(this._bitmap.bitmapData);
         this._loaded = true;
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this._url);
         this._viewer.dispatchEvent(_loc2_);
         this._mesh.onTextureLoaded(this._slot);
      }
      
      private function onLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,this._url,-1,-1,param1.text);
         this._viewer.dispatchEvent(_loc2_);
         this._failed = true;
         this._loaded = true;
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this._url,param1.bytesLoaded,param1.bytesTotal);
         this._viewer.dispatchEvent(_loc2_);
      }
   }
}
