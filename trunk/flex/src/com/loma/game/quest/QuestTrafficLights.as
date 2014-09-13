package com.loma.game.quest
{
	import com.loma.game.TrafficLight;
	import com.loma.game.event.TrafficLightEvent;
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.randomevent.RandomEventManager;
	import com.loma.game.string.StringTable;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * 救護車任務
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuestTrafficLights extends QuestBase
	{
		private var m_road:RoadEvent;
		
		private var m_hitArea:Sprite;
		
		private var m_people:Peoples;
		
		private var m_trafficLight:TrafficLight;
		
		public function QuestTrafficLights()
		{
			super();
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(event.keyCode == Keyboard.R)
			{
				m_trafficLight.light = "red";
				var te:TrafficLightEvent = new TrafficLightEvent(TrafficLightEvent.RED);
				te.hitArea = m_hitArea;
				game.dispatchEvent(te);
			}
			else if(event.keyCode == Keyboard.G)
			{
				m_trafficLight.light = "green";
				game.dispatchEvent(new TrafficLightEvent(TrafficLightEvent.GREEN));
			}
		}
		
		override public function start():void
		{
			createTrafficLight();
			//test
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function createTrafficLight():void
		{
			m_road = new RoadEvent();
			game.background.addObject(2, m_road, 0, 0);
			
			m_trafficLight = new TrafficLight();
			m_trafficLight.light = "red";
			//m_trafficLight.start();
			m_trafficLight.x = 0;
			m_trafficLight.y = 0;
			game.background.append(2, m_trafficLight, 480, 500);			
			game.addObjToLayer(MotoGame.LAYER_UI, m_trafficLight);
			
			// hit area
			m_hitArea = new Sprite();
			m_hitArea.graphics.beginFill(0x523612, 0.45);
			m_hitArea.graphics.drawRect(0, 0, 200, 500);
			m_hitArea.graphics.endFill();
			//m_hitArea.visible = false;
			m_hitArea.x = 440;
			m_road.addChild(m_hitArea);
			
			// 
			m_people = new Peoples();
			game.background.addObject(2, m_people, 680, 40);
			
			var te:TrafficLightEvent = new TrafficLightEvent(TrafficLightEvent.RED);
			te.hitArea = m_hitArea;
			game.dispatchEvent(te);
		}
		
		override public function onUpdate():void
		{
			if(m_trafficLight.light == "red")
			{
				if(game.player.hitObject.hitTestObject(m_hitArea))
				{
					game.gamePause = true;
					QuestManager.instance.start = false;
					
					game.ui.showViolationUI(ViolationDialog.TYPE_BAD, StringTable.TRAFFIC_LIGHT, -30, comfirm);
					game.addScore(-30);
					game.addLife(-1);
				}
			}
			
			m_people.y += 3;

			if(m_people.y >= 450 &&  m_people.y <= 455 && m_trafficLight.light == "red")
			{
				m_trafficLight.light = "green";
				game.dispatchEvent(new TrafficLightEvent(TrafficLightEvent.GREEN));
			}
		}
		
		private function comfirm():void
		{
			game.ui.hideViolationUI();
			game.gamePause = false;
			QuestManager.instance.start = true;
			
			game.riderStart();
			
			RandomEventManager.instance.clean();			
		}
		
		override public function check():Boolean
		{			
			return (m_road.parent == null);
		}
		
		override public function onCompleted():void
		{
			game.dispatchEvent(new Event("QueseComplete"));
			this.state = QuestState.END;			
		}
		
		override public function end():void
		{	
			this.state = QuestState.DESTORY;
		}
		
		override public function release():void
		{
			game.background.removeApped(m_trafficLight);
			
			if(m_trafficLight.parent)
				m_trafficLight.parent.removeChild(m_trafficLight);
			m_trafficLight.release();
			m_trafficLight = null;
			
			if(m_road.parent)
				m_road.parent.removeChild(m_road);
			
			m_hitArea.graphics.clear();
			m_road.removeChild(m_hitArea);
			m_road = null;	
			
			if(m_people.parent)
				m_people.parent.removeChild(m_people);
			
			m_people = null;
			
			//test
			game.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
	}
}