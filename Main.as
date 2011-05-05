package {
	
	// Imports:
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import com.greensock.*;
	import com.greensock.events.*;
	import com.greensock.loading.*;
	import com.greensock.easing.*;
	import me.hulse.util.*;
	import com.apdevblog.utils.*;
	
	/**
	* Preloads swf with loader and resizes to fit stage.
	* 
	* @author Micky Hulse
	*/
	
	public class Main extends Sprite {
		
		// Meta:
		private static const APP_NAME:String = 'SWF pre-loader';
		private static const APP_VERSION:String = '1.0';
		private static const APP_CREATED:String = '2011/04/28';
		private static const APP_MODIFIED:String = '2011/04/28';
		private static const APP_AUTHOR:String = 'Micky Hulse <micky@hulse.me>';
		
		private var _ft:FireTrace;
		private var _ldr:LoaderMc;
		private var _swf:SWFLoader;
		
		/**
		* Class constructor.
		* 
		* @return N/A
		*/
		
		public function Main() {
			
			// Logging:
			_ft = new FireTrace();
			_ft.log('Main() instantiated...');
			_ft.log('Name: ' + APP_NAME + '; Version: ' + APP_VERSION + '; Created: ' +  APP_CREATED + '; Modified: ' + APP_MODIFIED + '; Author: ' + APP_AUTHOR);
			
			// Wait for green light:
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			
		};
		
		/**
		* Initializes project.
		* 
		* @param Event
		* 
		* @return void
		*/
		
		private function init($e:Event):void {
			
			// Logging:
			_ft.log('init()');
			
			// GC:
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Setup stage:
			new Stager(this);
			
			// Get embed parameters/flashvars:
			var pSwf:String;
			var p:Params = new Params(this);
			pSwf = p.getParam('swf', '');
			
			if (pSwf != '') {
				
				var pWin:String;
				var pLink:String;
				var pLdr:String;
				
				pLink = p.getParam('link', '');
				pLdr = p.getParam('loader', 'FFFFFF');
				pWin = p.getParam('window', '_self');
				
				// Sanitize color:
				pLdr = pLdr.replace('#', '').replace('0x', '');
				
				// Loading movieclip:
				_ldr = new LoaderMc();
				// Ignore mouse interaction:
				_ldr.mouseEnabled = false;
				// The "layer" blendMode makes the alpha fades cleaner (overlapping objects don't add alpha levels):
				_ldr.blendMode = 'layer';
				
				// Colorize the loader:
				var color:ColorTransform = _ldr.transform.colorTransform;
				color.color = uint('0x' + pLdr);
				_ldr.transform.colorTransform = color;
				
				// Center it:
				center(_ldr);
				
				// Add it to the display list:
				this.addChild(_ldr);
				
				// SWF:
				var swfContainer:Sprite = new Sprite()
				
				// Linkage?
				if (pLink != '') {
					
					// Setup linking with inline handler:
					swfContainer.addEventListener(MouseEvent.MOUSE_UP, function():void {
						
						// Logging:
						_ft.log('Clicked! Link: ' + pLink + '; Window: ' + pWin);
						
						// Using class for going to URL:
						URLUtils.openWindow(pLink, pWin); // http://apdevblog.com/problems-using-navigatetourl/
						//navigateToURL(new URLRequest(pLink), pWin); // <-- Was not working on Mac via Firefox 4x or Safari 5x.
						
					}, false, 0, true);
					
				}
				
				// Mouse:
				swfContainer.buttonMode = true;
				swfContainer.useHandCursor = true;
				
				// IBID, see _ldr:
				swfContainer.blendMode = 'layer';
				swfContainer.mouseChildren = false;
				
				// Add to display list:
				this.addChild(swfContainer) as Sprite;
				
				// Setup SWFLoader:
				_swf = new SWFLoader(pSwf, { name: 'swf', container: swfContainer, alpha: 0, width: stage.stageWidth, height: stage.stageHeight, onComplete: onCompleteHandler });
				
				_swf.load();
				
				// Initial stage resize:
				stage.addEventListener(Event.RESIZE, onResizeHandler, false, 0, true);
				
			}
			
		};
		
		/**
		* Complete handler for SWFLoader.
		* 
		* @param LoaderEvent
		* 
		* @return void
		*/
		
		private function onCompleteHandler($e:LoaderEvent):void {
			
			// Logging:
			_ft.log('onReady()');
			
			// Fade it in:
			TweenLite.to(_swf.content, .5, { alpha: 1, ease: Linear.easeNone, onComplete: remove, onCompleteParams: [ _ldr ] });
			
		};
		
		/**
		* Stage resize handler.
		* 
		* @param Event
		* 
		* @return void
		*/
		
		private function onResizeHandler($e:Event):void {
			
			// Don't want to log this.
			
			center(_ldr);
			
			// Resize content:
			_swf.content.fitWidth = stage.stageWidth;
			_swf.content.fitHeight = stage.stageHeight;
			
		};
		
		/**
		* Removes object from display list.
		* 
		* @param object
		* 
		* @return void
		*/
		
		private function remove($obj:*):void {
			
			// Logging:
			_ft.log('removeThis()');
			
			// Using try/catch for the sake of it:
			try {
				
				// No sense in having this animating while it is covered by video:
				this.removeChild($obj);
				
			} catch ($err:Error) {
				
				_ft.log($err);
				
			}
						
		};
		
		/**
		* Centers an object on stage.
		* 
		* @param object
		* 
		* @return void
		*/
		
		private function center($obj:*):void {
			
			// I would prefer not to log this also.
			
			// Fits object to stage:
			$obj.x = stage.stageWidth * .5 - $obj.width * .5;
			$obj.y = stage.stageHeight * .5 - $obj.height * .5;
			
		};
		
	};
	
};