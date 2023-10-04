package ui;

import feathers.events.TriggerEvent;
import feathers.core.PopUpManager;
import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import openfl.text.TextFormatAlign;
import feathers.text.TextFormat;
import feathers.skins.RectangleSkin;
import feathers.controls.Button;

import feathers.layout.VerticalLayout;
import feathers.controls.Label;
import feathers.controls.Panel;

/**
	Expose Tools to user.
**/
class ToolBox extends Panel {

    var handler:UIHandler; 

    public function new(handler:UIHandler) {
        super();

        this.handler = handler;

        // Add Vertical layout to toolbox
        layout = new VerticalLayout();

        createUI();                
    }

    function createUI() {
        var group = new LayoutGroup();
        var layout = new VerticalLayout();
        layout.gap = 20.0;
        layout.setPadding(20.0);
        group.layout = layout;
        this.addChild(group);

        
        var title = new Label();
        title.text = "AI-Tools";
        title.textFormat = new TextFormat(null, 18, 0xFFFFFF, true, null, null, 
                                          null, null, TextFormatAlign.CENTER);
        group.addChild(title);

        var mapButton = new Button();
        mapButton.text = "Map";
        group.addChild(mapButton);
        
        var motionButton = new Button();
        motionButton.text = "Motion";
        group.addChild(motionButton);


        title = new Label();
        title.text = "Tools";
        title.textFormat = new TextFormat(null, 18, 0xFFFFFF, true, null, null, 
                                          null, null, TextFormatAlign.CENTER);
        group.addChild(title);
        var zoomButton = new Button();
        zoomButton.text = "Zoom In/Out";
        group.addChild(zoomButton);

        backgroundSkin = get_skin();

        // add events
        mapButton.addEventListener(TriggerEvent.TRIGGER, handler.onMapButton);
        motionButton.addEventListener(TriggerEvent.TRIGGER, handler.onMotionButton);
        zoomButton.addEventListener(TriggerEvent.TRIGGER, handler.onZoomButton);
    }

    function get_skin(): RectangleSkin {
        var skin = new RectangleSkin();
        skin.border = SolidColor(1.0, 0x000000);
        skin.fill = SolidColor(0x35637C);
        skin.width = 100.0;
        skin.height = 600.0;

        return skin;
    }
}