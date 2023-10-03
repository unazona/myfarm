package events;

import openfl.events.Event;
import ai.Mind;

class MindEvent extends Event {
	public static var MIND_EVENT = "MindEvent";
	public static var MIND_WORK_EVENT = "MindEventWRK";

	public var customDataZ:MindSet;
	public var customDataXY:String;
	public var customDataD:Dynamic;

    public function new(type:String, customDataZ:MindSet, customDataXY:String, customDataD:Dynamic = null, bubbles:Bool = false, cancelable:Bool = false)
	{
		this.customDataZ = customDataZ;
		this.customDataXY = customDataXY;
		this.customDataD = customDataD;
		
		super(type, bubbles, cancelable);
	}

	public override function clone():MindEvent
	{
		return new MindEvent(type, customDataZ, customDataXY, customDataD, bubbles, cancelable);
	}

	public override function toString():String
	{
		return "[MindEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " customDataZ="
			+ customDataZ + " customDataXY=" + customDataXY +"]";
	}

}