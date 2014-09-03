package com.loma.game.quest
{
	import com.loma.game.quest.base.QuestBase;
	import com.loma.game.quiz.QuizManager;
	import com.loma.game.ui.ViolationDialog;
	
	import flash.events.Event;
	
	/**
	 * 問答任務
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuestQuiz extends QuestBase
	{
		private var m_qm:QuestionMark;
		
		private var m_bOK:Boolean = false;
		
		public function QuestQuiz()
		{
			super();
		}
		
		override public function start():void
		{
			createQuiz();
		}
		
		private function createQuiz():void
		{
			m_qm = new QuestionMark();
			game.background.addObject(2, m_qm, 350 , 300 + Math.random()*50 );
		}
		
		override public function onUpdate():void
		{
			// 判斷是否碰到問號
			if(game.player.hitObject.hitTestObject(m_qm))
			{
				this.pause = true;
				game.gamePause = true;
				
				QuestManager.instance.start = false;				
				
				if(m_qm.parent)
					m_qm.parent.removeChild(m_qm);
				
				showQuiz();
			}
			
			// 物件被咦除
			if(!m_bOK)
				m_bOK = m_qm.parent == null;
		}
		
		private function showQuiz():void
		{
			// get new quiz
			var quiz:Object = QuizManager.instance.getNewQuiz();
			
			game.ui.showQuizUI(quiz.q, answerCallback);
		}
		
		private function answerCallback(answer:Boolean):void
		{
			game.ui.hideQuizUI();
			
			var quiz:Object = QuizManager.instance.getCurrentQuiz();
			if(answer == quiz.a) // 答對了
			{
				game.ui.showViolationUI(ViolationDialog.TYPE_GOOD, quiz.d + "\n\n恭喜你獲得 50 分!" , onClick);
				game.addScore(50);
			}
			else // 答錯了
			{
				game.ui.showViolationUI(ViolationDialog.TYPE_BAD, quiz.d + "\n\n很遺憾你被扣 30 分!", onClick);
				game.addScore(-30);
				game.addLife(-1);
			}
		}
		
		private function onClick():void
		{
			game.ui.hideViolationUI();
			
			this.pause = false;
			game.gamePause = false;
			
			QuestManager.instance.start = true;
			
			game.stage.focus = game.stage;
			
			game.riderStart();
		}
		
		override public function check():Boolean
		{			
			return m_bOK;
		}
		
		override public function onCompleted():void
		{
			game.dispatchEvent(new Event("QueseComplete"));	
		}
		
		override public function end():void
		{			
		}
		
		override public function release():void
		{
			if(m_qm.parent)
				m_qm.parent.removeChild(m_qm);
			
			m_qm = null;
		}
	}
}