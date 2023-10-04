package events;

import openfl.events.Event;
import ai.Mind;

/**
	OpenAI request event
**/
class MindEvent extends Event {
	public static var MIND_EVENT = "MindEvent";			// Send request to openAI
	public static var MIND_WORK_EVENT = "MindEventWRK"; // Ackknowledge response

	public var customDataZ:MindSet;		// Type of modified prompt
	public var customDataXY:String;		// Additional user information
	public var customDataD:Dynamic;		// JSon openai result

    public function new(type:String, customDataZ:MindSet, customDataXY:String, customDataD:Dynamic = null, bubbles:Bool = false, cancelable:Bool = false) {
		this.customDataZ = customDataZ;
		this.customDataXY = customDataXY;
		this.customDataD = customDataD;
		
		super(type, bubbles, cancelable);
	}

	public override function clone():MindEvent {
		return new MindEvent(type, customDataZ, customDataXY, customDataD, bubbles, cancelable);
	}

	public override function toString():String {
		return "[MindEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " customDataZ="
			+ customDataZ + " customDataXY=" + customDataXY +"]";
	}

}