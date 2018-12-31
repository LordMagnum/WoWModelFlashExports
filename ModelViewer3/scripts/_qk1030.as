package
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class _qk1030
   {
       
      
      public var _id373:String;
      
      public var loader:URLLoader;
      
      public var id:int;
      
      public var listeners:Array;
      
      public function _qk1030(param1:int, param2:String)
      {
         this.listeners = [];
         super();
         this.id = param1;
         this._id373 = param2;
      }
      
      public function _mf745(param1:Event) : void
      {
      }
      
      public function loadBytes(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc2_:ByteArray = param1.target.data;
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         for each(_loc3_ in this.listeners)
         {
            _loc3_.loadBytes(this.id,_loc2_);
         }
      }
      
      public function load() : void
      {
         this.loader = new URLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.COMPLETE,this.loadBytes);
         this.loader.load(new URLRequest(this._id373));
      }
      
      public function _qg81(param1:Object) : void
      {
         this.listeners.push(param1);
      }
   }
}
