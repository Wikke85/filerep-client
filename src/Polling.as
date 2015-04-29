	// ActionScript file
	
	
	private var pollTimer:Timer;
   	private var pollingInterval:int = 30;			// do polling every x seconds
	private var pollingIntervalTimer:Timer;
   	private var polling:Boolean = false;			// true if polling is running
   	private var pollingTimeOut:int = 25;			// duration before polling is timed out in seconds
   	private var pollingTimerTicksInterval:int = 10;	// timer interval: counts up to pollingTimeOut is reached in milliseconds
   	private var pollingTime:int = 0;				// how long polling is running: multiple of pollingTimerTicksInterval
   	
   	private var monitor:URLMonitor;	//checks if webservices (server) are available
   	[Bindable] public var networkStatuses:ArrayCollection = new ArrayCollection;
   	[Bindable] public var maxNetworkStatuses:int = 20;
   	
   	
   	private var previousMonitorState:Boolean = false;
	
	private function announceStatus(e:StatusEvent):void {
		var msg:String = e != null ? (", code:"+e.code+", level:"+e.level) : '';
		if(monitor.available){
			trace("Endpoint is available" + msg);
			pollingIntervalTimer.start();
			if(previousMonitorState != monitor.available) setNetworkStatus(true, true);
		}
		else {
			trace("Endpoint is unreachable" + msg);
			pollingIntervalTimer.stop();
			setNetworkStatus(false);
		}
		previousMonitorState = monitor.available;
	}
	
	//######################	Polling 	###########################
   	
   	private function onNetworkChange(event:Event=null):void {
   		if(pollTimer == null){
   			pollTimer = new Timer( pollingTimerTicksInterval );
   			pollTimer.addEventListener(TimerEvent.TIMER, pollFault, false, 0, true);
   		}
   		polling = true;
   		pollTimer.start();
		//srv.poll();
	}
	private function pollResult(event:ResultEvent):void {
		pollTimer.stop();
		if(polling){	//connection
			if(monitor.available){
				setNetworkStatus();
			}
			else {
				pollingIntervalTimer.stop();
				setNetworkStatus(false);
			}
		}
		pollingTime = 0;
		polling = false;
	}
	private function pollFault(event:Event):void {
		pollingTime += pollingTimerTicksInterval;
		if(pollingTime >= (pollingTimeOut * 1000)){
			pollTimer.stop();
			if(polling){
				if(event is FaultEvent){	//no connection
					trace('no conn '+pollingTime);
					if(monitor.available){
						setNetworkStatus();
					}
					else {
						pollingIntervalTimer.stop();
						setNetworkStatus(false);
					}
				}
				else if(event is TimerEvent){	//time out
					trace('conn timed out '+pollingTime);
					if(monitor.available){
						setNetworkStatus();
					}
					else {
						pollingIntervalTimer.stop();
						setNetworkStatus(false);
					}
				}
			}
			polling = false;
			pollingTime = 0;
		}
	}
	
	/*private var pollingStart:Date;
	private var pollingEnd:Date;
	
	private function onNetworkChange(event:Event=null):void {
   		pollingStart = new Date;
   		polling = true;
		srvBase.poll();
	}
	private function pollResult(event:ResultEvent):void {
		pollingEnd = new Date;
		if(polling){
			pollingTime = int(pollingEnd.time - pollingStart.time);
			
			trace('conn ok '+pollingTime);
			setNetworkStatus();
		}
		polling = false;
	}
	private function pollFault(event:Event):void {
		
		pollingEnd = new Date;
		
		if(polling){
			pollingTime = int(pollingEnd.time - pollingStart.time);
				
			if(event is FaultEvent){	//no connection
				trace('no conn '+pollingTime);
				setNetworkStatus();
			}
			else if(event is TimerEvent){	//time out
				trace('conn timed out '+pollingTime);
				setNetworkStatus();
			}
		}
		polling = false;
		
	}*/
	
	//######################	Polling 	###########################
	
	private function setNetworkStatus(isConnected:Boolean = true, justWentUp:Boolean = false):void {
		var pct:Number = 0;
		if(justWentUp){
			//StatusBar(statusBar).networkStatus = 'Server is online';
			trace('Server is online');
		}
		else if(isConnected){
			pct = (((pollingTimeOut * 1000) - pollingTime) / (pollingTimeOut * 1000)) * 100;
			//StatusBar(statusBar).networkStatus = 'Network status: ' + pct.toFixed(0) + '%';
			trace('Network status: ' + pct.toFixed(0) + '%');
		}
		else {
			//StatusBar(statusBar).networkStatus = 'Server is down!';
			trace('Server is down!');
		}
		networkStatuses.addItem({time: new Date, value: pct});
		if(networkStatuses.length > maxNetworkStatuses){
			networkStatuses.removeItemAt(0);
		}
	}
	
	