package away3d.core.filter
{
   import away3d.cameras.Camera3D;
   import away3d.containers.Scene3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.DrawScaledBitmap;
   import away3d.core.draw.DrawSegment;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.render.QuadrantRenderer;
   import flash.utils.getTimer;
   
   public class AnotherRivalFilter implements IPrimitiveQuadrantFilter
   {
       
      
      private var q20w01:Boolean;
      
      private var ql20c:Number;
      
      private var ZOrderHigher:int = -1;
      
      private var q12rd:Number;
      
      private var maxdeltaZ:Number;
      
      private var q20w12:Boolean;
      
      private var part:DrawPrimitive;
      
      private var q01w01x:Number;
      
      private var wl12q0:Number;
      
      private var wl12q1:Number;
      
      private var wl12q2:Number;
      
      private var q12rx:Number;
      
      private var q12ry:Number;
      
      private var q12w01y:Number;
      
      private var q01ry:Number;
      
      private var q12w12x:Number;
      
      private var q01w01y:Number;
      
      private var ql20w2:Number;
      
      private var q20w20:Boolean;
      
      private var rivals:Array;
      
      private var q12w01x:Number;
      
      private var q12w01d:Number;
      
      private var q12w12y:Number;
      
      private var r0x:Number;
      
      private var r0y:Number;
      
      private var az:Number;
      
      private var q12w12d:Number;
      
      private var minZ:Number;
      
      private var bz:Number;
      
      private var r1x:Number;
      
      private var r1y:Number;
      
      private var ql01r1:Number;
      
      private var q12r:Boolean;
      
      private var ql01r0:Number;
      
      private var start:int;
      
      private var ql12a:Number;
      
      private var ql12b:Number;
      
      private var ql12c:Number;
      
      private var primitives:Array;
      
      private var cx:Number;
      
      private var ql12s:Number;
      
      private var q0x:Number;
      
      private var q0y:Number;
      
      private var ql12r1:Number;
      
      private var turn:int;
      
      private var q01r:Boolean;
      
      private var ql12r0:Number;
      
      private var ql01a:Number;
      
      private var ql01b:Number;
      
      private var ql01c:Number;
      
      private var cy:Number;
      
      private var ql01s:Number;
      
      private var q1x:Number;
      
      private var q1y:Number;
      
      private var maxdelay:int;
      
      private var pri:DrawPrimitive;
      
      private var q2x:Number;
      
      private var q2y:Number;
      
      private var ZOrderDeeper:int = 1;
      
      private var parts:Array;
      
      private var q20rd:Number;
      
      private var wl20a:Number;
      
      private var wl20b:Number;
      
      private var wl20c:Number;
      
      private var wl20q0:Number;
      
      private var wl20q1:Number;
      
      private var ql01w1:Number;
      
      private var ql01w2:Number;
      
      private var ZOrderIrrelevant:int = 0;
      
      private var q20rx:Number;
      
      private var q20w20d:Number;
      
      private var w0x:Number;
      
      private var ql01w0:Number;
      
      private var q20ry:Number;
      
      private var w0y:Number;
      
      private var check:int;
      
      private var count:int;
      
      private var q20w20x:Number;
      
      private var q20w20y:Number;
      
      private var ql12w0:Number;
      
      private var ql12w1:Number;
      
      private var ql12w2:Number;
      
      private var w1x:Number;
      
      private var w1y:Number;
      
      private var wl20q2:Number;
      
      private var wl20s:Number;
      
      private var q12w01:Boolean;
      
      private var w2x:Number;
      
      private var q01w20d:Number;
      
      private var w2y:Number;
      
      private var q01w01:Boolean;
      
      private var q12w12:Boolean;
      
      private var q01w20x:Number;
      
      private var q01w20y:Number;
      
      private var ql20r0:Number;
      
      private var ql20r1:Number;
      
      private var leftover:Array;
      
      private var q12w20d:Number;
      
      private var q12w20:Boolean;
      
      private var q01w12:Boolean;
      
      private var rla:Number;
      
      private var rlb:Number;
      
      private var rlc:Number;
      
      private var wl12a:Number;
      
      private var wl12b:Number;
      
      private var wl12c:Number;
      
      private var q12w20x:Number;
      
      private var maxZ:Number;
      
      private var q20w12d:Number;
      
      private var wl12s:Number;
      
      private var q01w20:Boolean;
      
      private var q12w20y:Number;
      
      private var rival:DrawPrimitive;
      
      private var wl01a:Number;
      
      private var wl01b:Number;
      
      private var wl01c:Number;
      
      private var q20w12x:Number;
      
      private var q20w12y:Number;
      
      private var rlq0:Number;
      
      private var rlq2:Number;
      
      private var wl01s:Number;
      
      private var ZOrderSame:int = 0;
      
      private var q20w01d:Number;
      
      private var rlq1:Number;
      
      private var q20w01x:Number;
      
      private var q20w01y:Number;
      
      private var q01w12d:Number;
      
      private var q01w12y:Number;
      
      private var q01w12x:Number;
      
      private var q20r:Boolean;
      
      private var q01w01d:Number;
      
      private var ql20a:Number;
      
      private var ql20b:Number;
      
      private var q01rd:Number;
      
      private var ql20w1:Number;
      
      private var wl01q1:Number;
      
      private var wl01q2:Number;
      
      private var q01rx:Number;
      
      private var ql20w0:Number;
      
      private var ql20s:Number;
      
      private var wl01q0:Number;
      
      public function AnotherRivalFilter(param1:int = 60000)
      {
         super();
         this.maxdelay = param1;
      }
      
      private function zconflict(param1:DrawPrimitive, param2:DrawPrimitive) : int
      {
         if(param1 is DrawTriangle)
         {
            if(param2 is DrawTriangle)
            {
               return this.zconflictTT(param1 as DrawTriangle,param2 as DrawTriangle);
            }
            if(param2 is DrawSegment)
            {
               return this.zconflictTS(param1 as DrawTriangle,param2 as DrawSegment);
            }
            if(param1 is DrawScaledBitmap)
            {
               return this.zconflictTB(param1 as DrawTriangle,param2 as DrawScaledBitmap);
            }
         }
         else if(param1 is DrawSegment)
         {
            if(param2 is DrawTriangle)
            {
               return -this.zconflictTS(param2 as DrawTriangle,param1 as DrawSegment);
            }
         }
         else if(param1 is DrawScaledBitmap)
         {
            if(param2 is DrawTriangle)
            {
               return -this.zconflictTB(param2 as DrawTriangle,param1 as DrawScaledBitmap);
            }
            if(param2 is DrawScaledBitmap)
            {
               return this.zconflictBB(param1 as DrawScaledBitmap,param2 as DrawScaledBitmap);
            }
         }
         return this.ZOrderIrrelevant;
      }
      
      public function toString() : String
      {
         return "AnotherRivalFilter" + (this.maxdelay == 60000?"":"(" + this.maxdelay + "ms)");
      }
      
      private function zcompare(param1:DrawPrimitive, param2:DrawPrimitive, param3:Number, param4:Number) : int
      {
         this.az = param1.getZ(param3,param4);
         this.bz = param2.getZ(param3,param4);
         if(this.az > this.bz)
         {
            return this.ZOrderDeeper;
         }
         if(this.az < this.bz)
         {
            return this.ZOrderHigher;
         }
         return this.ZOrderSame;
      }
      
      public function filter(param1:QuadrantRenderer, param2:Scene3D, param3:Camera3D, param4:Clipping) : void
      {
         this.start = getTimer();
         this.check = 0;
         this.primitives = param1.list();
         this.turn = 0;
         while(this.primitives.length > 0)
         {
            this.leftover = new Array();
            for each(this.pri in this.primitives)
            {
               this.check++;
               if(this.check == 10)
               {
                  if(getTimer() - this.start > this.maxdelay)
                  {
                     return;
                  }
                  this.check = 0;
               }
               this.maxZ = this.pri.maxZ + 1000;
               this.minZ = this.pri.minZ - 1000;
               this.maxdeltaZ = 0;
               this.rivals = param1.get(this.pri);
               for each(this.rival in this.rivals)
               {
                  if(this.rival == this.pri)
                  {
                     continue;
                  }
                  switch(this.zconflict(this.pri,this.rival))
                  {
                     case this.ZOrderIrrelevant:
                        continue;
                     case this.ZOrderDeeper:
                        if(this.minZ < this.rival.screenZ)
                        {
                           this.minZ = this.rival.screenZ;
                        }
                        continue;
                     case this.ZOrderHigher:
                        if(this.maxZ > this.rival.screenZ)
                        {
                           this.maxZ = this.rival.screenZ;
                        }
                        continue;
                     default:
                        continue;
                  }
               }
               if(!(this.maxZ >= this.pri.screenZ && this.pri.screenZ >= this.minZ))
               {
                  if(this.maxZ >= this.minZ)
                  {
                     this.pri.screenZ = (this.maxZ + this.minZ) / 2;
                  }
                  else if(this.turn % 3 == 2)
                  {
                     this.parts = this.pri.quarter(param3.focus);
                     if(this.parts != null)
                     {
                        param1.remove(this.pri);
                        for each(this.part in this.parts)
                        {
                           if(param1.primitive(this.part))
                           {
                              this.leftover.push(this.part);
                           }
                        }
                     }
                  }
                  else
                  {
                     this.leftover.push(this.pri);
                  }
               }
            }
            this.primitives = this.leftover;
            this.turn = this.turn + 1;
            if(this.turn == 20)
            {
               break;
            }
         }
      }
      
      private function zconflictBB(param1:DrawScaledBitmap, param2:DrawScaledBitmap) : int
      {
         if(param1.screenZ > param2.screenZ)
         {
            return this.ZOrderDeeper;
         }
         if(param1.screenZ < param2.screenZ)
         {
            return this.ZOrderHigher;
         }
         return this.ZOrderSame;
      }
      
      private function zconflictTB(param1:DrawTriangle, param2:DrawScaledBitmap) : int
      {
         if(param1.contains(param2.screenvertex.x,param2.screenvertex.y))
         {
            return this.zcompare(param1,param2,param2.screenvertex.x,param2.screenvertex.y);
         }
         if(param1.contains(param2.minX,param2.minY))
         {
            return this.zcompare(param1,param2,param2.minX,param2.minY);
         }
         if(param1.contains(param2.minX,param2.maxY))
         {
            return this.zcompare(param1,param2,param2.minX,param2.maxY);
         }
         if(param1.contains(param2.maxX,param2.minY))
         {
            return this.zcompare(param1,param2,param2.maxX,param2.minY);
         }
         if(param1.contains(param2.maxX,param2.maxY))
         {
            return this.zcompare(param1,param2,param2.maxX,param2.maxY);
         }
         return this.ZOrderIrrelevant;
      }
      
      private function zconflictTS(param1:DrawTriangle, param2:DrawSegment) : int
      {
         this.q0x = param1.v0.x;
         this.q0y = param1.v0.y;
         this.q1x = param1.v1.x;
         this.q1y = param1.v1.y;
         this.q2x = param1.v2.x;
         this.q2y = param1.v2.y;
         this.r0x = param2.v0.x;
         this.r0y = param2.v0.y;
         this.r1x = param2.v1.x;
         this.r1y = param2.v1.y;
         this.ql01a = this.q1y - this.q0y;
         this.ql01b = this.q0x - this.q1x;
         this.ql01c = -(this.ql01b * this.q0y + this.ql01a * this.q0x);
         this.ql01s = this.ql01a * this.q2x + this.ql01b * this.q2y + this.ql01c;
         this.ql01r0 = (this.ql01a * this.r0x + this.ql01b * this.r0y + this.ql01c) * this.ql01s;
         this.ql01r1 = (this.ql01a * this.r1x + this.ql01b * this.r1y + this.ql01c) * this.ql01s;
         if(this.ql01r0 <= 0.0001 && this.ql01r1 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.ql12a = this.q2y - this.q1y;
         this.ql12b = this.q1x - this.q2x;
         this.ql12c = -(this.ql12b * this.q1y + this.ql12a * this.q1x);
         this.ql12s = this.ql12a * this.q0x + this.ql12b * this.q0y + this.ql12c;
         this.ql12r0 = (this.ql12a * this.r0x + this.ql12b * this.r0y + this.ql12c) * this.ql12s;
         this.ql12r1 = (this.ql12a * this.r1x + this.ql12b * this.r1y + this.ql12c) * this.ql12s;
         if(this.ql12r0 <= 0.0001 && this.ql12r1 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.ql20a = this.q0y - this.q2y;
         this.ql20b = this.q2x - this.q0x;
         this.ql20c = -(this.ql20b * this.q2y + this.ql20a * this.q2x);
         this.ql20s = this.ql20a * this.q1x + this.ql20b * this.q1y + this.ql20c;
         this.ql20r0 = (this.ql20a * this.r0x + this.ql20b * this.r0y + this.ql20c) * this.ql20s;
         this.ql20r1 = (this.ql20a * this.r1x + this.ql20b * this.r1y + this.ql20c) * this.ql20s;
         if(this.ql20r0 <= 0.0001 && this.ql20r1 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.rla = this.r1y - this.r0y;
         this.rlb = this.r0x - this.r1x;
         this.rlc = -(this.rlb * this.r0y + this.rla * this.r0x);
         this.rlq0 = this.rla * this.q0x + this.rlb * this.q0y + this.rlc;
         this.rlq1 = this.rla * this.q1x + this.rlb * this.q1y + this.rlc;
         this.rlq2 = this.rla * this.q2x + this.rlb * this.q2y + this.rlc;
         if(this.rlq0 * this.rlq1 >= 0.0001 && this.rlq1 * this.rlq2 >= 0.0001 && this.rlq2 * this.rlq0 >= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         if(this.ql01r0 > -0.0001 && this.ql12r0 > -0.0001 && this.ql20r0 > -0.0001 && (this.ql01r1 > -0.0001 && this.ql12r1 > -0.0001 && this.ql20r1 > -0.0001))
         {
            return this.zcompare(param1,param2,(this.r0x + this.r1x) / 2,(this.r0y + this.r1y) / 2);
         }
         this.q01r = this.rlq0 * this.rlq1 < 0.0001 && this.ql01r0 * this.ql01r1 < 0.0001;
         this.q12r = this.rlq1 * this.rlq2 < 0.0001 && this.ql12r0 * this.ql12r1 < 0.0001;
         this.q20r = this.rlq2 * this.rlq0 < 0.0001 && this.ql20r0 * this.ql20r1 < 0.0001;
         this.count = 0;
         this.cx = 0;
         this.cy = 0;
         if(this.ql01r0 > 0.0001 && this.ql12r0 > 0.0001 && this.ql20r0 > 0.0001)
         {
            this.cx = this.cx + this.r0x;
            this.cy = this.cy + this.r0y;
            this.count = this.count + 1;
         }
         if(this.ql01r1 > 0.0001 && this.ql12r1 > 0.0001 && this.ql20r1 > 0.0001)
         {
            this.cx = this.cx + this.r1x;
            this.cy = this.cy + this.r1y;
            this.count = this.count + 1;
         }
         if(this.q01r)
         {
            this.q01rd = this.ql01a * this.rlb - this.ql01b * this.rla;
            if(this.q01rd * this.q01rd > 0.0001)
            {
               this.q01rx = (this.ql01b * this.rlc - this.ql01c * this.rlb) / this.q01rd;
               this.q01ry = (this.ql01c * this.rla - this.ql01a * this.rlc) / this.q01rd;
               this.cx = this.cx + this.q01rx;
               this.cy = this.cy + this.q01ry;
               this.count = this.count + 1;
            }
         }
         if(this.q12r)
         {
            this.q12rd = this.ql12a * this.rlb - this.ql12b * this.rla;
            if(this.q12rd * this.q12rd > 0.0001)
            {
               this.q12rx = (this.ql12b * this.rlc - this.ql12c * this.rlb) / this.q12rd;
               this.q12ry = (this.ql12c * this.rla - this.ql12a * this.rlc) / this.q12rd;
               this.cx = this.cx + this.q12rx;
               this.cy = this.cy + this.q12ry;
               this.count = this.count + 1;
            }
         }
         if(this.q20r)
         {
            this.q20rd = this.ql20a * this.rlb - this.ql20b * this.rla;
            if(this.q20rd * this.q20rd > 0.0001)
            {
               this.q20rx = (this.ql20b * this.rlc - this.ql20c * this.rlb) / this.q20rd;
               this.q20ry = (this.ql20c * this.rla - this.ql20a * this.rlc) / this.q20rd;
               this.cx = this.cx + this.q20rx;
               this.cy = this.cy + this.q20ry;
               this.count = this.count + 1;
            }
         }
         return this.zcompare(param1,param2,this.cx / this.count,this.cy / this.count);
      }
      
      private function zconflictTT(param1:DrawTriangle, param2:DrawTriangle) : int
      {
         this.q0x = param1.v0.x;
         this.q0y = param1.v0.y;
         this.q1x = param1.v1.x;
         this.q1y = param1.v1.y;
         this.q2x = param1.v2.x;
         this.q2y = param1.v2.y;
         this.w0x = param2.v0.x;
         this.w0y = param2.v0.y;
         this.w1x = param2.v1.x;
         this.w1y = param2.v1.y;
         this.w2x = param2.v2.x;
         this.w2y = param2.v2.y;
         this.ql01a = this.q1y - this.q0y;
         this.ql01b = this.q0x - this.q1x;
         this.ql01c = -(this.ql01b * this.q0y + this.ql01a * this.q0x);
         this.ql01s = this.ql01a * this.q2x + this.ql01b * this.q2y + this.ql01c;
         this.ql01w0 = (this.ql01a * this.w0x + this.ql01b * this.w0y + this.ql01c) * this.ql01s;
         this.ql01w1 = (this.ql01a * this.w1x + this.ql01b * this.w1y + this.ql01c) * this.ql01s;
         this.ql01w2 = (this.ql01a * this.w2x + this.ql01b * this.w2y + this.ql01c) * this.ql01s;
         if(this.ql01w0 <= 0.0001 && this.ql01w1 <= 0.0001 && this.ql01w2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.ql12a = this.q2y - this.q1y;
         this.ql12b = this.q1x - this.q2x;
         this.ql12c = -(this.ql12b * this.q1y + this.ql12a * this.q1x);
         this.ql12s = this.ql12a * this.q0x + this.ql12b * this.q0y + this.ql12c;
         this.ql12w0 = (this.ql12a * this.w0x + this.ql12b * this.w0y + this.ql12c) * this.ql12s;
         this.ql12w1 = (this.ql12a * this.w1x + this.ql12b * this.w1y + this.ql12c) * this.ql12s;
         this.ql12w2 = (this.ql12a * this.w2x + this.ql12b * this.w2y + this.ql12c) * this.ql12s;
         if(this.ql12w0 <= 0.0001 && this.ql12w1 <= 0.0001 && this.ql12w2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.ql20a = this.q0y - this.q2y;
         this.ql20b = this.q2x - this.q0x;
         this.ql20c = -(this.ql20b * this.q2y + this.ql20a * this.q2x);
         this.ql20s = this.ql20a * this.q1x + this.ql20b * this.q1y + this.ql20c;
         this.ql20w0 = (this.ql20a * this.w0x + this.ql20b * this.w0y + this.ql20c) * this.ql20s;
         this.ql20w1 = (this.ql20a * this.w1x + this.ql20b * this.w1y + this.ql20c) * this.ql20s;
         this.ql20w2 = (this.ql20a * this.w2x + this.ql20b * this.w2y + this.ql20c) * this.ql20s;
         if(this.ql20w0 <= 0.0001 && this.ql20w1 <= 0.0001 && this.ql20w2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.wl01a = this.w1y - this.w0y;
         this.wl01b = this.w0x - this.w1x;
         this.wl01c = -(this.wl01b * this.w0y + this.wl01a * this.w0x);
         this.wl01s = this.wl01a * this.w2x + this.wl01b * this.w2y + this.wl01c;
         this.wl01q0 = (this.wl01a * this.q0x + this.wl01b * this.q0y + this.wl01c) * this.wl01s;
         this.wl01q1 = (this.wl01a * this.q1x + this.wl01b * this.q1y + this.wl01c) * this.wl01s;
         this.wl01q2 = (this.wl01a * this.q2x + this.wl01b * this.q2y + this.wl01c) * this.wl01s;
         if(this.wl01q0 <= 0.0001 && this.wl01q1 <= 0.0001 && this.wl01q2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.wl12a = this.w2y - this.w1y;
         this.wl12b = this.w1x - this.w2x;
         this.wl12c = -(this.wl12b * this.w1y + this.wl12a * this.w1x);
         this.wl12s = this.wl12a * this.w0x + this.wl12b * this.w0y + this.wl12c;
         this.wl12q0 = (this.wl12a * this.q0x + this.wl12b * this.q0y + this.wl12c) * this.wl12s;
         this.wl12q1 = (this.wl12a * this.q1x + this.wl12b * this.q1y + this.wl12c) * this.wl12s;
         this.wl12q2 = (this.wl12a * this.q2x + this.wl12b * this.q2y + this.wl12c) * this.wl12s;
         if(this.wl12q0 <= 0.0001 && this.wl12q1 <= 0.0001 && this.wl12q2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         this.wl20a = this.w0y - this.w2y;
         this.wl20b = this.w2x - this.w0x;
         this.wl20c = -(this.wl20b * this.w2y + this.wl20a * this.w2x);
         this.wl20s = this.wl20a * this.w1x + this.wl20b * this.w1y + this.wl20c;
         this.wl20q0 = (this.wl20a * this.q0x + this.wl20b * this.q0y + this.wl20c) * this.wl20s;
         this.wl20q1 = (this.wl20a * this.q1x + this.wl20b * this.q1y + this.wl20c) * this.wl20s;
         this.wl20q2 = (this.wl20a * this.q2x + this.wl20b * this.q2y + this.wl20c) * this.wl20s;
         if(this.wl20q0 <= 0.0001 && this.wl20q1 <= 0.0001 && this.wl20q2 <= 0.0001)
         {
            return this.ZOrderIrrelevant;
         }
         if((this.wl01q0 * this.wl01q0 <= 0.0001 || this.wl12q0 * this.wl12q0 <= 0.0001 || this.wl20q0 * this.wl20q0 <= 0.0001) && (this.wl01q1 * this.wl01q1 <= 0.0001 || this.wl12q1 * this.wl12q1 <= 0.0001 || this.wl20q1 * this.wl20q1 <= 0.0001) && (this.wl01q2 * this.wl01q2 <= 0.0001 || this.wl12q2 * this.wl12q2 <= 0.0001 || this.wl20q2 * this.wl20q2 <= 0.0001))
         {
            return this.zcompare(param1,param2,(this.q0x + this.q1x + this.q2x) / 3,(this.q0y + this.q1y + this.q2y) / 3);
         }
         if((this.ql01w0 * this.ql01w0 <= 0.0001 || this.ql12w0 * this.ql12w0 <= 0.0001 || this.ql20w0 * this.ql20w0 <= 0.0001) && (this.ql01w1 * this.ql01w1 <= 0.0001 || this.ql12w1 * this.ql12w1 <= 0.0001 || this.ql20w1 * this.ql20w1 <= 0.0001) && (this.ql01w2 * this.ql01w2 <= 0.0001 || this.ql12w2 * this.ql12w2 <= 0.0001 || this.ql20w2 * this.ql20w2 <= 0.0001))
         {
            return this.zcompare(param1,param2,(this.w0x + this.w1x + this.w2x) / 3,(this.w0y + this.w1y + this.w2y) / 3);
         }
         this.q01w01 = this.wl01q0 * this.wl01q1 < 0.0001 && this.ql01w0 * this.ql01w1 < 0.0001;
         this.q12w01 = this.wl01q1 * this.wl01q2 < 0.0001 && this.ql12w0 * this.ql12w1 < 0.0001;
         this.q20w01 = this.wl01q2 * this.wl01q0 < 0.0001 && this.ql20w0 * this.ql20w1 < 0.0001;
         this.q01w12 = this.wl12q0 * this.wl12q1 < 0.0001 && this.ql01w1 * this.ql01w2 < 0.0001;
         this.q12w12 = this.wl12q1 * this.wl12q2 < 0.0001 && this.ql12w1 * this.ql12w2 < 0.0001;
         this.q20w12 = this.wl12q2 * this.wl12q0 < 0.0001 && this.ql20w1 * this.ql20w2 < 0.0001;
         this.q01w20 = this.wl20q0 * this.wl20q1 < 0.0001 && this.ql01w2 * this.ql01w0 < 0.0001;
         this.q12w20 = this.wl20q1 * this.wl20q2 < 0.0001 && this.ql12w2 * this.ql12w0 < 0.0001;
         this.q20w20 = this.wl20q2 * this.wl20q0 < 0.0001 && this.ql20w2 * this.ql20w0 < 0.0001;
         this.count = 0;
         this.cx = 0;
         this.cy = 0;
         if(this.ql01w0 > 0.0001 && this.ql12w0 > 0.0001 && this.ql20w0 > 0.0001)
         {
            this.cx = this.cx + this.w0x;
            this.cy = this.cy + this.w0y;
            this.count = this.count + 1;
         }
         if(this.ql01w1 > 0.0001 && this.ql12w1 > 0.0001 && this.ql20w1 > 0.0001)
         {
            this.cx = this.cx + this.w1x;
            this.cy = this.cy + this.w1y;
            this.count = this.count + 1;
         }
         if(this.ql01w2 > 0.0001 && this.ql12w2 > 0.0001 && this.ql20w2 > 0.0001)
         {
            this.cx = this.cx + this.w2x;
            this.cy = this.cy + this.w2y;
            this.count = this.count + 1;
         }
         if(this.wl01q0 > 0.0001 && this.wl12q0 > 0.0001 && this.wl20q0 > 0.0001)
         {
            this.cx = this.cx + this.q0x;
            this.cy = this.cy + this.q0y;
            this.count = this.count + 1;
         }
         if(this.wl01q1 > 0.0001 && this.wl12q1 > 0.0001 && this.wl20q1 > 0.0001)
         {
            this.cx = this.cx + this.q1x;
            this.cy = this.cy + this.q1y;
            this.count = this.count + 1;
         }
         if(this.wl01q2 > 0.0001 && this.wl12q2 > 0.0001 && this.wl20q2 > 0.0001)
         {
            this.cx = this.cx + this.q2x;
            this.cy = this.cy + this.q2y;
            this.count = this.count + 1;
         }
         if(this.q01w01)
         {
            this.q01w01d = this.ql01a * this.wl01b - this.ql01b * this.wl01a;
            if(this.q01w01d * this.q01w01d > 0.0001)
            {
               this.q01w01x = (this.ql01b * this.wl01c - this.ql01c * this.wl01b) / this.q01w01d;
               this.q01w01y = (this.ql01c * this.wl01a - this.ql01a * this.wl01c) / this.q01w01d;
               this.cx = this.cx + this.q01w01x;
               this.cy = this.cy + this.q01w01y;
               this.count = this.count + 1;
            }
         }
         if(this.q12w01)
         {
            this.q12w01d = this.ql12a * this.wl01b - this.ql12b * this.wl01a;
            if(this.q12w01d * this.q12w01d > 0.0001)
            {
               this.q12w01x = (this.ql12b * this.wl01c - this.ql12c * this.wl01b) / this.q12w01d;
               this.q12w01y = (this.ql12c * this.wl01a - this.ql12a * this.wl01c) / this.q12w01d;
               this.cx = this.cx + this.q12w01x;
               this.cy = this.cy + this.q12w01y;
               this.count = this.count + 1;
            }
         }
         if(this.q20w01)
         {
            this.q20w01d = this.ql20a * this.wl01b - this.ql20b * this.wl01a;
            if(this.q20w01d * this.q20w01d > 0.0001)
            {
               this.q20w01x = (this.ql20b * this.wl01c - this.ql20c * this.wl01b) / this.q20w01d;
               this.q20w01y = (this.ql20c * this.wl01a - this.ql20a * this.wl01c) / this.q20w01d;
               this.cx = this.cx + this.q20w01x;
               this.cy = this.cy + this.q20w01y;
               this.count = this.count + 1;
            }
         }
         if(this.q01w12)
         {
            this.q01w12d = this.ql01a * this.wl12b - this.ql01b * this.wl12a;
            if(this.q01w12d * this.q01w12d > 0.0001)
            {
               this.q01w12x = (this.ql01b * this.wl12c - this.ql01c * this.wl12b) / this.q01w12d;
               this.q01w12y = (this.ql01c * this.wl12a - this.ql01a * this.wl12c) / this.q01w12d;
               this.cx = this.cx + this.q01w12x;
               this.cy = this.cy + this.q01w12y;
               this.count = this.count + 1;
            }
         }
         if(this.q12w12)
         {
            this.q12w12d = this.ql12a * this.wl12b - this.ql12b * this.wl12a;
            if(this.q12w12d * this.q12w12d > 0.0001)
            {
               this.q12w12x = (this.ql12b * this.wl12c - this.ql12c * this.wl12b) / this.q12w12d;
               this.q12w12y = (this.ql12c * this.wl12a - this.ql12a * this.wl12c) / this.q12w12d;
               this.cx = this.cx + this.q12w12x;
               this.cy = this.cy + this.q12w12y;
               this.count = this.count + 1;
            }
         }
         if(this.q20w12)
         {
            this.q20w12d = this.ql20a * this.wl12b - this.ql20b * this.wl12a;
            if(this.q20w12d * this.q20w12d > 0.0001)
            {
               this.q20w12x = (this.ql20b * this.wl12c - this.ql20c * this.wl12b) / this.q20w12d;
               this.q20w12y = (this.ql20c * this.wl12a - this.ql20a * this.wl12c) / this.q20w12d;
               this.cx = this.cx + this.q20w12x;
               this.cy = this.cy + this.q20w12y;
               this.count = this.count + 1;
            }
         }
         if(this.q01w20)
         {
            this.q01w20d = this.ql01a * this.wl20b - this.ql01b * this.wl20a;
            if(this.q01w20d * this.q01w20d > 0.0001)
            {
               this.q01w20x = (this.ql01b * this.wl20c - this.ql01c * this.wl20b) / this.q01w20d;
               this.q01w20y = (this.ql01c * this.wl20a - this.ql01a * this.wl20c) / this.q01w20d;
               this.cx = this.cx + this.q01w20x;
               this.cy = this.cy + this.q01w20y;
               this.count = this.count + 1;
            }
         }
         if(this.q12w20)
         {
            this.q12w20d = this.ql12a * this.wl20b - this.ql12b * this.wl20a;
            if(this.q12w20d * this.q12w20d > 0.0001)
            {
               this.q12w20x = (this.ql12b * this.wl20c - this.ql12c * this.wl20b) / this.q12w20d;
               this.q12w20y = (this.ql12c * this.wl20a - this.ql12a * this.wl20c) / this.q12w20d;
               this.cx = this.cx + this.q12w20x;
               this.cy = this.cy + this.q12w20y;
               this.count = this.count + 1;
            }
         }
         if(this.q20w20)
         {
            this.q20w20d = this.ql20a * this.wl20b - this.ql20b * this.wl20a;
            if(this.q20w20d * this.q20w20d > 0.0001)
            {
               this.q20w20x = (this.ql20b * this.wl20c - this.ql20c * this.wl20b) / this.q20w20d;
               this.q20w20y = (this.ql20c * this.wl20a - this.ql20a * this.wl20c) / this.q20w20d;
               this.cx = this.cx + this.q20w20x;
               this.cy = this.cy + this.q20w20y;
               this.count = this.count + 1;
            }
         }
         return this.zcompare(param1,param2,this.cx / this.count,this.cy / this.count);
      }
   }
}
