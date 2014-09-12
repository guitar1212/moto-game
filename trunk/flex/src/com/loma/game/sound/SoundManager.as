package com.loma.game.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private static var m_instance:SoundManager = null;
		public static const MENU_BACKGROUND_MUSIC:String = "Sound_menu";
		public static const BACKGROUND_MUSIC:String = "Sound_Bg";
		public static const BACKGROUND_OVER:String = "Sound_over";
		
		public static const AMBULANCE:String = "Sound_ambulance";
		public static const CRASH:String = "";
		public static const CELLPHONE:String = "Sound_phone";
		public static const TIRED:String = "Sound_obake";
		
		public static const RIDER_MOVE:String = "Sound_motoMove";
		public static const RIDER_BREAK:String = "Sound_slow";
		
		public static const SUCCESS:String = "Sound_success";
		public static const FAILED:String = "Sound_fail";
		
		public static const OBSTACLES:String = "Sound_deductions";
		public static const ADD_SCORE:String = "Sound_up";
		
		public static const QUIZ:String = "Sound_quest";
		
		
		private var m_soundDict:Dictionary = new Dictionary();
		private var m_soundChannelDict:Dictionary = new Dictionary();
		
		private var m_bMute:Boolean = false;
		
		public function SoundManager()
		{
			createSound();
		}
		
		private function createSound():void
		{
			m_soundDict[MENU_BACKGROUND_MUSIC] = new Sound_menu();
			m_soundDict[BACKGROUND_MUSIC] = new Sound_Bg();
			m_soundDict[BACKGROUND_OVER] = new Sound_over;
			
			m_soundDict[AMBULANCE] = new Sound_ambulance();
			m_soundDict[CELLPHONE] = new Sound_phone();
			m_soundDict[TIRED] = new Sound_obake();
			//m_soundDict[RIDER_MOVE] = new Sound_motoMove();
			m_soundDict[RIDER_BREAK] = new Sound_slow();
			m_soundDict[SUCCESS] = new Sound_success();
			m_soundDict[FAILED] = new Sound_fail();
			m_soundDict[OBSTACLES] = new Sound_deductions();
			m_soundDict[ADD_SCORE] = new Sound_up();
			m_soundDict[QUIZ] = new Sound_quest();
		}
		
		public static function get instance():SoundManager
		{
			if(m_instance == null)
				m_instance = new SoundManager();
			
			return m_instance;
		}
		
		private function playSound(sName:String, loops:int):void
		{
			if(m_bMute) return;
			
			stopSound(sName);
			
			if(m_soundDict[sName])
				m_soundChannelDict[sName] = (m_soundDict[sName] as Sound).play(0, loops);
		}
		
		private function stopSound(sName:String):void
		{
			if(m_soundChannelDict[sName])
			{
				var ch:SoundChannel = m_soundChannelDict[sName];
				ch.stop();
				ch = null;
				m_soundChannelDict[sName] = null;
			}
		}
		
		public function playMenuBGM():void
		{
			playSound(MENU_BACKGROUND_MUSIC, 999);
		}
		
		public function stopMenuBGM():void
		{
			stopSound(MENU_BACKGROUND_MUSIC);
		}
		
		public function playBGM():void
		{
			playSound(BACKGROUND_MUSIC, 999);
		}
		
		public function stopBGM():void
		{
			stopSound(BACKGROUND_MUSIC);
		}
		
		public function playOverBGM():void
		{
			playSound(BACKGROUND_OVER, 999);
		}
		
		public function stopOverBGM():void
		{
			stopSound(BACKGROUND_OVER);
		}
		
		/**
		 * 救護車音效 
		 * 
		 */		
		public function playAmbulanceSound():void
		{
			playSound(AMBULANCE, 10);
		}
		
		public function stopAmbulanceSound():void
		{
			stopSound(AMBULANCE);
		}
		
		
		public function playCellphoneSound():void
		{
			playSound(CELLPHONE, 0);
		}
		
		public function stopCellphoneSound():void
		{
			stopSound(CELLPHONE);
		}
		
		public function playTiredSound():void
		{
			playSound(TIRED, 0);
		}
		
		public function stopTiredSound():void
		{
			stopSound(TIRED);
		}
		
		public function playMoveSound():void
		{
			playSound(RIDER_MOVE, 0);
		}
		
		public function stopMoveSound():void
		{
			stopSound(RIDER_MOVE);
		}
		
		/**
		 *	播放車禍音效 
		 * 
		 */		
		public function playCrashSound():void
		{
			
		}
		
		public function playSuccessSound():void
		{
			playSound(SUCCESS, 0);
		}
		
		public function playFailedSound():void
		{
			playSound(FAILED, 0);
		}
		
		public function playObstaclesSound():void
		{
			playSound(OBSTACLES, 0);
		}
		
		public function playQuizSound():void
		{
			playSound(QUIZ, 0);
		}
		
		public function playAddScoreSound():void
		{
			playSound(SUCCESS, 0);
		}

		public function get mute():Boolean
		{
			return m_bMute;
		}

		public function set mute(value:Boolean):void
		{
			m_bMute = value;
			if(m_bMute)
				stopAll();
			else
				playAll();
		}
		
		private function playAll():void
		{
			
		}
		
		private function stopAll():void
		{
				
		}
		
	}
}