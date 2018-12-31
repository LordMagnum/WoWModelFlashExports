package org.papervision3d.materials
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import org.papervision3d.core.log.PaperLogger;
   import org.papervision3d.core.proto.MaterialObject3D;
   import org.papervision3d.core.render.command.RenderTriangle;
   import org.papervision3d.core.render.data.RenderSessionData;
   import org.papervision3d.core.render.draw.ITriangleDrawer;
   import org.papervision3d.events.FileLoadEvent;
   
   public class BitmapFileMaterial extends BitmapMaterial implements ITriangleDrawer
   {
      
      public static var LOADING_COLOR:int = MaterialObject3D.DEFAULT_COLOR;
      
      public static var callback:Function;
      
      public static var loadingBitmap:BitmapData = new BitmapData(1,1,false,0);
      
      protected static var _loaderUrls:Dictionary = new Dictionary(true);
      
      protected static var _loadingIdle:Boolean = true;
      
      public static var ERROR_COLOR:int = MaterialObject3D.DEBUG_COLOR;
      
      protected static var _subscribedMaterials:Object = new Object();
      
      protected static var _waitingBitmaps:Array = new Array();
      
      protected static var _bitmapMaterials:Dictionary = new Dictionary(true);
       
      
      public var loaded:Boolean;
      
      protected var errorLoading:Boolean = false;
      
      protected var bitmapLoader:Loader;
      
      public var url:String = "";
      
      public var checkPolicyFile:Boolean = false;
      
      public function BitmapFileMaterial(param1:String = "", param2:Boolean = false)
      {
         super(null,param2);
         this.url = param1;
         this.loaded = false;
         this.fillAlpha = 1;
         this.fillColor = LOADING_COLOR;
         if(param1.length > 0)
         {
            this.texture = param1;
         }
      }
      
      protected function loadBitmapProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this.url,param1.bytesLoaded,param1.bytesTotal);
         dispatchEvent(_loc2_);
      }
      
      override public function destroy() : void
      {
         if(this.bitmapLoader)
         {
            this.bitmapLoader.unload();
         }
         super.destroy();
      }
      
      protected function setupAsyncLoadCompleteCallback() : void
      {
         var _loc1_:Timer = new Timer(1,1);
         _loc1_.addEventListener(TimerEvent.TIMER_COMPLETE,this.dispatchAsyncLoadCompleteEvent);
         _loc1_.start();
      }
      
      protected function removeLoaderListeners() : void
      {
         this.bitmapLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loadBitmapProgressHandler);
         this.bitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadBitmapCompleteHandler);
         this.bitmapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadBitmapErrorHandler);
      }
      
      protected function getBitmapForFilename(param1:String) : BitmapData
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFileMaterial = null;
         for(_loc2_ in _bitmapMaterials)
         {
            _loc3_ = _loc2_ as BitmapFileMaterial;
            if(_loc3_.url == param1)
            {
               return _loc3_.bitmap;
            }
         }
         return null;
      }
      
      public function get bitmapMaterials() : Dictionary
      {
         return _bitmapMaterials;
      }
      
      protected function loadNextBitmap() : void
      {
         var loaderContext:LoaderContext = null;
         var file:String = _waitingBitmaps[0];
         var request:URLRequest = new URLRequest(file);
         this.bitmapLoader = new Loader();
         this.bitmapLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loadBitmapProgressHandler);
         this.bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadBitmapCompleteHandler);
         this.bitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadBitmapErrorHandler);
         try
         {
            loaderContext = new LoaderContext();
            loaderContext.checkPolicyFile = this.checkPolicyFile;
            this.bitmapLoader.load(request,loaderContext);
            _loaderUrls[this.bitmapLoader] = file;
            _loadingIdle = false;
            PaperLogger.info("BitmapFileMaterial: Loading bitmap from " + file);
            return;
         }
         catch(error:Error)
         {
            _waitingBitmaps.shift();
            _loadingIdle = true;
            PaperLogger.info("[ERROR] BitmapFileMaterial: Unable to load file " + error.message);
            return;
         }
      }
      
      protected function dispatchAsyncLoadCompleteEvent(param1:TimerEvent) : void
      {
         this.loadComplete();
      }
      
      protected function createBitmapFromURL(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         if(param1 == "")
         {
            return null;
         }
         _loc2_ = this.getBitmapForFilename(param1);
         if(_loc2_)
         {
            bitmap = super.createBitmap(_loc2_);
            this.setupAsyncLoadCompleteCallback();
            return _loc2_;
         }
         this.queueBitmap(param1);
         return loadingBitmap;
      }
      
      override public function get texture() : Object
      {
         return this._texture;
      }
      
      protected function loadBitmapCompleteHandler(param1:Event) : void
      {
         var _loc5_:BitmapFileMaterial = null;
         var _loc2_:Bitmap = Bitmap(this.bitmapLoader.content);
         this.removeLoaderListeners();
         var _loc3_:String = _loaderUrls[this.bitmapLoader];
         var _loc4_:BitmapData = super.createBitmap(_loc2_.bitmapData);
         for each(_loc5_ in _subscribedMaterials[_loc3_])
         {
            _loc5_.bitmap = _loc4_;
            _loc5_.maxU = this.maxU;
            _loc5_.maxV = this.maxV;
            _loc5_.resetMapping();
            _loc5_.loadComplete();
         }
         _subscribedMaterials[_loc3_] = null;
         _bitmapMaterials[this] = true;
         _waitingBitmaps.shift();
         if(_waitingBitmaps.length > 0)
         {
            this.loadNextBitmap();
         }
         else
         {
            _loadingIdle = true;
            if(Boolean(callback))
            {
               callback();
            }
         }
      }
      
      private function queueBitmap(param1:String) : void
      {
         if(!_subscribedMaterials[param1])
         {
            _waitingBitmaps.push(param1);
            _subscribedMaterials[param1] = new Array();
         }
         _subscribedMaterials[param1].push(this);
         if(_loadingIdle)
         {
            this.loadNextBitmap();
         }
      }
      
      override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
      {
         if(bitmap == null || this.errorLoading)
         {
            if(this.errorLoading)
            {
               param2.lineStyle(lineThickness,lineColor,lineAlpha);
            }
            param2.beginFill(fillColor,fillAlpha);
            param2.moveTo(param1.v0.x,param1.v0.y);
            param2.lineTo(param1.v1.x,param1.v1.y);
            param2.lineTo(param1.v2.x,param1.v2.y);
            param2.lineTo(param1.v0.x,param1.v0.y);
            param2.endFill();
            if(this.errorLoading)
            {
               param2.lineStyle();
            }
            param3.renderStatistics.triangles++;
         }
         super.drawTriangle(param1,param2,param3);
      }
      
      public function get subscribedMaterials() : Object
      {
         return _subscribedMaterials;
      }
      
      protected function loadBitmapErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:String = String(_waitingBitmaps.shift());
         _subscribedMaterials[_loc2_] = null;
         this.errorLoading = true;
         this.lineColor = ERROR_COLOR;
         this.lineAlpha = 1;
         this.lineThickness = 1;
         PaperLogger.error("BitmapFileMaterial: Unable to load file " + _loc2_);
         this.removeLoaderListeners();
         if(_waitingBitmaps.length > 0)
         {
            this.loadNextBitmap();
         }
         else
         {
            _loadingIdle = true;
            if(Boolean(callback))
            {
               callback();
            }
         }
         var _loc3_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,_loc2_,-1,-1,param1.text);
         dispatchEvent(_loc3_);
      }
      
      override public function set texture(param1:Object) : void
      {
         if(param1 is String == false)
         {
            PaperLogger.error("BitmapFileMaterial.texture requires a String for the texture");
            return;
         }
         bitmap = this.createBitmapFromURL(String(param1));
         _texture = param1;
      }
      
      protected function loadComplete() : void
      {
         this.fillAlpha = 0;
         this.fillColor = 0;
         this.loaded = true;
         var _loc1_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this.url);
         this.dispatchEvent(_loc1_);
      }
   }
}
