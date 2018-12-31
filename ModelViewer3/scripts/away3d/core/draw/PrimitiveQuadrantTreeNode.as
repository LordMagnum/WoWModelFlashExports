package away3d.core.draw
{
   import away3d.core.base.Object3D;
   
   public final class PrimitiveQuadrantTreeNode
   {
       
      
      public var parent:PrimitiveQuadrantTreeNode;
      
      public var create:Function;
      
      private var level:int;
      
      public var righttopFlag:Boolean;
      
      public var rightbottom:PrimitiveQuadrantTreeNode;
      
      public var righttop:PrimitiveQuadrantTreeNode;
      
      public var rightbottomFlag:Boolean;
      
      public var onlysource:Object3D;
      
      public var xdiv:Number;
      
      private var halfheight:Number;
      
      public var center:Array;
      
      private var maxlevel:int = 4;
      
      private var render_center_length:int = -1;
      
      public var onlysourceFlag:Boolean = true;
      
      private var render_center_index:int = -1;
      
      private var halfwidth:Number;
      
      public var lefttop:PrimitiveQuadrantTreeNode;
      
      public var ydiv:Number;
      
      public var leftbottom:PrimitiveQuadrantTreeNode;
      
      public var lefttopFlag:Boolean;
      
      public var leftbottomFlag:Boolean;
      
      public function PrimitiveQuadrantTreeNode(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:PrimitiveQuadrantTreeNode = null)
      {
         this.center = new Array();
         super();
         this.level = param5;
         this.xdiv = param1;
         this.ydiv = param2;
         this.halfwidth = param3 / 2;
         this.halfheight = param4 / 2;
         this.parent = param6;
      }
      
      public function reset(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.xdiv = param1;
         this.ydiv = param2;
         this.halfwidth = param3 / 2;
         this.halfheight = param4 / 2;
         this.lefttopFlag = false;
         this.leftbottomFlag = false;
         this.righttopFlag = false;
         this.rightbottomFlag = false;
         this.center = new Array();
         this.onlysourceFlag = true;
         this.onlysource = null;
         this.render_center_length = -1;
         this.render_center_index = -1;
      }
      
      public function push(param1:DrawPrimitive) : void
      {
         if(this.onlysourceFlag)
         {
            if(this.onlysource != null && this.onlysource != param1.source)
            {
               this.onlysourceFlag = false;
            }
            this.onlysource = param1.source;
         }
         if(this.level < this.maxlevel)
         {
            if(param1.maxX <= this.xdiv)
            {
               if(param1.maxY <= this.ydiv)
               {
                  if(this.lefttop == null)
                  {
                     this.lefttopFlag = true;
                     this.lefttop = new PrimitiveQuadrantTreeNode(this.xdiv - this.halfwidth / 2,this.ydiv - this.halfheight / 2,this.halfwidth,this.halfheight,this.level + 1,this);
                  }
                  else if(!this.lefttopFlag)
                  {
                     this.lefttopFlag = true;
                     this.lefttop.reset(this.xdiv - this.halfwidth / 2,this.ydiv - this.halfheight / 2,this.halfwidth,this.halfheight);
                  }
                  this.lefttop.push(param1);
                  return;
               }
               if(param1.minY >= this.ydiv)
               {
                  if(this.leftbottom == null)
                  {
                     this.leftbottomFlag = true;
                     this.leftbottom = new PrimitiveQuadrantTreeNode(this.xdiv - this.halfwidth / 2,this.ydiv + this.halfheight / 2,this.halfwidth,this.halfheight,this.level + 1,this);
                  }
                  else if(!this.leftbottomFlag)
                  {
                     this.leftbottomFlag = true;
                     this.leftbottom.reset(this.xdiv - this.halfwidth / 2,this.ydiv + this.halfheight / 2,this.halfwidth,this.halfheight);
                  }
                  this.leftbottom.push(param1);
                  return;
               }
            }
            else if(param1.minX >= this.xdiv)
            {
               if(param1.maxY <= this.ydiv)
               {
                  if(this.righttop == null)
                  {
                     this.righttopFlag = true;
                     this.righttop = new PrimitiveQuadrantTreeNode(this.xdiv + this.halfwidth / 2,this.ydiv - this.halfheight / 2,this.halfwidth,this.halfheight,this.level + 1,this);
                  }
                  else if(!this.righttopFlag)
                  {
                     this.righttopFlag = true;
                     this.righttop.reset(this.xdiv + this.halfwidth / 2,this.ydiv - this.halfheight / 2,this.halfwidth,this.halfheight);
                  }
                  this.righttop.push(param1);
                  return;
               }
               if(param1.minY >= this.ydiv)
               {
                  if(this.rightbottom == null)
                  {
                     this.rightbottomFlag = true;
                     this.rightbottom = new PrimitiveQuadrantTreeNode(this.xdiv + this.halfwidth / 2,this.ydiv + this.halfheight / 2,this.halfwidth,this.halfheight,this.level + 1,this);
                  }
                  else if(!this.rightbottomFlag)
                  {
                     this.rightbottomFlag = true;
                     this.rightbottom.reset(this.xdiv + this.halfwidth / 2,this.ydiv + this.halfheight / 2,this.halfwidth,this.halfheight);
                  }
                  this.rightbottom.push(param1);
                  return;
               }
            }
         }
         this.center.push(param1);
         param1.quadrant = this;
      }
      
      public function render(param1:Number) : void
      {
         var _loc2_:DrawPrimitive = null;
         if(this.render_center_length == -1)
         {
            this.render_center_length = this.center.length;
            if(this.render_center_length)
            {
               if(this.render_center_length > 1)
               {
                  this.center.sortOn("screenZ",Array.DESCENDING | Array.NUMERIC);
               }
            }
            this.render_center_index = 0;
         }
         while(this.render_center_index < this.render_center_length)
         {
            _loc2_ = this.center[this.render_center_index];
            if(_loc2_.screenZ < param1)
            {
               break;
            }
            this.render_other(_loc2_.screenZ);
            _loc2_.render();
            this.render_center_index++;
         }
         this.render_other(param1);
      }
      
      private function render_other(param1:Number) : void
      {
         if(this.lefttopFlag)
         {
            this.lefttop.render(param1);
         }
         if(this.leftbottomFlag)
         {
            this.leftbottom.render(param1);
         }
         if(this.righttopFlag)
         {
            this.righttop.render(param1);
         }
         if(this.rightbottomFlag)
         {
            this.rightbottom.render(param1);
         }
      }
   }
}
