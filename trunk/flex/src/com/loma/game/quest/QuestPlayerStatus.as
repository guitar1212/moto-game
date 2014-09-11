package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quest.define.QuestState;
	import com.loma.game.sound.SoundManager;
	import com.loma.game.string.StringTable;
	import com.loma.game.ui.FirstQuestionDialog;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	/**
	 * 
	 * @long  Sep 4, 2014
	 * 
	 */	
	public class QuestPlayerStatus extends QuestBase
	{
		private static const TYPE_CELLPHONE:int = 0;
		private static const TYPE_TIRED:int = 1;
		private static const TYPE_AMOUNT:int = 2;
		
		private var m_eventObj:MovieClip = null;
		
		private var m_type:int;
		
		private var m_waitCount:int = 100;
		
		private var m_bOK:Boolean = false;
		
		public function QuestPlayerStatus()
		{
			super();
		}
		
		override public function start():void
		{			
			m_type = getTimer()%TYPE_AMOUNT;
			if(m_type == TYPE_CELLPHONE)
			{
				m_eventObj = new EventObject1();
				SoundManager.instance.playCellphoneSound();
			}
			else if(m_type == TYPE_TIRED)
			{
				m_eventObj = new EventObject2();
				SoundManager.instance.playTiredSound();
			}
			
			m_eventObj.x = 60;
			m_eventObj.y = -185;
			m_eventObj.mouseEnabled = true;
			m_eventObj.useHandCursor = true;
			m_eventObj.mouseChildren = false;
							
			m_eventObj.addEventListener(MouseEvent.CLICK, onEventClick);
			game.player.addChild(m_eventObj);
		}
		
		protected function onEventClick(event:MouseEvent):void
		{
			m_bOK = true;
		}
		
		override public function onUpdate():void
		{
			m_waitCount--;
			if(m_waitCount <= 0)
			{
				m_bOK = true;
			}
		}
		
		override public function check():Boolean
		{			
			return m_bOK;
		}
		
		override public function onCompleted():void
		{	
		}
		
		override public function end():void
		{			
			var alert:FirstQuestionDialog = new FirstQuestionDialog();
			
			if(m_type == TYPE_CELLPHONE)
			{
				alert.setText(StringTable.CELLPHONE);
				SoundManager.instance.stopCellphoneSound();
			}
			else if(m_type == TYPE_TIRED)
			{
				alert.setText(StringTable.TIRED);
				SoundManager.instance.stopTiredSound();
			}
			
			alert.callback = alertCallback;
				
			game.addObjToLayer(MotoGame.LAYER_UI, alert);
			
			this.game.gamePause = true;
			QuestManager.instance.start = false;
		}
		
		private function alertCallback(value:Boolean):void
		{
			var type:int;
			var context:String;
			var score:int;
			if(value)
			{
				type = ViolationDialog.TYPE_BAD;
				score = -30;
				game.addLife(-1);
			}
			else
			{
				type = ViolationDialog.TYPE_GOOD;
				score = 50;
			}
			
			if(m_type == TYPE_CELLPHONE)
				context = StringTable.CELLPHONE_DESC;
			else if(m_type == TYPE_TIRED)
				context = StringTable.TIRED_DESC;
			
			game.ui.showViolationUI(type, context, score, resume);
			
			game.addScore(score);
		}
		
		private function resume():void
		{
			this.game.gamePause = false;
			QuestManager.instance.start = true;
			
			this.state = QuestState.DESTORY;
			
			game.ui.hideViolationUI();
			
			game.dispatchEvent(new Event("QueseComplete"));
			
			if(game.ui.violationUITyp == ViolationDialog.TYPE_BAD)
				game.riderStart();
		}
		
		override public function release():void
		{
			game.player.removeChild(m_eventObj);
			m_eventObj.removeEventListener(MouseEvent.CLICK, onEventClick);
			m_eventObj = null;
		}
	}
}