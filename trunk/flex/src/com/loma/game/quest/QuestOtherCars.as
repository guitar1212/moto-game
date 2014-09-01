package com.loma.game.quest
{
	import com.loma.util.TimerManager;
	
	import flash.geom.ColorTransform;

	/**
	 * 
	 * @long  Sep 1, 2014
	 * 
	 */	
	public class QuestOtherCars extends QuestBase
	{
		private var m_timerIdx:int = -1;
		
		private var m_carList:Array = [];
		
		private var m_target:int = 100;
		
		private var m_curCount:int = 0;
		
		public function QuestOtherCars()
		{
			super();
		}
		
		override public function start():void
		{	
		}
				
		private function createCar():void
		{
			var car:Car = new Car();
			
			if(game.currentSpeed < 5)
				car.x = -350;
			else
				car.x = 1250;
			car.y = 60 + Math.random()*40;
			car.transform.colorTransform = new ColorTransform(1, Math.random(), Math.random());
			game.addObjToLayer(MotoGame.LAYER_SCENE, car);
			
			m_carList.push(car);
		}
		
		override public function onUpdate():void
		{
			m_curCount++;
			if(m_curCount >= m_target)
			{
				m_curCount = 0;
				m_target = 80 + Math.random()*70;
				createCar();
			}
			
			var i:int = 0, len:int = m_carList.length;
			var curSpeed:Number = game.currentSpeed;			
			var car:Car;
			
			for(i; i < len; i++)
			{
				car = m_carList[i];
				car.x = car.x + 30 - curSpeed;
				
				if(car.x < -700 || car.x > 2000)
				{
					m_carList.splice(i, 1);
					car = null;
					len--;
				}	
			}	
		}
		
		override public function check():Boolean
		{			
			return false;
		}
		
		override public function onCompleted():void
		{
			
		}
		
		override public function end():void
		{			
		}
		
		override public function release():void
		{
			
		}
	}
}