package scene;

import openfl.events.Event;
import feathers.core.PopUpManager;
import ui.WaitBox;
import events.MindEvent;
import tile.TileWorld;
import ai.Mind;
import ui.ToolBox;
import ui.UIHandler;

/**
	Main play scene
**/
class PlayScene extends Scene {
    private var tile_world:TileWorld;
    private var tool_box:ToolBox;

    public function new() {
        super();

        tile_world = new TileWorld();

        
        addChild(tile_world);

        // Create UI on topmost
        createUI();
    }

    public function dispatchWhisper(text:String, mindset:MindSet) {
      trace("Whisper to Mind : " + text);
      trace("Mindset : " + mindset);
      
    }

    public function createUI(){
      var handler = new UIHandler(this);
      tool_box = new ToolBox(handler);
      addChild(tool_box);

      handler.addEventListener(MindEvent.MIND_EVENT, onMindEvent);
      handler.addEventListener(UIHandler.ZOOM_EVENT, onZoom);

      Mind.instance.addEventListener(MindEvent.MIND_WORK_EVENT, onMindWork);
    }

    public function onMindEvent(event:MindEvent):Void {
      trace(event.toString());

      Mind.instance.process(event.customDataZ, event.customDataXY);

      var textBox = new WaitBox();
      PopUpManager.addPopUp(textBox, this, true, true);
    }
    
    public function onMindWork(event:MindEvent) {
      PopUpManager.removeAllPopUps();

      trace("MindWork "+event.customDataD);  // Received fresh map data

      tile_world.initTilesFromWork(event.customDataD);  // Refresh new tiles
    }

    public function onZoom(event:Event) {
      trace("onZoom");

      tile_world.zoomInOrOut();
    }
}
