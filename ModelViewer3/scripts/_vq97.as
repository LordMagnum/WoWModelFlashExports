package
{
   public class _vq97
   {
       
      
      public var _un503:Number = 0.0;
      
      public var subId:int = -1;
      
      public var name:String = "";
      
      public var _vc35:Boolean = false;
      
      public var _bu1230:Number = 0.0;
      
      public var zoom:Number = 0.0;
      
      public var timer:int = 0;
      
      public var id:int = -1;
      
      public var _iy29:String = "";
      
      public var rotation:Number = 0.0;
      
      public function _vq97(param1:XML)
      {
         super();
         this.name = param1.@key;
         this.id = param1.@id;
         this.subId = param1.@subId;
         this._iy29 = param1.@weapons;
         this._vc35 = param1.@§default§ == 1;
         if(this._vc35)
         {
            this.rotation = param1.@rot;
            this.zoom = param1.@zoom;
            this.timer = param1.@timer;
            this._un503 = param1.@panx;
            this._bu1230 = param1.@pany;
         }
      }
   }
}
