package away3d.events
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.UV;
   import away3d.core.draw.DrawPrimitive;
   import away3d.materials.IUVMaterial;
   import flash.events.Event;
   
   public class MouseEvent3D extends Event
   {
      
      public static const MOUSE_MOVE:String = "mouseMove3d";
      
      public static const MOUSE_OVER:String = "mouseOver3d";
      
      public static const ROLL_OUT:String = "rollOut3d";
      
      public static const MOUSE_OUT:String = "mouseOut3d";
      
      public static const MOUSE_UP:String = "mouseUp3d";
      
      public static const MOUSE_DOWN:String = "mouseDown3d";
      
      public static const ROLL_OVER:String = "rollOver3d";
       
      
      public var sceneX:Number;
      
      public var sceneY:Number;
      
      public var sceneZ:Number;
      
      public var uv:UV;
      
      public var drawpri:DrawPrimitive;
      
      public var view:View3D;
      
      public var material:IUVMaterial;
      
      public var screenX:Number;
      
      public var screenY:Number;
      
      public var screenZ:Number;
      
      public var ctrlKey:Boolean;
      
      public var element:Object;
      
      public var shiftKey:Boolean;
      
      public var object:Object3D;
      
      public function MouseEvent3D(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         var _loc1_:MouseEvent3D = new MouseEvent3D(type);
         _loc1_.screenX = this.screenX;
         _loc1_.screenY = this.screenY;
         _loc1_.screenZ = this.screenZ;
         _loc1_.sceneX = this.sceneX;
         _loc1_.sceneY = this.sceneY;
         _loc1_.sceneZ = this.sceneZ;
         _loc1_.view = this.view;
         _loc1_.object = this.object;
         _loc1_.element = this.element;
         _loc1_.drawpri = this.drawpri;
         _loc1_.material = this.material;
         _loc1_.uv = this.uv;
         _loc1_.ctrlKey = this.ctrlKey;
         _loc1_.shiftKey = this.shiftKey;
         return _loc1_;
      }
   }
}
