package ui;

import openfl.events.EventDispatcher;

import ai.Mind.MindSet;
import feathers.core.PopUpManager;
import scene.Scene;
import feathers.events.TriggerEvent;

import openfl.events.Event;
import events.MindEvent;

/**
	Handle event between UI  and running scene.
**/
class UIHandler extends EventDispatcher {
	public static var ZOOM_EVENT = "ZoomEvent";

    var scene:Scene;
    
    public function new(scene:Scene) {
        super();

        this.scene = scene;    
    }

    public function onMapButton(event:TriggerEvent):Void {
        trace("onMapButton");

        var textBox = new TextBox(this, MindSet.MindMap);
        PopUpManager.addPopUp(textBox, scene, true, true);

    }

    public function onMotionButton(event:TriggerEvent):Void {
        trace("onMotionButton");
        var textBox = new TextBox(this, MindSet.MindMotion);
        PopUpManager.addPopUp(textBox, scene, true, true);
    }

    public function onTextBox(whisper:String, mindset:MindSet):Void {
        trace('Mindset : $mindset, Whisper:$whisper');
        PopUpManager.removeAllPopUps();

        var mind = new MindEvent(MindEvent.MIND_EVENT, mindset, whisper);
        dispatchEvent(mind); // Fire event
    }

    public function onZoomButton(event:TriggerEvent):Void {
        trace("onZoomButton");
       var event = new Event(ZOOM_EVENT);
       dispatchEvent(event);
    }
}
