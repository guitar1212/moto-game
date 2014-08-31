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
		
		public function QuestFirst()
		{
			
		}
		
		override public function start():void
		{
			// 暫停遊戲進行
			game.gamePause = true;
			
			// 設置騎士為位配戴安全帽狀態
			game.player.state = Rider.STATE_START;
			
			// show ui 
			testUI();
		}
		
		private var u:Sprite;
		private function testUI():void
		{
			// TODO Auto Generated method stub
			var t:TextField = new TextField();
			t.text = "要不要戴安全帽呢?";
			u = new Sprite();
			u.addChild(t);
			u.graphics.beginFill(0x33ee11, 0.75);
			u.graphics.drawRoundRect(0, 0, t.width + 50, t.height + 50, 8);
			u.graphics.endFill();
			u.x = 300;
			u.y = 200;
			
			var b:Sprite = new Sprite();
			b.graphics.beginFill(0x9911cc, 0.9);
			b.graphics.drawCircle(0, 0, 20);
			b.x = 50;
			b.y = 100;
			var bt:TextField = new TextField();
			bt.text = "好";
			bt.selectable = false;			
			b.addChild(bt);
			b.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			
			u.addChild(b);
			
			game.addObjToLayer(MotoGame.LAYER_UI, u);
		}
		
		protected function onMouseClick(event:MouseEvent):void
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
			game.gamePause = false;
			game.removeObjFormLayer(MotoGame.LAYER_UI, u);
			
			game.addScore(5);
		}
		
		override public function release():void
		{
			
		}
	}
}