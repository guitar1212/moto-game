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
		
		public function QuestOtherCars()
		{
			super();
		}
		
		override public function start():void
		{			
			m_timerIdx = TimerManager.instance.register(onTimeUp, 3000, -1);
		}
		
		private function onTimeUp():void
		{
			createCar();
		}
		
		private function createCar():void
		{
			var car:Car = new Car();
			car.x = 1250;
			car.y = 100;
			//car.transform.colorTransform = new ColorTransform(Math.random(), Math.random(), Math.random());
			game.addObjToLayer(MotoGame.LAYER_SCENE, car);
			
			m_carList.push(car);
		}
		
		override public function onUpdate():void
		{
			var i:int = 0, len:int = m_carList.length;
			var curSpeed:Number = game.currentSpeed;			
			var car:Car;
			
			for(i; i < len; i++)
			{
				car = m_carList[i];
				car.x = car.x + 30 - curSpeed;
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