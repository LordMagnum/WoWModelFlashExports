package
{
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   import flash.system.System;
   
   public class ZeroClipboard extends Sprite
   {
       
      
      private var button:Sprite;
      
      private var id:String = "";
      
      private var clipText:String = "";
      
      public function ZeroClipboard()
      {
         super();
         stage.scaleMode = StageScaleMode.EXACT_FIT;
         Security.allowDomain("*");
         var flashvars:Object = LoaderInfo(this.root.loaderInfo).parameters;
         id = flashvars.id;
         button = new Sprite();
         button.buttonMode = true;
         button.useHandCursor = true;
         button.graphics.beginFill(13434624);
         button.graphics.drawRect(0,0,Math.floor(flashvars.width),Math.floor(flashvars.height));
         button.alpha = 0;
         addChild(button);
         button.addEventListener(MouseEvent.CLICK,clickHandler);
         button.addEventListener(MouseEvent.MOUSE_OVER,function(param1:Event):*
         {
            ExternalInterface.call("ZeroClipboard.dispatch",id,"mouseOver",null);
         });
         button.addEventListener(MouseEvent.MOUSE_OUT,function(param1:Event):*
         {
            ExternalInterface.call("ZeroClipboard.dispatch",id,"mouseOut",null);
         });
         button.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:Event):*
         {
            ExternalInterface.call("ZeroClipboard.dispatch",id,"mouseDown",null);
         });
         button.addEventListener(MouseEvent.MOUSE_UP,function(param1:Event):*
         {
            ExternalInterface.call("ZeroClipboard.dispatch",id,"mouseUp",null);
         });
         ExternalInterface.addCallback("setHandCursor",setHandCursor);
         ExternalInterface.addCallback("setText",setText);
         ExternalInterface.call("ZeroClipboard.dispatch",id,"load",null);
      }
      
      public function setHandCursor(param1:Boolean) : *
      {
         button.useHandCursor = param1;
      }
      
      private function clickHandler(param1:Event) : void
      {
         System.setClipboard(clipText);
         ExternalInterface.call("ZeroClipboard.dispatch",id,"complete",clipText);
      }
      
      public function setText(param1:*) : *
      {
         clipText = param1;
      }
   }
}
