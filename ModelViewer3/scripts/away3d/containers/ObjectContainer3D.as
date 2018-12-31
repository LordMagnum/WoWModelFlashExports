package away3d.containers
{
   import away3d.core.base.Mesh;
   import away3d.core.base.Object3D;
   import away3d.core.math.Number3D;
   import away3d.core.project.ProjectorType;
   import away3d.core.traverse.Traverser;
   import away3d.events.Object3DEvent;
   import away3d.loaders.data.MaterialData;
   import away3d.loaders.utils.MaterialLibrary;
   import §away3d:arcane§._boundingRadius;
   import §away3d:arcane§._boundingScale;
   import §away3d:arcane§._maxX;
   import §away3d:arcane§._maxY;
   import §away3d:arcane§._maxZ;
   import §away3d:arcane§._minX;
   import §away3d:arcane§._minY;
   import §away3d:arcane§._minZ;
   import §away3d:arcane§._scaleX;
   import §away3d:arcane§._scaleY;
   import §away3d:arcane§._scaleZ;
   import §away3d:arcane§._session;
   import §away3d:arcane§._sessionDirty;
   import §away3d:arcane§._transform;
   import §away3d:arcane§.notifyDimensionsChange;
   
   public class ObjectContainer3D extends Object3D
   {
       
      
      private var _radiusChild:Object3D = null;
      
      private var _children:Array;
      
      public function ObjectContainer3D(... rest)
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object3D = null;
         this._children = new Array();
         var _loc3_:Array = [];
         for each(_loc4_ in rest)
         {
            if(_loc4_ is Object3D)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc2_ = _loc4_;
            }
         }
         super(_loc2_);
         projectorType = ProjectorType.OBJECT_CONTAINER;
         for each(_loc5_ in _loc3_)
         {
            this.addChild(_loc5_);
         }
      }
      
      public function addChildren(... rest) : void
      {
         var _loc2_:Object3D = null;
         for each(_loc2_ in rest)
         {
            this.addChild(_loc2_);
         }
      }
      
      public function addChild(param1:Object3D) : void
      {
         if(param1 == null)
         {
            throw new Error("ObjectContainer3D.addChild(null)");
         }
         param1.parent = this;
      }
      
      override public function clone(param1:Object3D = null) : Object3D
      {
         var _loc3_:Object3D = null;
         var _loc2_:ObjectContainer3D = param1 as ObjectContainer3D || new ObjectContainer3D();
         super.clone(_loc2_);
         return _loc2_;
      }
      
      public function cloneAll(param1:Object3D = null) : Object3D
      {
         var _loc3_:ObjectContainer3D = null;
         var _loc4_:Object3D = null;
         var _loc6_:MaterialData = null;
         var _loc2_:ObjectContainer3D = param1 as ObjectContainer3D || new ObjectContainer3D();
         super.clone(_loc2_);
         for each(_loc4_ in this.children)
         {
            if(_loc4_ is ObjectContainer3D)
            {
               _loc3_ = new ObjectContainer3D();
               _loc2_.addChild(_loc3_);
               (_loc4_ as ObjectContainer3D).cloneAll(_loc3_);
            }
            else if(_loc4_ is Mesh)
            {
               _loc2_.addChild((_loc4_ as Mesh).cloneAll());
            }
            else
            {
               _loc2_.addChild(_loc4_.clone());
            }
         }
         if(materialLibrary)
         {
            _loc2_.materialLibrary = new MaterialLibrary();
            for each(_loc6_ in materialLibrary)
            {
               _loc6_.clone(_loc2_);
            }
         }
         var _loc5_:ObjectContainer3D = _loc2_;
         while(_loc5_.parent)
         {
            _loc5_ = _loc5_.parent;
         }
         return _loc2_;
      }
      
      public function removeChild(param1:Object3D) : void
      {
         if(param1 == null)
         {
            throw new Error("ObjectContainer3D.removeChild(null)");
         }
         if(param1.parent != this)
         {
            return;
         }
         param1.parent = null;
      }
      
      public function getChildByName(param1:String) : Object3D
      {
         var _loc2_:Object3D = null;
         var _loc3_:Object3D = null;
         for each(_loc3_ in this.children)
         {
            if(_loc3_.name)
            {
               if(_loc3_.name == param1)
               {
                  return _loc3_;
               }
            }
            if(_loc3_ is ObjectContainer3D)
            {
               _loc2_ = (_loc3_ as ObjectContainer3D).getChildByName(param1);
               if(_loc2_)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function onChildChange(param1:Object3DEvent) : void
      {
         notifyDimensionsChange();
      }
      
      override public function applyRotations() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc17_:Object3D = null;
         var _loc7_:Number = Math.PI / 180;
         var _loc8_:Number = rotationX * _loc7_;
         var _loc9_:Number = rotationY * _loc7_;
         var _loc10_:Number = rotationZ * _loc7_;
         var _loc11_:Number = Math.sin(_loc8_);
         var _loc12_:Number = Math.cos(_loc8_);
         var _loc13_:Number = Math.sin(_loc9_);
         var _loc14_:Number = Math.cos(_loc9_);
         var _loc15_:Number = Math.sin(_loc10_);
         var _loc16_:Number = Math.cos(_loc10_);
         for each(_loc17_ in this.children)
         {
            _loc1_ = _loc17_.x;
            _loc2_ = _loc17_.y;
            _loc3_ = _loc17_.z;
            _loc5_ = _loc2_;
            _loc2_ = _loc5_ * _loc12_ + _loc3_ * -_loc11_;
            _loc3_ = _loc5_ * _loc11_ + _loc3_ * _loc12_;
            _loc4_ = _loc1_;
            _loc1_ = _loc4_ * _loc14_ + _loc3_ * _loc13_;
            _loc3_ = _loc4_ * -_loc13_ + _loc3_ * _loc14_;
            _loc4_ = _loc1_;
            _loc1_ = _loc4_ * _loc16_ + _loc2_ * -_loc15_;
            _loc2_ = _loc4_ * _loc15_ + _loc2_ * _loc16_;
            _loc17_.moveTo(_loc1_,_loc2_,_loc3_);
         }
         rotationX = 0;
         rotationY = 0;
         rotationZ = 0;
      }
      
      override public function traverse(param1:Traverser) : void
      {
         var _loc2_:Object3D = null;
         if(param1.match(this))
         {
            param1.enter(this);
            param1.apply(this);
            for each(_loc2_ in this.children)
            {
               _loc2_.traverse(param1);
            }
            param1.leave(this);
         }
      }
      
      override protected function updateDimensions() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number3D = null;
         var _loc5_:Object3D = null;
         var _loc1_:Array = this._children.concat();
         if(_loc1_.length)
         {
            if(_scaleX < 0)
            {
               _boundingScale = -_scaleX;
            }
            else
            {
               _boundingScale = _scaleX;
            }
            if(_scaleY < 0 && _boundingScale < -_scaleY)
            {
               _boundingScale = -_scaleY;
            }
            else if(_boundingScale < _scaleY)
            {
               _boundingScale = _scaleY;
            }
            if(_scaleZ < 0 && _boundingScale < -_scaleZ)
            {
               _boundingScale = -_scaleZ;
            }
            else if(_boundingScale < _scaleZ)
            {
               _boundingScale = _scaleZ;
            }
            _loc2_ = 0;
            _loc4_ = new Number3D();
            for each(_loc5_ in _loc1_)
            {
               _loc4_.sub(_loc5_.position,_pivotPoint);
               _loc3_ = _loc4_.modulo + _loc5_.parentBoundingRadius;
               if(_loc2_ < _loc3_)
               {
                  _loc2_ = _loc3_;
               }
            }
            _boundingRadius = _loc2_;
            _loc1_.sortOn("parentmaxX",Array.DESCENDING | Array.NUMERIC);
            _maxX = _loc1_[0].parentmaxX;
            _loc1_.sortOn("parentminX",Array.NUMERIC);
            _minX = _loc1_[0].parentminX;
            _loc1_.sortOn("parentmaxY",Array.DESCENDING | Array.NUMERIC);
            _maxY = _loc1_[0].parentmaxY;
            _loc1_.sortOn("parentminY",Array.NUMERIC);
            _minY = _loc1_[0].parentminY;
            _loc1_.sortOn("parentmaxZ",Array.DESCENDING | Array.NUMERIC);
            _maxZ = _loc1_[0].parentmaxZ;
            _loc1_.sortOn("parentminZ",Array.NUMERIC);
            _minZ = _loc1_[0].parentminZ;
         }
         super.updateDimensions();
      }
      
      override public function applyPosition(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Object3D = null;
         var _loc8_:Number3D = null;
         for each(_loc7_ in this.children)
         {
            _loc4_ = _loc7_.x;
            _loc5_ = _loc7_.y;
            _loc6_ = _loc7_.z;
            _loc7_.moveTo(_loc4_ - param1,_loc5_ - param2,_loc6_ - param3);
         }
         _loc8_ = new Number3D(param1,param2,param3);
         _loc8_.rotate(_loc8_,_transform);
         _loc8_.add(_loc8_,position);
         moveTo(_loc8_.x,_loc8_.y,_loc8_.z);
      }
      
      function internalAddChild(param1:Object3D) : void
      {
         this._children.push(param1);
         param1.addOnTransformChange(this.onChildChange);
         param1.addOnDimensionsChange(this.onChildChange);
         notifyDimensionsChange();
         if(_session && !param1.ownCanvas)
         {
            session.internalAddOwnSession(param1);
         }
         _sessionDirty = true;
      }
      
      public function removeChildByName(param1:String) : void
      {
         this.removeChild(this.getChildByName(param1));
      }
      
      function internalRemoveChild(param1:Object3D) : void
      {
         var _loc2_:int = this.children.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         param1.removeOnTransformChange(this.onChildChange);
         param1.removeOnDimensionsChange(this.onChildChange);
         this._children.splice(_loc2_,1);
         notifyDimensionsChange();
         if(session && !param1.ownCanvas)
         {
            session.internalRemoveOwnSession(param1);
         }
         _sessionDirty = true;
      }
      
      public function get children() : Array
      {
         return this._children;
      }
   }
}
