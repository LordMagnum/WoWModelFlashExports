package com.adobe.utils
{
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   public class PerspectiveMatrix3D extends Matrix3D
   {
       
      
      private var _x:Vector3D;
      
      private var _y:Vector3D;
      
      private var _z:Vector3D;
      
      private var _w:Vector3D;
      
      public function PerspectiveMatrix3D(param1:Vector.<Number> = null)
      {
         this._x = new Vector3D();
         this._y = new Vector3D();
         this._z = new Vector3D();
         this._w = new Vector3D();
         super(param1);
      }
      
      public function lookAtLH(param1:Vector3D, param2:Vector3D, param3:Vector3D) : void
      {
         this._z.copyFrom(param2);
         this._z.subtract(param1);
         this._z.normalize();
         this._z.w = 0;
         this._x.copyFrom(param3);
         this._crossProductTo(this._x,this._z);
         this._x.normalize();
         this._x.w = 0;
         this._y.copyFrom(this._z);
         this._crossProductTo(this._y,this._x);
         this._y.w = 0;
         this._w.x = this._x.dotProduct(param1);
         this._w.y = this._y.dotProduct(param1);
         this._w.z = this._z.dotProduct(param1);
         this._w.w = 1;
         copyRowFrom(0,this._x);
         copyRowFrom(1,this._y);
         copyRowFrom(2,this._z);
         copyRowFrom(3,this._w);
      }
      
      public function lookAtRH(param1:Vector3D, param2:Vector3D, param3:Vector3D) : void
      {
         this._z.copyFrom(param1);
         this._z.subtract(param2);
         this._z.normalize();
         this._z.w = 0;
         this._x.copyFrom(param3);
         this._crossProductTo(this._x,this._z);
         this._x.normalize();
         this._x.w = 0;
         this._y.copyFrom(this._z);
         this._crossProductTo(this._y,this._x);
         this._y.w = 0;
         this._w.x = this._x.dotProduct(param1);
         this._w.y = this._y.dotProduct(param1);
         this._w.z = this._z.dotProduct(param1);
         this._w.w = 1;
         copyRowFrom(0,this._x);
         copyRowFrom(1,this._y);
         copyRowFrom(2,this._z);
         copyRowFrom(3,this._w);
      }
      
      public function perspectiveLH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 * param3 / param1,0,0,0,0,2 * param3 / param2,0,0,0,0,param4 / (param4 - param3),1,0,0,param3 * param4 / (param3 - param4),0]));
      }
      
      public function perspectiveRH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 * param3 / param1,0,0,0,0,2 * param3 / param2,0,0,0,0,param4 / (param3 - param4),-1,0,0,param3 * param4 / (param3 - param4),0]));
      }
      
      public function perspectiveFieldOfViewLH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = 1 / Math.tan(param1 / 2);
         var _loc6_:Number = _loc5_ / param2;
         this.copyRawDataFrom(Vector.<Number>([_loc6_,0,0,0,0,_loc5_,0,0,0,0,param4 / (param4 - param3),1,0,0,param3 * param4 / (param3 - param4),0]));
      }
      
      public function perspectiveFieldOfViewRH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = 1 / Math.tan(param1 / 2);
         var _loc6_:Number = _loc5_ / param2;
         this.copyRawDataFrom(Vector.<Number>([_loc6_,0,0,0,0,_loc5_,0,0,0,0,param4 / (param3 - param4),-1,0,0,param3 * param4 / (param3 - param4),0]));
      }
      
      public function perspectiveOffCenterLH(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 * param5 / (param2 - param1),0,0,0,0,-2 * param5 / (param3 - param4),0,0,-1 - 2 * param1 / (param2 - param1),1 + 2 * param4 / (param3 - param4),-param6 / (param5 - param6),1,0,0,param5 * param6 / (param5 - param6),0]));
      }
      
      public function perspectiveOffCenterRH(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 * param5 / (param2 - param1),0,0,0,0,-2 * param5 / (param3 - param4),0,0,1 + 2 * param1 / (param2 - param1),-1 - 2 * param4 / (param3 - param4),param6 / (param5 - param6),-1,0,0,param5 * param6 / (param5 - param6),0]));
      }
      
      public function orthoLH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 / param1,0,0,0,0,2 / param2,0,0,0,0,1 / (param4 - param3),0,0,0,param3 / (param3 - param4),1]));
      }
      
      public function orthoRH(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 / param1,0,0,0,0,2 / param2,0,0,0,0,1 / (param3 - param3),0,0,0,param3 / (param3 - param4),1]));
      }
      
      public function orthoOffCenterLH(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 / (param2 - param1),0,0,0,0,2 * param5 / (param4 - param3),0,0,-1 - 2 * param1 / (param2 - param1),1 + 2 * param4 / (param3 - param4),1 / (param6 - param5),0,0,0,param5 / (param5 - param6),1]));
      }
      
      public function orthoOffCenterRH(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.copyRawDataFrom(Vector.<Number>([2 / (param2 - param1),0,0,0,0,2 * param5 / (param4 - param3),0,0,-1 - 2 * param1 / (param2 - param1),1 + 2 * param4 / (param3 - param4),1 / (param5 - param6),0,0,0,param5 / (param5 - param6),1]));
      }
      
      private function _crossProductTo(param1:Vector3D, param2:Vector3D) : void
      {
         this._w.x = param1.y * param2.z - param1.z * param2.y;
         this._w.y = param1.z * param2.x - param1.x * param2.z;
         this._w.z = param1.x * param2.y - param1.y * param2.x;
         this._w.w = 1;
         param1.copyFrom(this._w);
      }
   }
}
