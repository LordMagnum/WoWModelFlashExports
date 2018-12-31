package org.papervision3d.core.render.material
{
   import org.papervision3d.core.render.data.RenderSessionData;
   
   public interface IUpdateBeforeMaterial
   {
       
      
      function isUpdateable() : Boolean;
      
      function updateBeforeRender(param1:RenderSessionData) : void;
   }
}
