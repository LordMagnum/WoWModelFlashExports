package org.papervision3d.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import org.papervision3d.core.proto.CameraObject3D;
   import org.papervision3d.core.view.IView;
   import org.papervision3d.render.BasicRenderEngine;
   import org.papervision3d.scenes.Scene3D;
   
   public class AbstractView extends Sprite implements IView
   {
       
      
      public var renderer:BasicRenderEngine;
      
      protected var _camera:CameraObject3D;
      
      protected var _width:Number;
      
      public var scene:Scene3D;
      
      protected var _height:Number;
      
      public var viewport:Viewport3D;
      
      public function AbstractView()
      {
         super();
      }
      
      public function set viewportWidth(param1:Number) : void
      {
         this._width = param1;
         this.viewport.width = param1;
      }
      
      public function singleRender() : void
      {
         this.onRenderTick();
      }
      
      public function startRendering() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onRenderTick);
         this.viewport.containerSprite.cacheAsBitmap = false;
      }
      
      public function get viewportWidth() : Number
      {
         return this._width;
      }
      
      protected function onRenderTick(param1:Event = null) : void
      {
         this.renderer.renderScene(this.scene,this._camera,this.viewport);
      }
      
      public function set viewportHeight(param1:Number) : void
      {
         this._height = param1;
         this.viewport.height = param1;
      }
      
      public function get camera() : CameraObject3D
      {
         return this._camera;
      }
      
      public function get viewportHeight() : Number
      {
         return this._height;
      }
      
      public function stopRendering(param1:Boolean = false, param2:Boolean = false) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onRenderTick);
         if(param1)
         {
            this.onRenderTick();
         }
         if(param2)
         {
            this.viewport.containerSprite.cacheAsBitmap = true;
         }
         else
         {
            this.viewport.containerSprite.cacheAsBitmap = false;
         }
      }
   }
}
