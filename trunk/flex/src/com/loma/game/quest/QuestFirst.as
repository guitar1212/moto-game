package com.loma.game.quest
{
	import com.loma.game.player.Rider;
	import com.loma.game.quest.define.QuestState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * 遊戲開始的第一個任務
	 * 詢問是否要戴安全帽
	 * 答錯則無法繼續進行遊戲
	 * 
	 * @long  Aug 29, 2014
	 * 
	 */	
	public class QuestFirst extends QuestBase
	{
		
		private var m_bOK:Boolean = false;
		private var u:Sprite;
		
		public function QuestFirst()
		{
			excuteTimes = 1; 
		}
		
		override public function start():void
		{
			// 暫停遊戲進行
			game.gamePause = true;
			
			// 設置騎士為位配戴安全帽狀態
			game.player.state = Rider.STATE_START;
			
			// show ui 
			u = game.ui.createAlertUI("要不要戴安全帽呢??", onMouseClick, null);
			
			game.addObjToLayer(MotoGame.LAYER_UI, u);
		}
				
		protected function onMouseClick():void
		{
			m_bOK = true;
		}
		
		override public function onUpdate():void
		{
		}
		
		override public function check():Boolean
		{
			if(m_bOK)
			{
				this.state = QuestState.END;				
			}
			return m_bOK;
		}
		
		override public function end():void
		{
			this.state = QuestState.DESTORY;
			
			game.gamePause = false;
			game.removeObjFormLayer(MotoGame.LAYER_UI, u);
			
			game.addScore(5);
			
			game.stage.focus = game.stage;
			
			// add quest
			var q:QuestSpeedLimit = new QuestSpeedLimit();
			q.speedLimit = 70;
			QuestManager.instance.addQuest(q);
			
			var qc:QuestOtherCars = new QuestOtherCars();
			QuestManager.instance.addQuest(qc);
		}
		
		override public function release():void
		{
			
		}
	}
}