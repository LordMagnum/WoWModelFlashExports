package away3d.core.base
{
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   
   public class VertexPosition
   {
       
      
      public var vertex:Vertex;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function VertexPosition(param1:Vertex)
      {
         super();
         this.vertex = param1;
         this.x = 0;
         this.y = 0;
         this.z = 0;
      }
      
      public function add(param1:Number3D) : void
      {
         this.vertex.add(param1);
      }
      
      public function transform(param1:MatrixAway3D) : void
      {
         this.vertex.transform(param1);
      }
      
      public function adjust(param1:Number = 1) : void
      {
         this.vertex.adjust(this.x,this.y,this.z,param1);
      }
      
      public function reset() : void
      {
         this.vertex.reset();
      }
      
      public function getIndex(param1:Array) : int
      {
         var _loc2_:Number = this.vertex.x;
         var _loc3_:Number = this.vertex.y;
         var _loc4_:Number = this.vertex.z;
         this.vertex.x = NaN;
         this.vertex.y = NaN;
         this.vertex.z = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            if(isNaN(param1[_loc6_].x) && isNaN(param1[_loc6_].y) && isNaN(param1[_loc6_].z))
            {
               _loc5_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         this.vertex.x = _loc2_;
         this.vertex.y = _loc3_;
         this.vertex.z = _loc4_;
         return _loc5_;
      }
   }
}
