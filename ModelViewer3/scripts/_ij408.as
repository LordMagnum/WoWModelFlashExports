package
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class _ij408 extends Sprite
   {
       
      
      private var fontSize:int;
      
      private var _nx192:Bitmap;
      
      public var textField:TextField;
      
      public function _ij408(param1:Bitmap, param2:int = 16777215, param3:int = 12)
      {
         super();
         this._nx192 = param1;
         addChild(param1);
         this.textField = new TextField();
         this.textField.x = 0;
         this.textField.textColor = param2;
         this.textField.autoSize = TextFieldAutoSize.CENTER;
         this.textField.selectable = false;
         addChild(this.textField);
         this.fontSize = param3;
      }
      
      public function set size(param1:int) : void
      {
         this.fontSize = param1;
         this.text = this.textField.text;
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
         var _loc2_:TextFormat = new TextFormat("calibri",this.fontSize);
         _loc2_.align = "center";
         this.textField.setTextFormat(_loc2_);
         this.textField.x = (this._nx192.width - this.textField.width) / 2;
         this.textField.y = (this._nx192.height - this.textField.height) / 2;
      }
      
      public function set background(param1:Bitmap) : void
      {
         if(contains(this._nx192))
         {
            removeChild(this._nx192);
         }
         this._nx192 = param1;
         addChildAt(param1,0);
         var _loc2_:String = this.textField.text;
         this.textField.width = param1.width;
         this.textField.height = param1.height;
         this.text = _loc2_;
      }
   }
}
