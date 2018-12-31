package away3d.core.math
{
   public final class Number3D
   {
      
      public static var BACKWARD:Number3D = new Number3D(0,0,-1);
      
      public static var FORWARD:Number3D = new Number3D(0,0,1);
      
      public static var LEFT:Number3D = new Number3D(-1,0,0);
      
      public static var DOWN:Number3D = new Number3D(0,-1,0);
      
      public static var UP:Number3D = new Number3D(0,1,0);
      
      public static var RIGHT:Number3D = new Number3D(1,0,0);
       
      
      private var mod:Number;
      
      private var num:Number3D;
      
      private const MathPI:Number = 3.141592653589793;
      
      private var dist:Number;
      
      private const toDEGREES:Number = 57.29577951308232;
      
      private var vy:Number;
      
      private var vz:Number;
      
      private var nx:Number;
      
      private var ny:Number;
      
      private var vx:Number;
      
      private var nz:Number;
      
      private var m1:MatrixAway3D;
      
      private var m2:MatrixAway3D;
      
      public var y:Number;
      
      public var z:Number;
      
      public var x:Number;
      
      public function Number3D(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Boolean = false)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
         if(param4)
         {
            this.normalize();
         }
      }
      
      public static function getInterpolated(param1:Number3D, param2:Number3D, param3:Number) : Number3D
      {
         var _loc4_:Number3D = new Number3D();
         _loc4_.sub(param1,param2);
         _loc4_.scale(_loc4_,param3);
         _loc4_.add(_loc4_,param2);
         return _loc4_;
      }
      
      public function interpolate(param1:Number3D, param2:Number) : void
      {
         var _loc3_:Number3D = new Number3D();
         _loc3_.sub(param1,this);
         _loc3_.scale(_loc3_,param2);
         this.add(this,_loc3_);
      }
      
      public function quaternion2euler(param1:Quaternion) : void
      {
         var _loc2_:Number = param1.x * param1.y + param1.z * param1.w;
         if(_loc2_ > 0.499)
         {
            this.x = 2 * Math.atan2(param1.x,param1.w);
            this.y = Math.PI / 2;
            this.z = 0;
            return;
         }
         if(_loc2_ < -0.499)
         {
            this.x = -2 * Math.atan2(param1.x,param1.w);
            this.y = -Math.PI / 2;
            this.z = 0;
            return;
         }
         var _loc3_:Number = param1.x * param1.x;
         var _loc4_:Number = param1.y * param1.y;
         var _loc5_:Number = param1.z * param1.z;
         this.x = Math.atan2(2 * param1.y * param1.w - 2 * param1.x * param1.z,1 - 2 * _loc4_ - 2 * _loc5_);
         this.y = Math.asin(2 * _loc2_);
         this.z = Math.atan2(2 * param1.x * param1.w - 2 * param1.y * param1.z,1 - 2 * _loc3_ - 2 * _loc5_);
      }
      
      public function normalize(param1:Number = 1) : void
      {
         this.mod = this.modulo / param1;
         if(this.mod != 0 && this.mod != 1)
         {
            this.x = this.x / this.mod;
            this.y = this.y / this.mod;
            this.z = this.z / this.mod;
         }
      }
      
      public function getAngle(param1:Number3D = null) : Number
      {
         if(param1 == null)
         {
            param1 = new Number3D();
         }
         return Math.acos(this.dot(param1) / (this.modulo * param1.modulo));
      }
      
      public function closestPointOnPlane(param1:Number3D, param2:Number3D, param3:Number3D) : Number3D
      {
         if(!this.num)
         {
            this.num = new Number3D();
         }
         this.num.sub(param1,param2);
         this.dist = param3.dot(this.num);
         this.num.scale(param3,this.dist);
         this.num.sub(param1,this.num);
         return this.num;
      }
      
      public function add(param1:Number3D, param2:Number3D) : void
      {
         this.x = param1.x + param2.x;
         this.y = param1.y + param2.y;
         this.z = param1.z + param2.z;
      }
      
      public function equals(param1:Number3D) : Boolean
      {
         return param1.x == this.x && param1.y == this.y && param1.z == this.z;
      }
      
      public function sub(param1:Number3D, param2:Number3D) : void
      {
         this.x = param1.x - param2.x;
         this.y = param1.y - param2.y;
         this.z = param1.z - param2.z;
      }
      
      public function cross(param1:Number3D, param2:Number3D) : void
      {
         if(this == param1 || this == param2)
         {
            throw new Error("resultant cross product cannot be the same instance as an input");
         }
         this.x = param2.y * param1.z - param2.z * param1.y;
         this.y = param2.z * param1.x - param2.x * param1.z;
         this.z = param2.x * param1.y - param2.y * param1.x;
      }
      
      public function dot(param1:Number3D) : Number
      {
         return this.x * param1.x + this.y * param1.y + this.z * param1.z;
      }
      
      public function rotate(param1:Number3D, param2:MatrixAway3D) : void
      {
         this.vx = param1.x;
         this.vy = param1.y;
         this.vz = param1.z;
         this.x = this.vx * param2.sxx + this.vy * param2.sxy + this.vz * param2.sxz;
         this.y = this.vx * param2.syx + this.vy * param2.syy + this.vz * param2.syz;
         this.z = this.vx * param2.szx + this.vy * param2.szy + this.vz * param2.szz;
      }
      
      public function clone(param1:Number3D) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.z = param1.z;
      }
      
      public function matrix2scale(param1:MatrixAway3D) : void
      {
         this.x = Math.sqrt(param1.sxx * param1.sxx + param1.syx * param1.syx + param1.szx * param1.szx);
         this.y = Math.sqrt(param1.sxy * param1.sxy + param1.syy * param1.syy + param1.szy * param1.szy);
         this.z = Math.sqrt(param1.sxz * param1.sxz + param1.syz * param1.syz + param1.szz * param1.szz);
      }
      
      public function scale(param1:Number3D, param2:Number) : void
      {
         this.x = param1.x * param2;
         this.y = param1.y * param2;
         this.z = param1.z * param2;
      }
      
      public function transform(param1:Number3D, param2:MatrixAway3D) : void
      {
         this.vx = param1.x;
         this.vy = param1.y;
         this.vz = param1.z;
         this.x = this.vx * param2.sxx + this.vy * param2.sxy + this.vz * param2.sxz + param2.tx;
         this.y = this.vx * param2.syx + this.vy * param2.syy + this.vz * param2.syz + param2.ty;
         this.z = this.vx * param2.szx + this.vy * param2.szy + this.vz * param2.szz + param2.tz;
      }
      
      public function toString() : String
      {
         return "x:" + this.x + " y:" + this.y + " z:" + this.z;
      }
      
      public function distance(param1:Number3D) : Number
      {
         return Math.sqrt((this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y) + (this.z - param1.z) * (this.z - param1.z));
      }
      
      public function get modulo() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
      }
      
      public function matrix2euler(param1:MatrixAway3D, param2:Number = 1, param3:Number = 1, param4:Number = 1) : void
      {
         if(!this.m1)
         {
            this.m1 = new MatrixAway3D();
         }
         this.x = -Math.atan2(param1.szy,param1.szz);
         this.m1.rotationMatrix(1,0,0,this.x);
         this.m1.multiply(param1,this.m1);
         var _loc5_:Number = Math.sqrt(this.m1.sxx * this.m1.sxx + this.m1.syx * this.m1.syx);
         this.y = Math.atan2(-this.m1.szx,_loc5_);
         this.z = Math.atan2(-this.m1.sxy,this.m1.syy);
         if(Math.round(this.z / this.MathPI) == 1)
         {
            if(this.y > 0)
            {
               this.y = -(this.y - this.MathPI);
            }
            else
            {
               this.y = -(this.y + this.MathPI);
            }
            this.z = this.z - this.MathPI;
            if(this.x > 0)
            {
               this.x = this.x - this.MathPI;
            }
            else
            {
               this.x = this.x + this.MathPI;
            }
         }
         else if(Math.round(this.z / this.MathPI) == -1)
         {
            if(this.y > 0)
            {
               this.y = -(this.y - this.MathPI);
            }
            else
            {
               this.y = -(this.y + this.MathPI);
            }
            this.z = this.z + this.MathPI;
            if(this.x > 0)
            {
               this.x = this.x - this.MathPI;
            }
            else
            {
               this.x = this.x + this.MathPI;
            }
         }
         else if(Math.round(this.x / this.MathPI) == 1)
         {
            if(this.y > 0)
            {
               this.y = -(this.y - this.MathPI);
            }
            else
            {
               this.y = -(this.y + this.MathPI);
            }
            this.x = this.x - this.MathPI;
            if(this.z > 0)
            {
               this.z = this.z - this.MathPI;
            }
            else
            {
               this.z = this.z + this.MathPI;
            }
         }
         else if(Math.round(this.x / this.MathPI) == -1)
         {
            if(this.y > 0)
            {
               this.y = -(this.y - this.MathPI);
            }
            else
            {
               this.y = -(this.y + this.MathPI);
            }
            this.x = this.x + this.MathPI;
            if(this.z > 0)
            {
               this.z = this.z - this.MathPI;
            }
            else
            {
               this.z = this.z + this.MathPI;
            }
         }
      }
      
      public function get modulo2() : Number
      {
         return this.x * this.x + this.y * this.y + this.z * this.z;
      }
   }
}
