package away3d.events
{
   import away3d.core.base.Face;
   import flash.events.Event;
   
   public class FaceEvent extends Event
   {
      
      public static const MAPPING_CHANGED:String = "mappingChanged";
       
      
      public var face:Face;
      
      public function FaceEvent(param1:String, param2:Face)
      {
         super(param1);
         this.face = param2;
      }
      
      override public function clone() : Event
      {
         return new FaceEvent(type,this.face);
      }
   }
}
