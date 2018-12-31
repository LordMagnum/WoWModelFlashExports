package away3d.core.geom
{
   import away3d.core.base.Object3D;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   
   public class Frustum
   {
      
      public static const IN:int = 1;
      
      public static const OUT:int = 0;
      
      public static const LEFT:int = 0;
      
      public static const NEAR:int = 4;
      
      public static const BOTTOM:int = 3;
      
      public static const TOP:int = 2;
      
      public static const FAR:int = 5;
      
      public static const RIGHT:int = 1;
      
      public static const INTERSECT:int = 2;
       
      
      private var _matrix:MatrixAway3D;
      
      private var _distance:Number;
      
      public var planes:Array;
      
      private var _plane:Plane3D;
      
      public function Frustum()
      {
         this._matrix = new MatrixAway3D();
         super();
         this.planes = new Array(6);
         this.planes[LEFT] = new Plane3D();
         this.planes[RIGHT] = new Plane3D();
         this.planes[TOP] = new Plane3D();
         this.planes[BOTTOM] = new Plane3D();
         this.planes[NEAR] = new Plane3D();
         this.planes[FAR] = new Plane3D();
      }
      
      public function classifyAABB(param1:Array) : int
      {
         var _loc4_:Plane3D = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            _loc4_ = Plane3D(this.planes[_loc3_]);
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < 8)
            {
               if(_loc4_.classifyPoint(param1[_loc6_]) == Plane3D.FRONT)
               {
                  _loc5_++;
               }
               _loc6_++;
            }
            if(_loc5_ == 0)
            {
               return OUT;
            }
            if(_loc5_ == 8)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ == 6)
         {
            return IN;
         }
         return INTERSECT;
      }
      
      public function extractFromMatrix(param1:MatrixAway3D) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc18_:Plane3D = null;
         this._matrix = param1;
         var _loc2_:Number = param1.sxx;
         var _loc3_:Number = param1.sxy;
         var _loc4_:Number = param1.sxz;
         var _loc5_:Number = param1.tx;
         var _loc6_:Number = param1.syx;
         var _loc7_:Number = param1.syy;
         _loc8_ = param1.syz;
         _loc9_ = param1.ty;
         _loc10_ = param1.szx;
         _loc11_ = param1.szy;
         _loc12_ = param1.szz;
         _loc13_ = param1.tz;
         _loc14_ = param1.swx;
         _loc15_ = param1.swy;
         var _loc16_:Number = param1.swz;
         var _loc17_:Number = param1.tw;
         _loc18_ = Plane3D(this.planes[NEAR]);
         _loc18_.a = _loc14_ + _loc10_;
         _loc18_.b = _loc15_ + _loc11_;
         _loc18_.c = _loc16_ + _loc12_;
         _loc18_.d = _loc17_ + _loc13_;
         _loc18_.normalize();
         var _loc19_:Plane3D = Plane3D(this.planes[FAR]);
         _loc19_.a = -_loc10_ + _loc14_;
         _loc19_.b = -_loc11_ + _loc15_;
         _loc19_.c = -_loc12_ + _loc16_;
         _loc19_.d = -_loc13_ + _loc17_;
         _loc19_.normalize();
         var _loc20_:Plane3D = Plane3D(this.planes[LEFT]);
         _loc20_.a = _loc14_ + _loc2_;
         _loc20_.b = _loc15_ + _loc3_;
         _loc20_.c = _loc16_ + _loc4_;
         _loc20_.d = _loc17_ + _loc5_;
         _loc20_.normalize();
         var _loc21_:Plane3D = Plane3D(this.planes[RIGHT]);
         _loc21_.a = -_loc2_ + _loc14_;
         _loc21_.b = -_loc3_ + _loc15_;
         _loc21_.c = -_loc4_ + _loc16_;
         _loc21_.d = -_loc5_ + _loc17_;
         _loc21_.normalize();
         var _loc22_:Plane3D = Plane3D(this.planes[TOP]);
         _loc22_.a = _loc14_ + _loc6_;
         _loc22_.b = _loc15_ + _loc7_;
         _loc22_.c = _loc16_ + _loc8_;
         _loc22_.d = _loc17_ + _loc9_;
         _loc22_.normalize();
         var _loc23_:Plane3D = Plane3D(this.planes[BOTTOM]);
         _loc23_.a = -_loc6_ + _loc14_;
         _loc23_.b = -_loc7_ + _loc15_;
         _loc23_.c = -_loc8_ + _loc16_;
         _loc23_.d = -_loc9_ + _loc17_;
         _loc23_.normalize();
      }
      
      public function classifySphere(param1:Number3D, param2:Number) : int
      {
         for each(this._plane in this.planes)
         {
            this._distance = this._plane.distance(param1);
            if(this._distance < -param2)
            {
               return OUT;
            }
            if(Math.abs(this._distance) < param2)
            {
               return INTERSECT;
            }
         }
         return IN;
      }
      
      public function classifyRadius(param1:Number) : int
      {
         for each(this._plane in this.planes)
         {
            if(this._plane.d < -param1)
            {
               return OUT;
            }
            if(Math.abs(this._plane.d) < param1)
            {
               return INTERSECT;
            }
         }
         return IN;
      }
      
      public function classifyObject3D(param1:Object3D) : int
      {
         return this.classifySphere(param1.sceneTransform.position,param1.boundingRadius);
      }
   }
}
