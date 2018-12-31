package away3d.events
{
   import away3d.core.base.Segment;
   import flash.events.Event;
   
   public class SegmentEvent extends Event
   {
      
      public static const MATERIAL_CHANGED:String = "materialChanged";
       
      
      public var segment:Segment;
      
      public function SegmentEvent(param1:String, param2:Segment)
      {
         super(param1);
         this.segment = param2;
      }
      
      override public function clone() : Event
      {
         return new SegmentEvent(type,this.segment);
      }
   }
}
