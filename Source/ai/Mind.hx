package ai;

import events.MindEvent;
import openfl.events.EventDispatcher;
import openfl.Assets;

import haxe.exceptions.NotImplementedException;
import tink.core.Future;
import haxe.Json;
import haxe.Http;
import haxe.extern.EitherType;


typedef Message = {
    role: String,
    content: String
};

enum MindSet {
    MindMap;
    MindMotion;
}

typedef ChatCompletion = {
    var model:String;
    var messages:Array<Message>;

    @:optional var suffix:String;
    @:optional var max_tokens:Int;
    @:optional var temperature:Int;
    @:optional var top_p:Int;
    @:optional var n:Int;
    @:optional var stream:Bool;
    @:optional var logprobs:Int;
    @:optional var echo:Bool;
    @:optional var stop:EitherType<Array<String>, String>;
    @:optional var presence_penalty:Int;
    @:optional var frequency_penalty:Int;
    @:optional var best_of:Int;
    @:optional var logit_bias:Array<String>; //Not sure
    @:optional var user:String;
}

class Mind extends EventDispatcher
{

    public static final instance:Mind = new Mind();

    //<haxedef name="OPENAI_URL" value="42" />
    private var openai_key:String;
    private var openai_org:String;
    private var openai_model:String;

    private var api_url:String;
    
    private function new() {
        super();

        trace("Init Mind...");

        // Get the value of MY_GLOBAL_VALUE from project.xml
        openai_key = haxe.macro.Compiler.getDefine("OPENAI_KEY");
        openai_org = haxe.macro.Compiler.getDefine("OPENAI_ORG");
        api_url = haxe.macro.Compiler.getDefine("OPENAI_API");
        openai_model = haxe.macro.Compiler.getDefine("OPENAI_MODEL");
        // Keep eye on values
        trace("[OpenAI] Token : " + openai_key);
        trace("[OpenAI] Org : " + openai_org);
        trace("[OpenAI] URL : " + api_url);

        // Raise exception in case values are not set in project XML
    }

    public function createChatCompletion(completion:ChatCompletion):Dynamic {
        
        var _data:String;

        var reponse:Dynamic;

        var http = new haxe.Http(api_url);

        http.addHeader("User-Agent", "myFarm (https://narenjo.com)");
        http.addHeader("Content-Type", "application/json");
        http.addHeader("Authorization", "Bearer " + openai_key);
        //http.addHeader("OpenAI-Organization", openai_org);

        http.setPostData(haxe.Json.stringify(completion));

        http.onData = function(data:String) {
            handleMapSet(haxe.Json.parse(data));
        }

        http.onError = function(data:String) {
            reponse  = http.responseData;
            trace("Error "+reponse);
        }

        http.request(true); // Post http

        return reponse;
    }

    public function handleMapSet(result:Dynamic)
    {
        trace("genetrated map_data "+ result.choices[0].message.role);
        trace("genetrated map_data "+ result.choices[0].message.content);

        var event = new MindEvent(MindEvent.MIND_WORK_EVENT, null, null, result.choices[0].message.content);
        dispatchEvent(event);

    }

    public function testCase() {
        Assets.loadText("assets/testanswer.json").onComplete(
			function(value)  {
                handleMapSet(haxe.Json.parse(value));
            });
    }

    public function process(mindset:MindSet, text:String) {
        var system = "You are an AI assistant with specific role to generate json data based on user prompt. You output only json.";

        //testCase();
      //  return;

		Assets.loadText("assets/mapset.prompt").onComplete(
			function(value)  {
				trace("MapSet prompt loaded");

                var prompt = value + " " + text; // generate final prompt
                // Add prompt
                var whisper:Array<Message> = [
                    { role: "system", content: system },
                    { role: "user", content: prompt }
                ];

                Mind.instance.createChatCompletion(
                    {model:openai_model, messages: whisper}
                );
            }
		);
    }
}
