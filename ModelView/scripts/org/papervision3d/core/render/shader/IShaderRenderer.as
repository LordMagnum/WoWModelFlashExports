package org.papervision3d.core.render.shader
{
   import flash.display.Sprite;
   import org.papervision3d.core.render.data.RenderSessionData;
   import org.papervision3d.materials.shaders.Shader;
   
   public interface IShaderRenderer
   {
       
      
      function destroy() : void;
      
      function getLayerForShader(param1:Shader) : Sprite;
      
      function clear() : void;
      
      function render(param1:RenderSessionData) : void;
   }
}
