package ui;


import ai.Mind.MindSet;
import feathers.controls.TextInputState;
import feathers.events.TriggerEvent;
import feathers.core.PopUpManager;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.controls.TextArea;

import openfl.text.TextFormatAlign;
import feathers.text.TextFormat;
import feathers.skins.RectangleSkin;
import feathers.controls.Button;

import feathers.layout.VerticalLayout;
import feathers.controls.Label;
import feathers.controls.Panel;

import ui.UIHandler;

/**
	Get input from user.
**/
class TextBox extends Panel {

    private var handler:UIHandler; 
    private var input:TextArea;
    private var mindset:MindSet;

    public function new(handler:UIHandler, mindset:MindSet) {
        super();

        this.handler = handler;
        this.mindset = mindset;

        createUI();
    }

    private function createUI() {

        var group = new LayoutGroup();
        var layout = new VerticalLayout();
        layout.gap = 10.0;
        layout.setPadding(10.0);
        group.layout = layout;
        this.addChild(group);

        width = 300;    // Fixed size for MVP

        header = new Header("Whisper your Mind");

        group.addChild(new Label("Inspirations:"));
        group.addChild(new Label("Make a random map, use all tiles"));
        group.addChild(new Label("Generate grass only map"));
        group.addChild(new Label("Use : Land, Mud, Grass, Water "));

        input = new TextArea();
        input.text = "Generate a random map with 50% mud 60% water";

        
        input.textFormat = new TextFormat("Helvetica", 20, 0x3c3c3c);
        input.minWidth = 280;
        input.setTextFormatForState(TextInputState.FOCUSED, new TextFormat("Helvetica", 18, 0xcc0000));

        group.addChild(input);

        var ok = new Button("OK");
        group.addChild(ok);

        addChild(group);

        ok.addEventListener(TriggerEvent.TRIGGER, onOk);
        
    }

    function onOk(event:TriggerEvent) {
        // Use more clean Fire signals (MVP)
        handler.onTextBox(input.text, mindset);
    }
}
