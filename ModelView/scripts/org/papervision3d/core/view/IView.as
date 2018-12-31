package org.papervision3d.core.view
{
   public interface IView
   {
       
      
      function stopRendering(param1:Boolean = false, param2:Boolean = false) : void;
      
      function startRendering() : void;
      
      function singleRender() : void;
   }
}
