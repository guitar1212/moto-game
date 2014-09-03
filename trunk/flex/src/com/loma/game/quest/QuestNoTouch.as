package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.string.StringTable;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.display.Sprite;

	/**
	 * 
	 * @long  Sep 2, 2014
	 * 
	 */	
	public class QuestNoTouch extends QuestBase
	{
		private var m_upperBound:Sprite;
		private var m_lowerBound:Sprite
		
		public function QuestNoTouch()
		{
			super();
		}
		
		override public function start():void
		{
			setBound();
		}
		
		override public function onUpdate():void
		{			
			if(game.player.hitObject.hitTestObject(m_upperBound))
				game.ui.showViolationUI(ViolationDialog.TYPE_BAD, StringTable.FAST_TRACK, onConfirm);
			
			if(game.player.hitObject.hitTestObject(m_lowerBound))
				game.ui.showViolationUI(ViolationDialog.TYPE_BAD, StringTable.SIDEWALK, onConfirm);
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
			this.game.removeObjFormLayer(MotoGame.LAYER_SCENE, m_upperBound);
			this.game.removeObjFormLayer(MotoGame.LAYER_SCENE, m_lowerBound);
		}
		
		private function setBound():void
		{
			m_upperBound = new Sprite();
			m_upperBound.graphics.beginFill(0x55dd22, 0.35);
			m_upperBound.graphics.drawRect(0, 0, 700, 260);
			m_upperBound.graphics.endFill();
			m_upperBound.visible = false;
			this.game.addObjToLayer(MotoGame.LAYER_SCENE, m_upperBound);
			
			m_lowerBound = new Sprite();
			m_lowerBound.y = 440; 
			m_lowerBound.graphics.beginFill(0x1155ff, 0.35);
			m_lowerBound.graphics.drawRect(0, 0, 700, 250);
			m_lowerBound.graphics.endFill();
			m_lowerBound.visible = false;
			this.game.addObjToLayer(MotoGame.LAYER_SCENE, m_lowerBound);
		}
		
		private function onConfirm():void
		{
			game.ui.hideViolationUI();
			game.riderStart();
			
			game.addLife(-1);
			game.addScore(-5);
		}
	}
}