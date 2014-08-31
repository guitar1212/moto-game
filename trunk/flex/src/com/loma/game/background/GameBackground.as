package com.loma.game.background
{
	import flash.display.DisplayObject;
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
		
		public function GameBackground()
		{
			super();
			
			this.addChild(m_platform);
			
			
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
			
			m_leftBound = -m_unitWidth*1.5;
		}
		
		public function update():void
		{
			moveingRoad(m_moveSpeed);
			
			checkBackground();
		}
		
		private function moveingRoad(m_moveSpeed:Number):void
		{
			for(var i:int = 0; i < m_roadArr.length; i++)
			{
				m_roadArr[i].x -= m_moveSpeed*0.5;
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
				
			}
		}
		
		private function removeAllChild(r:RoadNormal):void
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

	}
}