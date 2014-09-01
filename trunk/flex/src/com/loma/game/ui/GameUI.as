package com.loma.game.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * 
	 * @long  Aug 28, 2014
	 * 
	 */	
	public class GameUI extends Sprite
	{
		private var m_maxLife:int = 5;
		
		private var m_gameUI:UI
		private var m_menu:Menu;
		
		private var m_btnStartCallback:Function = null;		
		
		public function GameUI()
		{
			super();
			
			m_menu = new Menu();
			this.addChild(m_menu);
			m_menu.btn_start.addEventListener(MouseEvent.CLICK, onGameStartBtnClick);
			
			m_gameUI = new UI();
			
			m_maxLife = m_gameUI.LifeBar_mc.totalFrames - 1;
			
			life = m_maxLife;
		}
		
		protected function onGameStartBtnClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(m_btnStartCallback != null)
				m_btnStartCallback();
		}
		
		public function set speed(value:int):void
		{
			m_gameUI.speed_num.text = value.toString();
		}
		
		/**
		 * 
		 * @param value 0 - 100
		 * 
		 */		
		public function set oil(value:int):void
		{
			value = 100 - value;
			var maxFram:int = m_gameUI.oil_num.totalFrames;
			var frame:int = value/100*(maxFram - 1) + 1;
			
			m_gameUI.oil_num.gotoAndStop(frame);
		}
		
		public function set score(value:int):void
		{
			m_gameUI.score_num.text = value.toString();
		}
		
		public function addScore(value:int):void
		{
			
		}
		
		public function show(value:Boolean):void
		{
			this.visible = value;
		}
		
		/**
		 *	 
		 * @param value 1 - 6
		 * 
		 */		
		public function set life(value:int):void
		{
			if(value > m_maxLife)
				value = m_maxLife;
			else if(value < 0)
				value = 0;
			
			m_gameUI.LifeBar_mc.gotoAndStop(m_maxLife - value + 1);
		}
		
		public function showMenu():void
		{
			if(m_menu.parent == null)
				this.addChild(m_menu);
			
			if(m_gameUI.parent != null)
				this.removeChild(m_gameUI);
		}
		
		public function hideMenu():void
		{
			if(m_menu.parent != null)
				this.removeChild(m_menu);
			
			if(m_gameUI.parent == null)
				this.addChild(m_gameUI);
		}
		
		public function set gameStartCallback(callback:Function):void
		{
			m_btnStartCallback = callback;
		}
		
		
		public function initialize():void
		{	
			speed = 0;
			oil = 100;
			score = 0;
			life = 6;
		}
		
		public function createAlertUI(context:String, yesCB:Function, noCB:Function):Sprite
		{
			var t:TextField = new TextField();
			t.text = context;
			t.autoSize = TextFieldAutoSize.LEFT;
			var u:Sprite = new Sprite();
			u.addChild(t);
			u.graphics.beginFill(0x33ee11, 0.75);
			u.graphics.drawRoundRect(0, 0, t.width + 50, t.height + 80, 8);
			u.graphics.endFill();
			u.x = 300;
			u.y = 200;
			
			var b:Sprite = new Sprite();
			b.graphics.beginFill(0x9911cc, 0.9);
			b.graphics.drawCircle(0, 0, 20);
			b.x = 50;
			b.y = 60;
			var bt:TextField = new TextField();
			bt.text = "好";
			bt.selectable = false;			
			b.addChild(bt);
			b.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{ yesCB(); });
			
			u.addChild(b);
			
			return u;
		}
		
	}
}