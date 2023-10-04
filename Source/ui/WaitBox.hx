package ui;


import feathers.controls.Header;
import feathers.controls.LayoutGroup;
import feathers.layout.VerticalLayout;
import feathers.controls.Label;
import feathers.controls.Panel;

/**
	Keep User waiting with a fake timer.
**/
class WaitBox extends Panel {

    var time_label:Label;

    public function new() {
        super();

        createUI();
    }

    private function createUI() {

        var group = new LayoutGroup();
        var layout = new VerticalLayout();
        layout.gap = 10.0;
        layout.setPadding(10.0);
        group.layout = layout;
        addChild(group);


        width = 300;    // Fixed size for MVP

        header = new Header("OpenAI: Waiting mind");

        group.addChild(new Label("To Lose Patience is to Lose Battle"));
        group.addChild(new Label("- Mahatma Gandhi"));

        time_label = new Label("Esimated 120s ");
        group.addChild(time_label);

        runTimer();
    }

    private function runTimer() {

        var start = 120;
        var timer = new haxe.Timer(1000); // 1000ms delay
        timer.run = function() {
            (start < 0) ? 0 : start--;

            if (time_label != null) 
                time_label.text = "Esimated: " + start + "s";
         }


    }

}
