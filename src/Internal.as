	// ActionScript file
	
	
	/**
	 * function onInvoke() is called when the application starts, or a file associated with the application is opened
	 * */
	public function onInvoke(invokeEvent:InvokeEvent):void {
		if (invokeEvent.currentDirectory != null){
			//trace("Current directory=" + invokeEvent.currentDirectory.nativePath);
		}
		else {
			//trace("--no directory information available--");
		}
		
		/**
		 * arguments are space separated
		 * possible arguments:
		 * 		-s :	set all security to true
		 * 		-l :	login with first record in t_resource where debugger = 1
		 * 		
		 * 		<filename>
		 */
		if (invokeEvent.arguments.length > 0){
			trace("Arguments: \n\t" + invokeEvent.arguments.join("\n\t"));
			//overrideSecurity = false;
			
			for(var i:int=0; i<invokeEvent.arguments.length; i++){
				if( invokeEvent.arguments[i].indexOf('.c5p') != -1 ){	// 'file open' action - file name is given as argument
					/*var fileLoader:Loader = new Loader();
					var fileToOpen:String = String(invokeEvent.arguments[i]);
					fileLoader.load(new URLRequest(fileToOpen));*/
					//var f:File = new File( invokeEvent.arguments[i] );
				}
				else {
					switch(invokeEvent.arguments[i]){
						case '-s':	// set all security to true
							//overrideSecurity = true;
							break;
						case '-l':	// login with first record in t_resource where debugger = 1
							//login('prosteps','proservice1!');
							break;
						
						default:
					}
				}
			}
		}
		else {
			trace("--no arguments--");
		}
	}
	
	public function setFocusOnOpenWindow(event:Event):void {
		//event.preventDefault();
		//event.stopImmediatePropagation();
		
		//trace('setFocusOnOpenWindow');
		
		// dialogs priority ordered from low to high
		
		if(dlgSettings				!= null && dlgSettings.visible				) dlgSettings.regetFocus(null);
		//if(dlgSecurity				!= null && dlgSecurity.visible				) dlgSecurity.regetFocus(null);
		//if(dlgPhases				!= null	&& dlgPhases.visible				) dlgPhases.regetFocus(null);
		if(dlgAbout					!= null	&& dlgAbout.visible					) dlgAbout.regetFocus(null);
		//if(dlgProject				!= null	&& dlgProject.visible				) dlgProject.regetFocus(null);
		//if(dlgDeliverable			!= null	&& dlgDeliverable.visible			) dlgDeliverable.regetFocus(null);
		//if(dlgChangeMenu			!= null	&& dlgChangeMenu.visible			) dlgChangeMenu.regetFocus(null);
		//if(dlgProjectDeliverable	!= null	&& dlgProjectDeliverable.visible	) dlgProjectDeliverable.regetFocus(null);
		//if(dlgProjectPhaseComments	!= null	&& dlgProjectPhaseComments.visible	) dlgProjectPhaseComments.regetFocus(null);
		//if(dlgProjectPhaseTasks		!= null	&& dlgProjectPhaseTasks.visible		) dlgProjectPhaseTasks.regetFocus(null);
		//if(dlgChangePassword		!= null	&& dlgChangePassword.visible		) dlgChangePassword.regetFocus(null);
		
		//if(dlgUploadDocument	!= null	&& dlgUploadDocument.visible	) callLater( dlgUploadDocument.regetFocus );
		//if(dlgUsers				!= null	&& dlgUsers.visible				) callLater( callLater, [dlgUsers.regetFocus] );
		//if(dlgUser				!= null	&& dlgUser.visible				) callLater( callLater, [ callLater, [dlgUser.regetFocus] ] );
		
		callLater( Factory.setDialogToFront );
		
	}
	
	private function closeApp(event:Event = null):void {
		Factory.closeDialogs();
		
		if(dlgSettings				!= null) dlgSettings.stage.nativeWindow.close();
		//if(dlgSecurity				!= null) dlgSecurity.stage.nativeWindow.close();
		//if(dlgPhases				!= null) dlgPhases.stage.nativeWindow.close();
		if(dlgAbout					!= null) dlgAbout.stage.nativeWindow.close();
		//if(dlgUser					!= null) dlgUser.stage.nativeWindow.close();
		//if(dlgProject				!= null) dlgProject.unload();
		//if(dlgDeliverable			!= null) dlgDeliverable.unload();
		//if(dlgChangeMenu			!= null) dlgChangeMenu.stage.nativeWindow.close();
		//if(dlgUsers					!= null) dlgUsers.stage.nativeWindow.close();
		//if(dlgUploadDocument		!= null) dlgUploadDocument.stage.nativeWindow.close();
		//if(dlgProjectDeliverable	!= null) dlgProjectDeliverable.stage.nativeWindow.close();
		//if(dlgProjectPhaseComments	!= null) dlgProjectPhaseComments.unload();
		//if(dlgProjectPhaseTasks		!= null) dlgProjectPhaseTasks.unload();
		//if(dlgChangePassword		!= null) dlgChangePassword.unload();
		
		NativeApplication.nativeApplication.icon.bitmaps = [];
		
		//stage.nativeWindow.close();
		NativeApplication.nativeApplication.exit();
	}
	
	private function setAllWindowsEnabled(value:Boolean):void {
		if(dlgSettings				!= null) dlgSettings.enabled = value;
		//if(dlgSecurity				!= null) dlgSecurity.enabled = value;
		//if(dlgPhases				!= null) dlgPhases.enabled = value;
		if(dlgAbout					!= null) dlgAbout.enabled = value;
		//if(dlgUser					!= null) dlgUser.enabled = value;
		//if(dlgProject				!= null) dlgProject.enabled = value;
		//if(dlgDeliverable			!= null) dlgDeliverable.enabled = value;
		//if(dlgChangeMenu			!= null) dlgChangeMenu.enabled = value;
		//if(dlgUsers					!= null) dlgUsers.enabled = value;
		//if(dlgUploadDocument		!= null) dlgUploadDocument.enabled = value;
		//if(dlgProjectDeliverable	!= null) dlgProjectDeliverable.enabled = value;
		//if(dlgProjectPhaseComments	!= null) dlgProjectPhaseComments.enabled = value;
		//if(dlgProjectPhaseTasks		!= null) dlgProjectPhaseTasks.enabled = value;
		//if(dlgChangePassword		!= null) dlgChangePassword.visible = value;
	}
	
	private function onFactoryShowDialog(event:Event = null):void {
		vsLogin.enabled = false;
		setAllWindowsEnabled(false);
	}
	
	private function onFactoryHideDialog(event:Event = null):void {
		vsLogin.enabled = true;
		setAllWindowsEnabled(true);
	}
	
	
	private function closingApplication(event:Event):void {
		event.preventDefault();
		
		/*if(Factory.Settings.ask_hide_on_close)
		{
			Factory.MsgChoice
			(
				Factory.Text.key('ask_close_or_minimize'),'Close',
				'Close', confirmCloseHandler,
				'Minimize', confirmCloseHandler
			);
		}
		else if(Factory.Settings.close_to_tray)*/	dock();
		//else									closeApp(event);
	}
	
	private function confirmCloseHandler(event:Event):void {
		if (event.type == 'choice1Event')		closeApp(event);
		else if (event.type == 'choice2Event')	dock();
	}
	
	private function prepareForSystray(event:Event):void {
		//Retrieve the image being used as the systray icon
		dockImage = event.target.content.bitmapData;
  		//For windows systems we can set the systray props
  		//(there's also an implementation for mac's, it's similar and you can find it on the net... ;) )
		if (NativeApplication.supportsSystemTrayIcon){
			setSystemTrayProperties();
	         
			//Set some systray menu options, so that the user can right-click and access functionality
			//without needing to open the application
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = createSystrayRootMenu(true);
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu.addEventListener(Event.SELECT, onMenuSelect, false, 0, true);
			
		}
	}
	
	
	private function createSystrayRootMenu(visibleMode:Boolean):NativeMenu {
		//Add the menuitems with the corresponding actions
		var xmlMenuRoot:String = visibleMode ? 'data/traymenu_visible.xml' : 'data/traymenu_invisible.xml';
		
		mnuTray = new TMenu( readXmlFile(xmlMenuRoot) );
		
		updateMenuItems();
		
		return mnuTray;
	}
	
	
	private function setSystemTrayProperties():void{
		//Text to show when hovering of the docked application icon       
		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "Catering";
		//We want to be able to open the application after it has been docked
		SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, undock, false, 0, true);
		//Listen to the display state changing of the window, so that we can catch the minimize       
		stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, nwMinimized, false, 0, true); 
		
		if(dockImage  != null){
			//Setting the bitmaps array will show the application icon in the systray
			NativeApplication.nativeApplication.icon.bitmaps = [dockImage];
		}
	}
	
	
	private function nwMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void {
		if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED) {
			displayStateEvent.preventDefault();
			dock();
		}
	}
	
	/**
	 * hide application to system tray (minimize)
	 * */
	public function dock():void {
		stage.nativeWindow.visible = false;
		
		if (NativeApplication.supportsSystemTrayIcon){
			//setSystemTrayProperties();
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = createSystrayRootMenu(false);
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu.addEventListener(Event.SELECT, onMenuSelect, false, 0, true);
		}
		
		if(dockImage  != null){
			//Setting the bitmaps array will show the application icon in the systray
			NativeApplication.nativeApplication.icon.bitmaps = [dockImage];
		}
	}
	
	
	/**
	 * remove application from system tray (maximize)
	 * */
	public function undock(event:Event = null):void {
		//After setting the window to visible, make sure that the application is ordered to the front,
		//else we'll still need to click on the application on the taskbar to make it visible
		stage.nativeWindow.visible = true;
		
		
		if (NativeApplication.supportsSystemTrayIcon){
			//setSystemTrayProperties();
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = createSystrayRootMenu(true);
			SystemTrayIcon(NativeApplication.nativeApplication.icon).menu.addEventListener(Event.SELECT, onMenuSelect, false, 0, true);
		}
		
		stage.nativeWindow.orderToFront();
		activate();
		
		//Clearing the bitmaps array also clears the application icon from the systray
		if(Factory.Settings.hide_tray_icon_while_maximized){
			NativeApplication.nativeApplication.icon.bitmaps = [];
		}
	}
	
	
	
	
	
	/**
	 * let the taskbar entry of the application blink; like msn when you receive a message
	 * property critical:
	 * 	true:	keeps blinking
	 * 	false:	blinks once, then continuesly lights up
	 */
	public function notify(critical:Boolean=false):void {
		var type:String;
		if (critical) {
		    type = NotificationType.CRITICAL;//keeps blinking
		} else { 
		    type = NotificationType.INFORMATIONAL;//blink once, then continue light up
		}
		stage.nativeWindow.notifyUser(type);
		
	}
	
	/**
	 * set the text at the statusbar (bottom of screen)
	 * the text is cleared after the given time-out
	 * */
	public function setStatus(text:String, timeOut:int = 2000):void {
		status = text;
		statusTimer.delay = timeOut;
		statusTimer.start();
	}
	
	private function onStatusTimerTick(event:TimerEvent):void {
		status = '';
		statusTimer.stop();
	}
	
	/**
	 * read the structure of an xml file.
	 * the xml file can be given either 
	 * 	- as a string to a file on the application directory, or
	 * 	- as a File object
	 * */
	public function readXmlFile(filename:String, fileObj:File = null):XML {
		var fileStream:FileStream = new FileStream();
		if(fileObj == null){
			var file:File = File.applicationDirectory.resolvePath(filename);
			fileStream.open(file, FileMode.READ);
		}
		else {
			fileStream.open(fileObj, FileMode.READ);
		}
		var result:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
		var resultXML:XML = XML(result);
		fileStream.close();
		return resultXML;
	}
	
	public function showDashboard():void {
		//vsMain.selectedChild = vwProjectOverview;
	}
	
	/**
	 * loadPreferences() loads the initial screen position/size if set
	 * this data is stored in the application's storage dir / preferences.xml
	 * */
	private function loadPreferences():void {
		var s:FileStream = new FileStream();
		var f:File = File.applicationStorageDirectory;
		f = f.resolvePath('preferences.xml');
		
		s.addEventListener(Event.COMPLETE, onPreferencesSuccess, false, 0, true); 
		s.addEventListener(IOErrorEvent.IO_ERROR, onPreferencesFault, false, 0, true);
		
		s.openAsync(f, FileMode.READ);
	}
	
	private function onPreferencesSuccess(event:Event):void {
		var xml:XML = new XML(event.target.readUTF());
		
		stage.nativeWindow.x = int(xml.screen.@xpos);
		stage.nativeWindow.y = int(xml.screen.@ypos);
		
		stage.nativeWindow.width  = ( int(xml.screen.@width)  < 1 ? 900 : int(xml.screen.@width)  );
		stage.nativeWindow.height = ( int(xml.screen.@height) < 1 ? 600 : int(xml.screen.@height) );
		
		/*if(Boolean(xml.displayState.@minimized)) minimize();*/
		if(String(xml.displayState.@maximized).toLowerCase() == 'true') maximize();
		
		//setStatus('x=' + int(xml.@xpos)+ ' y=' + int(xml.@ypos),3000);
		
		//visible = true;
	}
	
	private function onPreferencesFault(event:Event):void {
		//visible = true;
		//setStatus('x=-1 y=-1',3000);
	}
	
	/**
	 * store window position / size in the application's storage dir / preferences.xml
	 * when window is resized, moved
	 * */
	private function updateWindow(event:Event=null):void {
		var s:FileStream = new FileStream;
		var f:File = File.applicationStorageDirectory;
		f = f.resolvePath('preferences.xml');
		
		trace('updateWindow');
		
		try {
			s.open(f, FileMode.WRITE);
			
			
			var xml:XML = 
				<root>
					<screen xpos="20" ypos="20" width="900" height="600"/>
					<displayState maximized="false" />
				</root>
			;
			
			if(event != null){
				if(event is NativeWindowDisplayStateEvent){
					//trace(NativeWindowDisplayStateEvent(event).beforeDisplayState+' - '+NativeWindowDisplayStateEvent(event).afterDisplayState);
					xml.displayState.@maximized = (NativeWindowDisplayStateEvent(event).afterDisplayState == 'maximized');
				}
				else if(event is NativeWindowBoundsEvent){
					/*trace('x: '+NativeWindowBoundsEvent(event).afterBounds.x);
					trace('y: '+NativeWindowBoundsEvent(event).afterBounds.y);
					trace('w: '+NativeWindowBoundsEvent(event).afterBounds.width);
					trace('h: '+NativeWindowBoundsEvent(event).afterBounds.height);
					trace('------')*/
					
					xml.screen.@xpos = NativeWindowBoundsEvent(event).afterBounds.x;
					xml.screen.@ypos = NativeWindowBoundsEvent(event).afterBounds.y;
					
					xml.screen.@width  = NativeWindowBoundsEvent(event).afterBounds.width;
					xml.screen.@height = NativeWindowBoundsEvent(event).afterBounds.height;
					
				}
			}
			
			/*
			xml.screen.@xpos = stage.nativeWindow.x;
			xml.screen.@ypos = stage.nativeWindow.y;
			
			xml.screen.@width  = stage.nativeWindow.width;
			xml.screen.@height = stage.nativeWindow.height;*/
			
			/*xml.displayState.@minimized = mx.core.Application.application.minimized;
			xml.displayState.@maximized = maximized;*/
			
			//setStatus('x=' + int(xml.@xpos)+ ' y=' + int(xml.@ypos),500);
			//trace('x=' + stage.nativeWindow.x+ ' y=' + stage.nativeWindow.y);
			
			s.writeUTF(xml);
			s.close();
		}
		catch(e:Error){}
	}
	
	