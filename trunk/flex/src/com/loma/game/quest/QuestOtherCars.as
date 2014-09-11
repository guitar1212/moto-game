package com.loma.game.quest
{
	import com.loma.game.car.Coupe;
	import com.loma.game.quest.base.QuestBase;
	import com.loma.util.TimerManager;
	
	import flash.geom.ColorTransform;
	
	import flashx.textLayout.operations.CopyOperation;

	/**
	 * 
	 * @long  Sep 1, 2014
	 * 
	 */	
	public class QuestOtherCars extends QuestBase
	{		
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
		
		override public function onUpdate():void
		{
			m_curCount++;
			if(m_curCount >= m_target)
			{
				m_curCount = 0;
				m_target = 140 + Math.random()*80;
				createCar();
			}
			
			var i:int = 0, len:int = m_carList.length;
			var curSpeed:Number = game.currentSpeed;			
			var car:Coupe;
			
			for(i; i < len; i++)
			{
				car = m_carList[i];
				car.update();
				car.x -= curSpeed;
				
				if(car.x < -500 || car.x > 1500)
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
			var car:Coupe
			for(var i:int = 0; i < m_carList.length; i++)
			{
				car = m_carList[i];
				if(car.parent)
					car.parent.removeChild(car);
			}
			m_carList.length = 0;
		}
		
		private function createCar():void
		{
			var car:Coupe = new Coupe();
			car.speed = 40 + Math.random()*15;
			car.gotoAndStop(1 + ~~(Math.random()*5 - 0.001));
			if(game.currentSpeed < 30)
				car.x = -300;
			else
				car.x = 1000;
			car.y = 165 + Math.random()*100;
			//car.transform.colorTransform = new ColorTransform(Math.random(), Math.random(), 1);
			game.addObjToLayer(MotoGame.LAYER_SCENE, car);
			
			m_carList.push(car);
		}
	}
}