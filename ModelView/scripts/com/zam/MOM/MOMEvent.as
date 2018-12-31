package com.zam.MOM
{
   import flash.events.Event;
   
   public class MOMEvent extends Event
   {
      
      public static const ATTACHMENT_LOADED:String = "momAttachmentComplete";
      
      public static const INTERNAL_ERROR:String = "momInternalError";
      
      public static const ERROR:String = "momError";
      
      public static const OPEN_FILE:String = "momOpen";
      
      public static const GEOMETRY_LOADED:String = "momGeometryDone";
      
      public static const CHANGED:String = "momChanged";
      
      public static const MATERIALS_LOADED:String = "momMaterialsDone";
      
      public static const MOM_LOADED:String = "momModelLoaded";
       
      
      public function MOMEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
