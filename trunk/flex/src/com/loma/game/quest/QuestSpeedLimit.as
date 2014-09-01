package com.loma.game.quest
{
	import flash.display.Sprite;

	/**
	 * 
	 * @long  Sep 1, 2014
	 * 
	 */	
	public class QuestSpeedLimit extends QuestBase
	{
		private var m_speedLimit:int = 50;
		
		public function QuestSpeedLimit()
		{
			super();
			
			// 重覆任務
			this.excuteTimes = -1;
			
			speedLimit = 50;
		}
		
		public function set speedLimit(value:int):void
		{
			m_speedLimit = value;
		}
		
		override public function start():void
		{	
		}
		
		
		override public function onUpdate():void
		{
		}
		
		override public function check():Boolean
		{			
			return game.currentSpeed > m_speedLimit;
		}
		
		private var u:Sprite;
		override public function onCompleted():void
		{
			game.gamePause = true;
			
			// show ui
			u = game.ui.createAlertUI("你超速囉~~ 速限 " + m_speedLimit + " 公里", this.end, null);
			game.addObjToLayer(MotoGame.LAYER_UI, u);
			
			// 暫停任務進行
			this.pause = true;
		}
		
		override public function end():void
		{
			game.gamePause = false;
			
			game.stage.focus = game.stage;
			
			game.removeObjFormLayer(MotoGame.LAYER_UI, u);
			
			// 分數扣 10
			game.addScore(-10);
			
			// 血量減 1
			game.addLife(-1);
			
			// 繼續任務
			this.pause = false;
			
			// 重置騎士位置
			game.riderStart();
		}
		
		override public function release():void
		{
			
		}
	}
}