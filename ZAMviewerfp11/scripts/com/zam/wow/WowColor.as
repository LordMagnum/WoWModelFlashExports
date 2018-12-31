package com.zam.wow
{
   import com.zam.Color;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowColor
   {
       
      
      public var rgb:Vector.<AnimatedVector3D>;
      
      public var alpha:Vector.<AnimatedUShort>;
      
      private var tmpVec:Vector3D;
      
      public function WowColor()
      {
         super();
         this.tmpVec = new Vector3D();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.rgb = WowUtil.readAnimatedVector3DSet(param1,false);
         this.alpha = WowUtil.readAnimatedUShortSet(param1);
      }
      
      public function rgbUsed(param1:int) : Boolean
      {
         if(this.rgb.length == 0)
         {
            return false;
         }
         if(param1 < this.rgb.length)
         {
            return this.rgb[param1]._used;
         }
         return this.rgb[0]._used;
      }
      
      public function alphaUsed(param1:int) : Boolean
      {
         if(this.alpha.length == 0)
         {
            return false;
         }
         if(param1 < this.alpha.length)
         {
            return this.alpha[param1]._used;
         }
         return this.alpha[0]._used;
      }
      
      public function used(param1:int) : Boolean
      {
         return this.rgbUsed(param1) || this.alphaUsed(param1);
      }
      
      public function getValue(param1:int, param2:int, param3:Color = null) : Color
      {
         if(!param3)
         {
            param3 = new Color();
         }
         if(this.rgbUsed(param1))
         {
            param3.rgb = AnimatedVector3D.getValueFrom(this.rgb,param1,param2,this.tmpVec);
         }
         if(this.alphaUsed(param1))
         {
            param3.a = AnimatedUShort.getValueFrom(this.alpha,param1,param2) / 32767;
         }
         return param3;
      }
   }
}
