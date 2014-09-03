package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.randomevent.RandomEventManager;
	import com.loma.game.ui.ViolationDialog;
	
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
				
		override public function onCompleted():void
		{
			game.gamePause = true;
			QuestManager.instance.start = false;
			
			// show ui
			game.ui.showViolationUI(ViolationDialog.TYPE_BAD, "你超速囉~~ 本路段限速 " + m_speedLimit + " 公里", end);
			
			// 暫停任務進行
			QuestManager.instance.start = false;
		}
		
		override public function end():void
		{
			game.gamePause = false;
			QuestManager.instance.start = true;
			
			game.stage.focus = game.stage;
			
			game.ui.hideViolationUI();
			
			// 分數扣 10
			game.addScore(-30);
			
			// 血量減 1
			game.addLife(-1);
			
			// 繼續任務
			QuestManager.instance.start = true;
			
			RandomEventManager.instance.clean();
			
			// 重置騎士位置
			game.riderStart();
		}
		
		override public function release():void
		{
			
		}
	}
}