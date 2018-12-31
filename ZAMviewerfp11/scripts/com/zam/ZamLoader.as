package com.zam
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ZamLoader extends URLLoader
   {
       
      
      protected var _request:URLRequest;
      
      public function ZamLoader(param1:URLRequest = null)
      {
         this._request = param1;
         super(param1);
         addEventListener(Event.COMPLETE,this.loadComplete);
         addEventListener(ProgressEvent.PROGRESS,this.loadProgress);
         addEventListener(IOErrorEvent.IO_ERROR,this.loadIOError);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadSecurityError);
      }
      
      public function get request() : URLRequest
      {
         return this._request;
      }
      
      override public function load(param1:URLRequest) : void
      {
         this._request = param1;
         super.load(param1);
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_START,param1.url);
         dispatchEvent(_loc2_);
      }
      
      private function loadComplete(param1:Event) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE,this.request.url);
         dispatchEvent(_loc2_);
      }
      
      private function loadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,this.request.url,param1.bytesLoaded,param1.bytesTotal);
         dispatchEvent(_loc2_);
      }
      
      private function loadIOError(param1:IOErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,this.request.url,-1,-1,param1.text);
         dispatchEvent(_loc2_);
      }
      
      private function loadSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_SECURITY_ERROR,this.request.url,-1,-1,param1.text);
         dispatchEvent(_loc2_);
      }
   }
}
