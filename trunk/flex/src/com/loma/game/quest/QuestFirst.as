package com.loma.game.quest
{
	import com.loma.game.player.Rider;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.ui.FirstQuestionDialog;
	
	import flash.display.SimpleButton;
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
			var alert:FirstQuestionDialog = new FirstQuestionDialog();
			alert.addEventListener(MouseEvent.CLICK, onAlertMouseClick);
			
			game.addObjToLayer(MotoGame.LAYER_UI, alert);
		}
		
		protected function onAlertMouseClick(event:MouseEvent):void
		{
			if(event.target is SimpleButton)
			{
				m_bOK = true;
			
				var alert:FirstQuestionDialog = event.currentTarget as FirstQuestionDialog;
				alert.removeSelf();
			}
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
			//game.removeObjFormLayer(MotoGame.LAYER_UI, u);
			
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