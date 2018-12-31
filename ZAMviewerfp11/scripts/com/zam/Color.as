package com.zam
{
   import flash.geom.Vector3D;
   
   public class Color
   {
      
      public static const DEFAULT:Color = new Color(1,1,1,1);
       
      
      public var r:Number;
      
      public var g:Number;
      
      public var b:Number;
      
      public var a:Number;
      
      public function Color(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1)
      {
         super();
         this.r = param1;
         this.g = param2;
         this.b = param3;
         this.a = param4;
      }
      
      public function set rgb(param1:Vector3D) : void
      {
         this.r = param1.x;
         this.g = param1.y;
         this.b = param1.z;
      }
      
      public function reset(param1:Number = 1, param2:Number = 1, param3:Number = 1, param4:Number = 1) : void
      {
         this.r = param1;
         this.g = param2;
         this.b = param3;
         this.a = param4;
      }
   }
}
