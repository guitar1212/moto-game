package com.loma.game.background
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @long  Aug 28, 2014
	 * 
	 */	
	public class GameBackground extends Sprite
	{
		private var m_unitWidth:Number = 700;
		
		private var m_moveSpeed:Number = 6;
		
		private var m_roadOriNumChildern:int = 0;
		
		private var m_leftBound:int = 0;
		
		private var m_platform:Sprite = new Sprite();
		
		private var m_roadArr:Array = [];
		
		private var m_skyArr:Array = [];
		
		private var m_appendArr:Array = [];
		
		private var m_count:int = 0;
		
		public function GameBackground()
		{
			super();
			
			this.addChild(m_platform);
			
			var s:House = new House();
			var s1:House = new House();
			var s2:House = new House();
			m_skyArr.push(s);
			m_skyArr.push(s1);
			m_skyArr.push(s2);
			
			m_platform.addChild(s);
			m_platform.addChild(s1);
			m_platform.addChild(s2);
			
			s1.x += m_unitWidth;
			s2.x += m_unitWidth*2;
			
			var a:RoadNormal = new RoadNormal();
			var b:RoadNormal = new RoadNormal(); 
			var c:RoadNormal = new RoadNormal();
			m_roadOriNumChildern = a.numChildren;
			
			m_roadArr.push(a);
			m_roadArr.push(b);
			m_roadArr.push(c);
			
			m_platform.addChild(a);
			m_platform.addChild(b);
			m_platform.addChild(c);
			
			b.x += m_unitWidth;
			c.x += m_unitWidth*2;
			
			m_leftBound = -m_unitWidth*1.1;
		}
		
		public function update():void
		{
			moveingRoad(m_moveSpeed*0.35);
			
			moveingSky(m_moveSpeed*0.1);
			
			checkBackground();
		}
		
		private function moveingSky(moveSpeed:Number):void
		{
			for(var i:int = 0; i < m_skyArr.length; i++)
			{
				m_skyArr[i].x -= moveSpeed;
			}
		}
		
		private function moveingRoad(moveSpeed:Number):void
		{
			for(var i:int = 0; i < m_roadArr.length; i++)
			{
				m_roadArr[i].x -= moveSpeed;
			}
			
			for(var j:int = 0; j < m_appendArr.length; j++)
			{
				var d:Object = m_appendArr[j];
				var o:Object = d.o;
				o.x = d.p.x + d.x;
				o.y = d.p.y + d.y; 
			}
		}
		
		private function checkBackground():void
		{			
			var r:RoadNormal = m_roadArr[0];
			
			if(r.x < m_leftBound)
			{
				m_roadArr.shift();
				m_roadArr.push(r);
				r.x = m_roadArr[1].x + m_unitWidth;
				
				removeAllChild(r);
				
				m_count++;
				
				if(m_count%3 == 0)
				{
					this.addObject(2, new Warning1(), 330, 220);
				}
			}
			
			var s:House = m_skyArr[0];
			if(s.x < m_leftBound)
			{
				m_skyArr.shift();
				m_skyArr.push(s);
				s.x = m_skyArr[1].x + m_unitWidth;
				
				removeAllChild(s);
			}
		}
		
		private function removeAllChild(r:DisplayObjectContainer):void
		{			
			for(var i:int = r.numChildren - 1; i >= m_roadOriNumChildern; i--)
			{
				r.removeChildAt(i);
			}
		}
		
		public function get moveSpeed():Number
		{
			return m_moveSpeed;
		}

		public function set moveSpeed(value:Number):void
		{
			m_moveSpeed = value;
		}
		  
		/**
		 * 
		 * @param index
		 * @param obj
		 * @param x
		 * @param y
		 * 
		 */		
		public function addObject(index:int, obj:DisplayObject, x:int, y:int):void
		{
			var r:RoadNormal = m_roadArr[index];
			if(r)
			{
				r.addChild(obj);
				obj.x = x;
				obj.y = y;
			}
		}
		
		/**
		 *	 
		 * @param index
		 * @param obj
		 * @param x
		 * @param y
		 * 
		 */		
		public function append(index:int, obj:DisplayObject, x:int, y:int):void
		{
			var r:RoadNormal = m_roadArr[index];
			m_appendArr.push({p:r, o:obj, x:x, y:y});
		}
		
		public function removeApped(obj:DisplayObject):void
		{
			for(var i:int = 0; i < m_appendArr.length; i++)
			{
				if(obj == m_appendArr[i].o)
				{
					m_appendArr.splice(i, 1);
					return;
				}
			}
		}

	}
}