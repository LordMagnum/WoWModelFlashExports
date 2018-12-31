package away3d.loaders.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   
   public class TextureLoadQueue extends EventDispatcher
   {
       
      
      private var _currentItemIndex:int;
      
      private var _queue:Array;
      
      public function TextureLoadQueue()
      {
         super();
         this._queue = new Array();
      }
      
      public function get currentURLRequest() : URLRequest
      {
         return (this._queue[this.currentItemIndex] as LoaderAndRequest).request;
      }
      
      private function calcProgress() : Number
      {
         var _loc1_:Number = this.currentItemIndex / this.numItems;
         var _loc2_:Number = this.calcCurrentLoaderAmountLoaded() / this.numItems;
         return _loc1_ = _loc2_;
      }
      
      public function get currentItemIndex() : int
      {
         return this._currentItemIndex;
      }
      
      public function start() : void
      {
         this._currentItemIndex = 0;
         this.loadNext();
      }
      
      private function onItemComplete(param1:Event) : void
      {
         this.cleanUpOldItem(this.currentLoader);
         this._currentItemIndex++;
         this.loadNext();
      }
      
      public function get currentLoader() : TextureLoader
      {
         return (this._queue[this.currentItemIndex] as LoaderAndRequest).loader;
      }
      
      private function redispatchEvent(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      public function get percentLoaded() : Number
      {
         return this.progress * 100;
      }
      
      private function calcCurrentLoaderAmountLoaded() : Number
      {
         if(this.currentLoader.contentLoaderInfo.bytesLoaded > 0)
         {
            return this.currentLoader.contentLoaderInfo.bytesLoaded / this.currentLoader.contentLoaderInfo.bytesTotal;
         }
         return 0;
      }
      
      private function cleanUpOldItem(param1:TextureLoader) : void
      {
         this.currentLoader.removeEventListener(Event.COMPLETE,this.onItemComplete,false);
         this.currentLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.redispatchEvent,false);
         this.currentLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.redispatchEvent,false);
         this.currentLoader.removeEventListener(ProgressEvent.PROGRESS,this.redispatchEvent,false);
         this.currentLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.redispatchEvent,false);
      }
      
      public function get images() : Array
      {
         var _loc2_:LoaderAndRequest = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._queue)
         {
            _loc1_.push(_loc2_.loader);
         }
         return _loc1_;
      }
      
      private function loadNext() : void
      {
         var _loc1_:ProgressEvent = null;
         if(this._currentItemIndex >= this.numItems)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            _loc1_ = new ProgressEvent(ProgressEvent.PROGRESS);
            _loc1_.bytesTotal = 100;
            _loc1_.bytesLoaded = this.percentLoaded;
            dispatchEvent(_loc1_);
            if(!(this.currentLoader.contentLoaderInfo.bytesLoaded > 0 && this.currentLoader.contentLoaderInfo.bytesLoaded == this.currentLoader.contentLoaderInfo.bytesTotal))
            {
               this.currentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onItemComplete,false,int.MIN_VALUE,true);
               this.currentLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.redispatchEvent,false,0,true);
               this.currentLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.redispatchEvent,false,0,true);
               this.currentLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.redispatchEvent,false,0,true);
               this.currentLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.redispatchEvent,false,0,true);
               this.currentLoader.load(this.currentURLRequest);
            }
         }
      }
      
      public function get numItems() : int
      {
         return this._queue.length;
      }
      
      public function addItem(param1:TextureLoader, param2:URLRequest) : void
      {
         var _loc3_:LoaderAndRequest = null;
         for each(_loc3_ in this._queue)
         {
            if(_loc3_.request.url == param2.url)
            {
               return;
            }
         }
         this._queue.push(new LoaderAndRequest(param1,param2));
      }
      
      public function get progress() : Number
      {
         return this.calcProgress();
      }
   }
}

import away3d.loaders.utils.TextureLoader;
import flash.net.URLRequest;

class LoaderAndRequest
{
    
   
   public var loader:TextureLoader;
   
   public var request:URLRequest;
   
   function LoaderAndRequest(param1:TextureLoader, param2:URLRequest)
   {
      super();
      this.loader = param1;
      this.request = param2;
   }
}
