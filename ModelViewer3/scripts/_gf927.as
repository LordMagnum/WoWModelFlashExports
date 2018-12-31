package
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class _gf927 extends Sprite
   {
       
      
      private var _th635:int;
      
      private var _uk429:Array;
      
      private var textField:TextField;
      
      private var _xy592:Shape;
      
      private var _mx250:int;
      
      private var _eh241:int;
      
      private var _vp680:Shape;
      
      private var listener:Object;
      
      private var _ah979:Number;
      
      public function _gf927(param1:int, param2:int, param3:Array)
      {
         var _loc4_:_vq97 = null;
         super();
         this._mx250 = param1;
         this._eh241 = param2;
         this._uk429 = param3;
         this._th635 = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this._uk429.length)
         {
            _loc4_ = this._uk429[_loc5_];
            if(this._uk429[_loc5_]._vc35)
            {
               this._th635 = _loc5_;
               break;
            }
            _loc5_++;
         }
         this.render();
         _loc4_ = param3[this._th635];
         if(!_loc4_)
         {
            return;
         }
         this.textField = new TextField();
         this.textField.text = _loc4_.name;
         this.textField.textColor = 16777215;
         this.textField.height = param2;
         this.textField.width = param1 - 60;
         this.textField.x = 30;
         this.textField.y = (param2 - 20) / 2;
         var _loc6_:TextFormat = new TextFormat();
         _loc6_.align = "center";
         this.textField.setTextFormat(_loc6_);
         addChild(this.textField);
         addEventListener(MouseEvent.MOUSE_DOWN,this._he1185);
      }
      
      public function _he1185(param1:MouseEvent) : void
      {
         if(param1.localX < 30 && this._th635 > 0)
         {
            this._th635--;
            this.textField.text = this._uk429[this._th635].name;
            this.listener._dn885(this._uk429[this._th635]);
         }
         else if(param1.localX > this._mx250 - 30 && this._th635 < this._uk429.length - 1)
         {
            this._th635++;
            this.textField.text = this._uk429[this._th635].name;
            this.listener._dn885(this._uk429[this._th635]);
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.align = "center";
         this.textField.setTextFormat(_loc2_);
         this.render();
      }
      
      public function _hy986(param1:int, param2:int) : void
      {
         this.x = param1 - width / 2;
         this.y = param2 - height / 2;
      }
      
      public function _ay708(param1:Object) : void
      {
         this.listener = param1;
      }
      
      private function render() : void
      {
         graphics.beginFill(11184810);
         graphics.drawRect(0,0,this._mx250,this._eh241);
         graphics.endFill();
         graphics.beginFill(6710886);
         graphics.drawRect(2,2,this._mx250 - 4,this._eh241 - 4);
         graphics.endFill();
         if(this._th635 == 0)
         {
            graphics.beginFill(2236962);
         }
         else
         {
            graphics.beginFill(8947848);
         }
         graphics.moveTo(20,10);
         graphics.lineTo(20,this._eh241 - 10);
         graphics.lineTo(10,this._eh241 / 2);
         graphics.moveTo(20,10);
         graphics.endFill();
         if(!this._uk429 || this._th635 >= this._uk429.length - 1)
         {
            graphics.beginFill(2236962);
         }
         else
         {
            graphics.beginFill(8947848);
         }
         graphics.moveTo(this._mx250 - 20,10);
         graphics.lineTo(this._mx250 - 20,this._eh241 - 10);
         graphics.lineTo(this._mx250 - 10,this._eh241 / 2);
         graphics.moveTo(this._mx250 - 20,10);
         graphics.endFill();
      }
   }
}
