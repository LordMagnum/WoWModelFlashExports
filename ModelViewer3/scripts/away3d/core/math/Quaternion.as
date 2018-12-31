package away3d.core.math
{
   public final class Quaternion
   {
       
      
      private var fSinYaw:Number;
      
      private var fCosYaw:Number;
      
      private var z2:Number;
      
      public var z:Number;
      
      private var fCosPitch:Number;
      
      private var w1:Number;
      
      private var w2:Number;
      
      private var cos_a:Number;
      
      private var fSinRoll:Number;
      
      private var x1:Number;
      
      private var x2:Number;
      
      private var sin_a:Number;
      
      private var fCosPitchCosYaw:Number;
      
      private var fSinPitch:Number;
      
      private var y1:Number;
      
      private var y2:Number;
      
      private var fCosRoll:Number;
      
      public var w:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      private var fSinPitchSinYaw:Number;
      
      private var z1:Number;
      
      public function Quaternion()
      {
         super();
      }
      
      public function normalize(param1:Number = 1) : void
      {
         var _loc2_:Number = this.magnitude * param1;
         this.x = this.x / _loc2_;
         this.y = this.y / _loc2_;
         this.z = this.z / _loc2_;
         this.w = this.w / _loc2_;
      }
      
      public function axis2quaternion(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.sin_a = Math.sin(param4 / 2);
         this.cos_a = Math.cos(param4 / 2);
         this.x = param1 * this.sin_a;
         this.y = param2 * this.sin_a;
         this.z = param3 * this.sin_a;
         this.w = this.cos_a;
         this.normalize();
      }
      
      public function get magnitude() : Number
      {
         return Math.sqrt(this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z);
      }
      
      public function multiply(param1:Quaternion, param2:Quaternion) : void
      {
         this.w1 = param1.w;
         this.x1 = param1.x;
         this.y1 = param1.y;
         this.z1 = param1.z;
         this.w2 = param2.w;
         this.x2 = param2.x;
         this.y2 = param2.y;
         this.z2 = param2.z;
         this.w = this.w1 * this.w2 - this.x1 * this.x2 - this.y1 * this.y2 - this.z1 * this.z2;
         this.x = this.w1 * this.x2 + this.x1 * this.w2 + this.y1 * this.z2 - this.z1 * this.y2;
         this.y = this.w1 * this.y2 + this.y1 * this.w2 + this.z1 * this.x2 - this.x1 * this.z2;
         this.z = this.w1 * this.z2 + this.z1 * this.w2 + this.x1 * this.y2 - this.y1 * this.x2;
      }
      
      public function euler2quaternion(param1:Number, param2:Number, param3:Number) : void
      {
         this.fSinPitch = Math.sin(param1 * 0.5);
         this.fCosPitch = Math.cos(param1 * 0.5);
         this.fSinYaw = Math.sin(param2 * 0.5);
         this.fCosYaw = Math.cos(param2 * 0.5);
         this.fSinRoll = Math.sin(param3 * 0.5);
         this.fCosRoll = Math.cos(param3 * 0.5);
         this.fCosPitchCosYaw = this.fCosPitch * this.fCosYaw;
         this.fSinPitchSinYaw = this.fSinPitch * this.fSinYaw;
         this.x = this.fSinRoll * this.fCosPitchCosYaw - this.fCosRoll * this.fSinPitchSinYaw;
         this.y = this.fCosRoll * this.fSinPitch * this.fCosYaw + this.fSinRoll * this.fCosPitch * this.fSinYaw;
         this.z = this.fCosRoll * this.fCosPitch * this.fSinYaw - this.fSinRoll * this.fSinPitch * this.fCosYaw;
         this.w = this.fCosRoll * this.fCosPitchCosYaw + this.fSinRoll * this.fSinPitchSinYaw;
      }
      
      public function toString() : String
      {
         return "{x:" + this.x + " y:" + this.y + " z:" + this.z + " w:" + this.w + "}";
      }
   }
}
