package away3d.core.draw
{
   import away3d.core.base.UV;
   import away3d.core.utils.FaceVO;
   import away3d.materials.BitmapMaterialContainer;
   import away3d.materials.ITriangleMaterial;
   import away3d.materials.IUVMaterial;
   import away3d.materials.WireColorMaterial;
   import flash.geom.Matrix;
   
   public class DrawTriangle extends DrawPrimitive
   {
       
      
      private var _u0:Number;
      
      private var _u2:Number;
      
      private var bzf:Number;
      
      private var axf:Number;
      
      private var det:Number;
      
      private var v12:ScreenVertex;
      
      private var _v0:Number;
      
      private var _v1:Number;
      
      private var _v2:Number;
      
      private var faz:Number;
      
      public var material:ITriangleMaterial;
      
      private var materialHeight:Number;
      
      private var av:Number;
      
      private var ax:Number;
      
      private var ay:Number;
      
      private var az:Number;
      
      private var ayf:Number;
      
      private var au:Number;
      
      private var fbz:Number;
      
      private var _areaSign:Number;
      
      private var v20:ScreenVertex;
      
      private var azf:Number;
      
      private var bu:Number;
      
      private var bv:Number;
      
      private var bx:Number;
      
      private var by:Number;
      
      private var bz:Number;
      
      private var fcz:Number;
      
      public var uvtData:Vector.<Number>;
      
      private var uv01:UV;
      
      private var d01:Number;
      
      private var cv:Number;
      
      private var cx:Number;
      
      private var cy:Number;
      
      private var cz:Number;
      
      private var cu:Number;
      
      public var v0:ScreenVertex;
      
      public var v1:ScreenVertex;
      
      private var da:Number;
      
      private var db:Number;
      
      private var dc:Number;
      
      private var _invtexmapping:Matrix;
      
      private var dd01:Number;
      
      private var uv12:UV;
      
      private var d12:Number;
      
      public var area:Number;
      
      private var cxf:Number;
      
      public var v2:ScreenVertex;
      
      private var uv20:UV;
      
      private var dd12:Number;
      
      private var d20:Number;
      
      public var uv0:UV;
      
      public var uv2:UV;
      
      private var dd20:Number;
      
      private var cyf:Number;
      
      public var backface:Boolean = false;
      
      private var czf:Number;
      
      private var bxf:Number;
      
      public var uv1:UV;
      
      public var faceVO:FaceVO;
      
      private var focus:Number;
      
      private var materialWidth:Number;
      
      private var byf:Number;
      
      private var v01:ScreenVertex;
      
      public var vertices:Vector.<Number>;
      
      private var _u1:Number;
      
      public function DrawTriangle()
      {
         this._invtexmapping = new Matrix();
         this.vertices = new Vector.<Number>();
         this.uvtData = new Vector.<Number>();
         super();
      }
      
      public final function transformUV(param1:IUVMaterial) : Matrix
      {
         this.materialWidth = param1.width;
         this.materialHeight = param1.height;
         if(this.uv0 == null || this.uv1 == null || this.uv2 == null)
         {
            return null;
         }
         this._u0 = this.materialWidth * this.uv0._u;
         this._u1 = this.materialWidth * this.uv1._u;
         this._u2 = this.materialWidth * this.uv2._u;
         this._v0 = this.materialHeight * (1 - this.uv0._v);
         this._v1 = this.materialHeight * (1 - this.uv1._v);
         this._v2 = this.materialHeight * (1 - this.uv2._v);
         this._invtexmapping.a = this._u1 - this._u0;
         this._invtexmapping.b = this._v1 - this._v0;
         this._invtexmapping.c = this._u2 - this._u0;
         this._invtexmapping.d = this._v2 - this._v0;
         if(param1 is BitmapMaterialContainer)
         {
            this._invtexmapping.tx = this._u0 - this.faceVO.bitmapRect.x;
            this._invtexmapping.ty = this._v0 - this.faceVO.bitmapRect.y;
         }
         else
         {
            this._invtexmapping.tx = this._u0;
            this._invtexmapping.ty = this._v0;
         }
         return this._invtexmapping;
      }
      
      final function bisect(param1:Number) : Array
      {
         this.d01 = this.v0.distanceSqr(this.v1);
         this.d12 = this.v1.distanceSqr(this.v2);
         this.d20 = this.v2.distanceSqr(this.v0);
         if(this.d12 >= this.d01 && this.d12 >= this.d20)
         {
            return this.bisect12(param1);
         }
         if(this.d01 >= this.d20)
         {
            return this.bisect01(param1);
         }
         return this.bisect20(param1);
      }
      
      final function minEdgeSqr() : Number
      {
         return Math.min(Math.min(this.v0.distanceSqr(this.v1),this.v1.distanceSqr(this.v2)),this.v2.distanceSqr(this.v0));
      }
      
      final function minDistortSqr(param1:Number) : Number
      {
         return Math.min(Math.min(this.v0.distortSqr(this.v1,param1),this.v1.distortSqr(this.v2,param1)),this.v2.distortSqr(this.v0,param1));
      }
      
      override public final function contains(param1:Number, param2:Number) : Boolean
      {
         if((this.v0.x * (param2 - this.v1.y) + this.v1.x * (this.v0.y - param2) + param1 * (this.v1.y - this.v0.y)) * this._areaSign < -0.001)
         {
            return false;
         }
         if((this.v0.x * (this.v2.y - param2) + param1 * (this.v0.y - this.v2.y) + this.v2.x * (param2 - this.v0.y)) * this._areaSign < -0.001)
         {
            return false;
         }
         if((param1 * (this.v2.y - this.v1.y) + this.v1.x * (param2 - this.v2.y) + this.v2.x * (this.v1.y - param2)) * this._areaSign < -0.001)
         {
            return false;
         }
         return true;
      }
      
      final function distortbisect(param1:Number) : Array
      {
         this.d01 = this.v0.distortSqr(this.v1,param1);
         this.d12 = this.v1.distortSqr(this.v2,param1);
         this.d20 = this.v2.distortSqr(this.v0,param1);
         if(this.d12 >= this.d01 && this.d12 >= this.d20)
         {
            return this.bisect12(param1);
         }
         if(this.d01 >= this.d20)
         {
            return this.bisect01(param1);
         }
         return this.bisect20(param1);
      }
      
      function fivepointcut(param1:ScreenVertex, param2:ScreenVertex, param3:ScreenVertex, param4:ScreenVertex, param5:ScreenVertex, param6:UV, param7:UV, param8:UV, param9:UV, param10:UV) : Array
      {
         if(param1.distanceSqr(param4) < param2.distanceSqr(param5))
         {
            return [create(source,this.faceVO,this.material,param1,param2,param4,param6,param7,param9,true),create(source,this.faceVO,this.material,param2,param3,param4,param7,param8,param9,true),create(source,this.faceVO,this.material,param1,param4,param5,param6,param9,param10,true)];
         }
         return [create(source,this.faceVO,this.material,param1,param2,param5,param6,param7,param10,true),create(source,this.faceVO,this.material,param2,param3,param4,param7,param8,param9,true),create(source,this.faceVO,this.material,param2,param4,param5,param7,param9,param10,true)];
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "";
         if(this.material is WireColorMaterial)
         {
            switch((this.material as WireColorMaterial).color)
            {
               case 65280:
                  _loc1_ = "green";
                  break;
               case 16776960:
                  _loc1_ = "yellow";
                  break;
               case 16711680:
                  _loc1_ = "red";
                  break;
               case 255:
                  _loc1_ = "blue";
            }
         }
         return "T{" + _loc1_ + int(this.area) + " screenZ = " + this.num(screenZ) + ", minZ = " + this.num(minZ) + ", maxZ = " + this.num(maxZ) + " }";
      }
      
      final function acuteAngled() : Boolean
      {
         this.d01 = this.v0.distanceSqr(this.v1);
         this.d12 = this.v1.distanceSqr(this.v2);
         this.d20 = this.v2.distanceSqr(this.v0);
         this.dd01 = this.d01 * this.d01;
         this.dd12 = this.d12 * this.d12;
         this.dd20 = this.d20 * this.d20;
         return this.dd01 <= this.dd12 + this.dd20 && this.dd12 <= this.dd20 + this.dd01 && this.dd20 <= this.dd01 + this.dd12;
      }
      
      private function num(param1:Number) : Number
      {
         return int(param1 * 1000) / 1000;
      }
      
      private final function bisect01(param1:Number) : Array
      {
         var _loc2_:ScreenVertex = ScreenVertex.median(this.v0,this.v1,param1);
         var _loc3_:UV = UV.median(this.uv0,this.uv1);
         return [create(source,this.faceVO,this.material,this.v2,this.v0,_loc2_,this.uv2,this.uv0,_loc3_,true),create(source,this.faceVO,this.material,_loc2_,this.v1,this.v2,_loc3_,this.uv1,this.uv2,true)];
      }
      
      override public function calc() : void
      {
         if(this.v0.x > this.v1.x)
         {
            if(this.v0.x > this.v2.x)
            {
               maxX = this.v0.x;
            }
            else
            {
               maxX = this.v2.x;
            }
         }
         else if(this.v1.x > this.v2.x)
         {
            maxX = this.v1.x;
         }
         else
         {
            maxX = this.v2.x;
         }
         if(this.v0.x < this.v1.x)
         {
            if(this.v0.x < this.v2.x)
            {
               minX = this.v0.x;
            }
            else
            {
               minX = this.v2.x;
            }
         }
         else if(this.v1.x < this.v2.x)
         {
            minX = this.v1.x;
         }
         else
         {
            minX = this.v2.x;
         }
         if(this.v0.y > this.v1.y)
         {
            if(this.v0.y > this.v2.y)
            {
               maxY = this.v0.y;
            }
            else
            {
               maxY = this.v2.y;
            }
         }
         else if(this.v1.y > this.v2.y)
         {
            maxY = this.v1.y;
         }
         else
         {
            maxY = this.v2.y;
         }
         if(this.v0.y < this.v1.y)
         {
            if(this.v0.y < this.v2.y)
            {
               minY = this.v0.y;
            }
            else
            {
               minY = this.v2.y;
            }
         }
         else if(this.v1.y < this.v2.y)
         {
            minY = this.v1.y;
         }
         else
         {
            minY = this.v2.y;
         }
         if(this.v0.z > this.v1.z)
         {
            if(this.v0.z > this.v2.z)
            {
               maxZ = this.v0.z;
            }
            else
            {
               maxZ = this.v2.z;
            }
         }
         else if(this.v1.z > this.v2.z)
         {
            maxZ = this.v1.z;
         }
         else
         {
            maxZ = this.v2.z;
         }
         if(this.v0.z < this.v1.z)
         {
            if(this.v0.z < this.v2.z)
            {
               minZ = this.v0.z;
            }
            else
            {
               minZ = this.v2.z;
            }
         }
         else if(this.v1.z < this.v2.z)
         {
            minZ = this.v1.z;
         }
         else
         {
            minZ = this.v2.z;
         }
         screenZ = (minZ + maxZ) / 2;
         this.area = 0.5 * (this.v0.x * (this.v2.y - this.v1.y) + this.v1.x * (this.v0.y - this.v2.y) + this.v2.x * (this.v1.y - this.v0.y));
         if(this.area > 0)
         {
            this._areaSign = 1;
         }
         else
         {
            this._areaSign = -1;
         }
         this.vertices[0] = this.v0.x;
         this.vertices[1] = this.v0.y;
         this.vertices[2] = this.v1.x;
         this.vertices[3] = this.v1.y;
         this.vertices[4] = this.v2.x;
         this.vertices[5] = this.v2.y;
      }
      
      override public function clear() : void
      {
         this.v0 = null;
         this.v1 = null;
         this.v2 = null;
         this.uv0 = null;
         this.uv1 = null;
         this.uv2 = null;
      }
      
      override public function render() : void
      {
         this.material.renderTriangle(this);
      }
      
      private final function bisect12(param1:Number) : Array
      {
         var _loc2_:ScreenVertex = ScreenVertex.median(this.v1,this.v2,param1);
         var _loc3_:UV = UV.median(this.uv1,this.uv2);
         return [create(source,this.faceVO,this.material,this.v0,this.v1,_loc2_,this.uv0,this.uv1,_loc3_,true),create(source,this.faceVO,this.material,_loc2_,this.v2,this.v0,_loc3_,this.uv2,this.uv0,true)];
      }
      
      override public final function quarter(param1:Number) : Array
      {
         if(this.area > -20 && this.area < 20)
         {
            return null;
         }
         this.v01 = ScreenVertex.median(this.v0,this.v1,param1);
         this.v12 = ScreenVertex.median(this.v1,this.v2,param1);
         this.v20 = ScreenVertex.median(this.v2,this.v0,param1);
         this.uv01 = UV.median(this.uv0,this.uv1);
         this.uv12 = UV.median(this.uv1,this.uv2);
         this.uv20 = UV.median(this.uv2,this.uv0);
         return [create(source,this.faceVO,this.material,this.v0,this.v01,this.v20,this.uv0,this.uv01,this.uv20,true),create(source,this.faceVO,this.material,this.v1,this.v12,this.v01,this.uv1,this.uv12,this.uv01,true),create(source,this.faceVO,this.material,this.v2,this.v20,this.v12,this.uv2,this.uv20,this.uv12,true),create(source,this.faceVO,this.material,this.v01,this.v12,this.v20,this.uv01,this.uv12,this.uv20,true)];
      }
      
      private final function bisect20(param1:Number) : Array
      {
         var _loc2_:ScreenVertex = ScreenVertex.median(this.v2,this.v0,param1);
         var _loc3_:UV = UV.median(this.uv2,this.uv0);
         return [create(source,this.faceVO,this.material,this.v1,this.v2,_loc2_,this.uv1,this.uv2,_loc3_,true),create(source,this.faceVO,this.material,_loc2_,this.v0,this.v1,_loc3_,this.uv0,this.uv1,true)];
      }
      
      public final function distanceToCenter(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = (this.v0.x + this.v1.x + this.v2.x) / 3;
         var _loc4_:Number = (this.v0.y + this.v1.y + this.v2.y) / 3;
         return Math.sqrt((_loc3_ - param1) * (_loc3_ - param1) + (_loc4_ - param2) * (_loc4_ - param2));
      }
      
      final function maxDistortSqr(param1:Number) : Number
      {
         return Math.max(Math.max(this.v0.distortSqr(this.v1,param1),this.v1.distortSqr(this.v2,param1)),this.v2.distortSqr(this.v0,param1));
      }
      
      final function maxEdgeSqr() : Number
      {
         return Math.max(Math.max(this.v0.distanceSqr(this.v1),this.v1.distanceSqr(this.v2)),this.v2.distanceSqr(this.v0));
      }
      
      override public final function getZ(param1:Number, param2:Number) : Number
      {
         this.focus = view.camera.focus;
         this.ax = this.v0.x;
         this.ay = this.v0.y;
         this.az = this.v0.z;
         this.bx = this.v1.x;
         this.by = this.v1.y;
         this.bz = this.v1.z;
         this.cx = this.v2.x;
         this.cy = this.v2.y;
         this.cz = this.v2.z;
         if(this.ax == param1 && this.ay == param2)
         {
            return this.az;
         }
         if(this.bx == param1 && this.by == param2)
         {
            return this.bz;
         }
         if(this.cx == param1 && this.cy == param2)
         {
            return this.cz;
         }
         this.azf = this.az / this.focus;
         this.bzf = this.bz / this.focus;
         this.czf = this.cz / this.focus;
         this.faz = 1 + this.azf;
         this.fbz = 1 + this.bzf;
         this.fcz = 1 + this.czf;
         this.axf = this.ax * this.faz - param1 * this.azf;
         this.bxf = this.bx * this.fbz - param1 * this.bzf;
         this.cxf = this.cx * this.fcz - param1 * this.czf;
         this.ayf = this.ay * this.faz - param2 * this.azf;
         this.byf = this.by * this.fbz - param2 * this.bzf;
         this.cyf = this.cy * this.fcz - param2 * this.czf;
         this.det = this.axf * (this.byf - this.cyf) + this.bxf * (this.cyf - this.ayf) + this.cxf * (this.ayf - this.byf);
         this.da = param1 * (this.byf - this.cyf) + this.bxf * (this.cyf - param2) + this.cxf * (param2 - this.byf);
         this.db = this.axf * (param2 - this.cyf) + param1 * (this.cyf - this.ayf) + this.cxf * (this.ayf - param2);
         this.dc = this.axf * (this.byf - param2) + this.bxf * (param2 - this.ayf) + param1 * (this.ayf - this.byf);
         return (this.da * this.az + this.db * this.bz + this.dc * this.cz) / this.det;
      }
   }
}
