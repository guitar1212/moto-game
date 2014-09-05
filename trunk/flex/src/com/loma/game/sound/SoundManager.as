package com.loma.game.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private static var m_instance:SoundManager = null;
		public static const MENU_BACKGROUND_MUSIC:String = "";
		public static const BACKGROUND_MUSIC:String = "Sound_Bg";
		public static const AMBULANCE:String = "Sound_ambulance";
		public static const CRASH:String = "";
		
		private var m_soundDict:Dictionary = new Dictionary();
		private var m_soundChannelDict:Dictionary = new Dictionary();
		
		public function SoundManager()
		{
			createSound();
		}
		
		private function createSound():void
		{
			m_soundDict[MENU_BACKGROUND_MUSIC] = new Sound_menu();
			m_soundDict[BACKGROUND_MUSIC] = new Sound_Bg();
			m_soundDict[AMBULANCE] = new Sound_ambulance();
		}
		
		public static function get instance():SoundManager
		{
			if(m_instance == null)
				m_instance = new SoundManager();
			
			return m_instance;
		}
		
		private function playSound(sName:String, loops:int):void
		{
			stopSound(sName);
			
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
			playSound(MENU_BACKGROUND_MUSIC, 1);
		}
		
		public function stopMenuBGM():void
		{
			stopSound(MENU_BACKGROUND_MUSIC);
		}
		
		public function playBGM():void
		{
			playSound(BACKGROUND_MUSIC, 10);
		}
		
		public function stopBGM():void
		{
			stopSound(BACKGROUND_MUSIC);
		}
		
		/**
		 * 救護車音效 
		 * 
		 */		
		public function playAmbulanceSound():void
		{
			playSound(AMBULANCE, 999);
		}
		
		public function stopAmbulanceSound():void
		{
			stopSound(AMBULANCE);
		}
		
		
		/**
		 *	播放車禍音效 
		 * 
		 */		
		public function playCrashSound():void
		{
			
		}
	}
}