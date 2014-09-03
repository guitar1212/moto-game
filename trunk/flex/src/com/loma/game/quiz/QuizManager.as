package com.loma.game.quiz
{
	/**
	 * 
	 * @long  Sep 3, 2014
	 * 
	 */	
	public class QuizManager
	{
		private static var m_instance:QuizManager = null;
		
		public static const TOTAL_QUESTIONS:int = 10;
		
		private var m_quizIdxList:Array = [];
		
		private var m_quizLib:QuizLibrary = new QuizLibrary();
		
		private var m_curQuiz:Object;
		
		public function QuizManager()
		{
			reGeneration();
		}
		
		public static function get instance():QuizManager
		{
			if(m_instance == null)
				m_instance = new QuizManager();
						
			return m_instance;
		}
		
		public function reGeneration():void
		{
			m_quizIdxList.length = 0;
			
			var tempArr:Array = [];
			for(var i:int = 0; i < TOTAL_QUESTIONS; i++)
				tempArr.push(i);
				
			for(i = 0; i < TOTAL_QUESTIONS; i++)
			{
				var ri:int = ~~(Math.random()*(tempArr.length - 1) + 0.5);
				m_quizIdxList.push(tempArr.splice(ri, 1));
			}			
		}
		
		public function getNewQuiz():Object
		{
			if(m_quizIdxList.length == 0)
				reGeneration();
			var index:int = m_quizIdxList.pop();
			m_curQuiz = m_quizLib.getQuiz(index);
			return m_curQuiz;
		}
		
		public function getCurrentQuiz():Object
		{
			return m_curQuiz;
		}
	}
}