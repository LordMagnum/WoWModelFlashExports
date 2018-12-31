package
{
   public class _bs710
   {
       
      
      public var scale:Number = 0;
      
      public var dx:int = 0;
      
      public var dy:int = 0;
      
      public var name:String = "";
      
      public var _im1393:String = "";
      
      public function _bs710(param1:XML, param2:String)
      {
         super();
         if(param1.@key)
         {
            this.name = param1.@key;
         }
         if(param1.@file)
         {
            this._im1393 = param2 + param1.@file;
         }
         if(param1.@x)
         {
            this.dx = param1.@x;
         }
         if(param1.@y)
         {
            this.dy = param1.@y;
         }
         if(param1.@scale)
         {
            this.scale = Number(param1.@scale);
         }
      }
      
      public function _rl419() : String
      {
         return this._im1393 + ".jpg";
      }
   }
}
