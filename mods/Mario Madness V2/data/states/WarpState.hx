import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import funkin.backend.utils.DiscordUtil;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.ValueException;
import lime.utils.Assets;
import openfl.Lib;
import openfl.desktop.Clipboard;
import openfl.filters.ShaderFilter;
import StringTools;


var tween:FlxTween;
var tween2:FlxTween;
var thetimer:FlxTimer;
var curSelected:Int = 0;
var worldSelected:Int = 0;
var unlockpath:Bool = false;
var time:Float = 1;
var world:Int = 0;
var startCut:Bool = false;
var isWarp:Bool = false;
var pipeCut:Bool = false;
var isPico:Bool = false;
var curDeg:Int = 0;
var debugmode:Bool = false;
var quieto:Bool = false;
var canPress:Bool = false;
var whatsong:String = '';
var blackScreen:FlxSprite;
final starNeed:Array<Int> = [3, 7, 5, 6, 3];

var grpOptions:FlxTypedSpriteGroup<AlphabetTyped>;
var iconArray:Array<AttachedSprite> = [];

var canciones = [
    // Name, 				UP, DOWN, LEFT, RIGHT
    ['Start', 				'X', 'X', 'X', '1'],
    ['Irregularity Isle',		'X', 'X', '0', '2'],
    ['Woodland of Lies',	'X', 'X', '1', '3'],
    ['Content Cosmos',			'X', 'X', '2', '4'],
    ["Hellish Heights", 	'X', 'X', '3', '5'],
    ['Classified Castle',	'X', 'X', '4', 'X']
];

var starPos:Array<Dynamic> = [
    [435, 298],
    [528, 310],
    [624, 310],
    [720, 310],
    [816, 310],
    [912, 310],
];

var bg:FlxSprite;
var bgworld:FlxSprite;
var introBox:FlxSprite;
var introButton:FlxSprite;
var bfAnim1:FlxSprite;
var pibemapa:FlxSprite;
var bgWarps:FlxSprite;
var gameLives:FlxSprite;
var cartel:FlxSprite;
var descText:FlxText;
var worldText:FlxText;
var screenText:FlxText;

var hubDots:FlxTypedGroup<FlxSprite>;
var hubDots = new FlxTypedGroup();


var CRT:CustomShader = null;
var world:CustomShader = null;

function create()
	{
		#if desktop
		// yes it changes
        DiscordUtil.changePresence('In the Overworld', "");

		window.title = "Friday Night Funkin': Mario's Madness";

		var backbg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);

    	CRT = new CustomShader("VCR");
		CRT.distortionOn = false;
		CRT.vignetteMoving = false;
		CRT.glitchModifier = 0;
		//camera.addShader(CRT);

		world = new CustomShader("MosaicShader");
		world.data.uBlocksize.value = [.7, .7];
		camera.addShader(world);

		FlxG.sound.music.stop();

		bg = new FlxSprite(0, 0);
		bg.frames = Paths.getSparrowAtlas('warpzone/0/water_hub');
		bg.animation.addByPrefix('idle', "water hub idle", 6);
		bg.animation.play('idle');
		bg.setGraphicSize(Std.int(bg.width * 3));
		bg.antialiasing = false;
		bg.screenCenter();
		add(bg);

		bgworld = new FlxSprite(0, 0);
		bgworld.loadGraphic(Paths.image('warpzone/0/world'));
		bgworld.setGraphicSize(Std.int(bgworld.width * 3));
		bgworld.antialiasing = false;
		bgworld.screenCenter();
		add(bgworld);

		bgWarps = new FlxSprite(0, 0);
		bgWarps.frames = Paths.getSparrowAtlas('warpzone/0/hub_path');
		bgWarps.setGraphicSize(Std.int(bgWarps.width * 3));
		bgWarps.updateHitbox();
		bgWarps.screenCenter();
		bgWarps.antialiasing = false;
		bgWarps.y = Std.int(bgWarps.y);
		add(bgWarps);

        for (i in 0...canciones.length)
            {
                var dot:FlxSprite = new FlxSprite(starPos[i][0], starPos[i][1]);
                dot.frames = Paths.getSparrowAtlas('warpzone/star');
                if(i == 0){

                        dot.frames = Paths.getSparrowAtlas('warpzone/pipegray');
                    }
                
                
                dot.antialiasing = false;
                dot.setGraphicSize(Std.int(dot.width * 3));
                dot.ID = i;
                dot.animation.addByPrefix("anim", "idle", 6, true);
                dot.animation.addByPrefix("sleep", "sleep", 6, true);
                dot.animation.play("anim");
    
                if(i >= 2){
    
                }
    
                hubDots.add(dot);
            }
            add(hubDots);

        pibemapa = new FlxSprite(400, 251);
		var deadSuffix = '';
		if(FlxG.save.data.storySave = 7) deadSuffix = 'dead_';
		pibemapa.frames = Paths.getSparrowAtlas('warpzone/' + deadSuffix + 'overworld_bf');
		pibemapa.animation.addByPrefix('idle', "overworld bf walk down", 6);
		pibemapa.animation.addByPrefix('up', "overworld bf walk up", 6);
		pibemapa.animation.addByPrefix('down', "overworld bf walk down", 6);
		pibemapa.animation.addByPrefix('left', "overworld bf walk left", 6);
		pibemapa.animation.addByPrefix('right', "overworld bf walk right", 6);
		pibemapa.animation.addByPrefix('start', "overworld bf level start", 6);
		pibemapa.animation.add('warp', [0, 5, 9, 13], 10);
		pibemapa.animation.play('idle');
		pibemapa.setGraphicSize(Std.int(pibemapa.width * 3));
		pibemapa.antialiasing = false;
		pibemapa.visible = false;
		pibemapa.updateHitbox();
		add(pibemapa);

		bfAnim1 = new FlxSprite(412, 230);
		bfAnim1.frames = Paths.getSparrowAtlas('warpzone/bfAnims/bfoverworldintro');
		bfAnim1.animation.addByIndices('nothing', "bfoverworldintro idle", [0], "", 6);
		bfAnim1.animation.addByPrefix('idle', "bfoverworldintro idle", 12, false);
		bfAnim1.animation.play('nothing');
		bfAnim1.setGraphicSize(Std.int(bfAnim1.width * 3));
		bfAnim1.antialiasing = false;
		bfAnim1.updateHitbox();
		bfAnim1.visible = true;
		add(bfAnim1);

		gameLives = new FlxSprite(0, 0);
		gameLives.frames = Paths.getSparrowAtlas('warpzone/overworld_overlay');
		gameLives.animation.addByPrefix('idle', "overworld overlay idle", 6);
		gameLives.animation.play('idle');
		gameLives.setGraphicSize(Std.int(gameLives.width * 3));
		gameLives.antialiasing = false;
		gameLives.updateHitbox();
		gameLives.screenCenter();
		add(gameLives);

        var blackBar0:FlxSprite = new FlxSprite().makeGraphic(500, FlxG.height, FlxColor.BLACK);
		blackBar0.alpha = 1;
		blackBar0.x = -244;
		blackBar0.scrollFactor.set(0, 0);
		add(blackBar0);

		var blackBar1:FlxSprite = new FlxSprite().makeGraphic(500, FlxG.height, FlxColor.BLACK);
		blackBar1.alpha = 1;
		blackBar1.x = 1024;
		blackBar1.scrollFactor.set(0, 0);
		add(blackBar1);

		descText = new FlxText(0, 20, 400, "DEBUG", 16);
		descText.visible = false;
		add(descText);

		worldText = new FlxText(0, 200, 400, "DEBUG2", 16);
		worldText.visible = false;
		add(worldText);

		screenText = new FlxText(515, 70, 400, "Start", 16);
		screenText.setFormat(Paths.font("smwWORLDS.TTF"), 24, FlxColor.BLACK, "left");
		add(screenText);

		introBox = new FlxSprite(0, 0);
		introBox.loadGraphic(Paths.image('warpzone/bfintro'));
		introBox.setGraphicSize(Std.int(introBox.width * 3));
		introBox.updateHitbox();
		introBox.antialiasing = false;
		introBox.screenCenter();
		introBox.y = Std.int(introBox.y);
		introBox.visible = false;
		add(introBox);

		introButton = new FlxSprite(884, 603);
		introButton.frames = Paths.getSparrowAtlas('warpzone/enter');
		introButton.animation.addByPrefix('appear', "enter appear", 12, false);
		introButton.animation.addByPrefix('press', "enter press", 12);
		introButton.animation.play('appear');
		introButton.setGraphicSize(Std.int(introButton.width * 3));
		introButton.antialiasing = false;
		introButton.visible = false;
		add(introButton);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 1;
		add(blackScreen);

		for (i in 0...6)
			{
				new FlxTimer().start(0.1 * i, function(tmr:FlxTimer)
					{
						blackScreen.alpha -= 0.2;
						if(i == 5){
							if(!startCut){
							quieto = true;
							}
						}
					});
				
			}

		if(startCut){
			quieto = false;
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxG.sound.play(Paths.sound('owCuts/yea'));
					bfAnim1.animation.play('idle');
                    startCut = false;
				});
			new FlxTimer().start(1.7, function(tmr:FlxTimer)
				{
					pibemapa.visible = true;
					bfAnim1.visible = false;
					var boxy:Float = introBox.y;
					introBox.scale.y = 0.001;
					introBox.scale.x = 0.001;
					introBox.visible = true;
					new FlxTimer().start(0.5, function(tmr:FlxTimer)
						{
							FlxG.sound.play(Paths.sound('message'));
						});
					FlxTween.tween(introBox.scale, {y: 3, x: 3}, 0.5, {ease: FlxEase.backOut, startDelay: 0.5, onComplete: function(twn:FlxTween)
						{
							new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									FlxG.sound.play(Paths.sound('owCuts/enter'));
									introButton.animation.play('appear');
									introButton.visible = true;
									canPress = true;
                                    
								});
						}
					});
				});
		}else{
			startCut = false;
			pibemapa.visible = true;
			bfAnim1.visible = false;
			FlxG.sound.playMusic(Paths.music('warpzone/0'), 0);
			FlxG.sound.music.fadeIn(1, 0, 0.5);
		}
    }
var zero = 0;
    function update(elapsed:Float)
    {
        zero += elapsed;
	CRT.iTime = zero;

                if (controls.BACK)
					{
						isWarp = false;
						FlxG.sound.music.stop();
						FlxG.sound.play(Paths.sound('cancelMenu'));
                        FlxG.switchState(new MainMenuState());
					}

                if (quieto)
                {
                    if (controls.ACCEPT) goToWorld();
    
                    if (FlxG.keys.justPressed.LEFT)
                    {
                        quieto = false;
                        caminar(canciones[curSelected][3]);
                    }
                    else if (FlxG.keys.justPressed.RIGHT)
                    {
                        quieto = false;
                        caminar(canciones[curSelected][4]);
                    }
    
                    // NORMAL
                } 
        if (controls.ACCEPT && canPress && startCut)
            {
                canPress = false;
                introButton.animation.play('press');
                FlxG.sound.play(Paths.sound('accept'));
                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                    {
                        quieto = true;
                        startCut = false;
                        introButton.visible = false;
                        FlxG.sound.playMusic(Paths.music('warpzone/0'), 0);
                        FlxG.sound.music.fadeIn(1, 0, 0.5);
                    });
                FlxTween.tween(introBox, {y: 720}, 1, {ease: FlxEase.backIn, startDelay: 0.5});
            }
        }
function caminar(direction:String)
	{
		trace(direction);
		if(direction != 'X'){
		var dir:Int = Std.parseInt(direction);
		quieto = false;
		curSelected = dir;
		animStart(curSelected, 0, 0, pibemapa, true);
		var lascord:Array<Float> = getCoords(curSelected, 0);

		//pibeTween = losTweens[0];

		if (pibemapa.x >= lascord[0]){
			pibemapa.animation.play('left');
		}
		else{
			pibemapa.animation.play('right');
		}
		
		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			if(curSelected >= 2){
					screenText.text = canciones[curSelected][0].toUpperCase();
				}
				screenText.text = canciones[curSelected][0].toUpperCase();
			FlxG.sound.play(Paths.sound('owCuts/wz_move'));
			pibemapa.animation.play('idle');
			quieto = true;
        });
		}
		else
			quieto = true;
    }
	
	function getCoords(nextPos:Int, curWorld:Float):Array<Float>
        {
            var x:Float = 0;
            var y:Float = 0;
            var theY:Array<Float> = [0];
            var theX:Array<Float> = [0];
    
            switch(curWorld){
                case 0:
                    theY = [251, 251, 251, 251, 251, 251];
                    theX = [400, 496, 592, 688, 784, 880];
            }
        var thecoords:Array<Float> = [theX[nextPos], theY[nextPos]];

        return thecoords;
		}
function animStart(nextDir:Int, lastDir:Float, curWorld:Float, pibe:FlxSprite, iswalk:Bool)
    {
        var coords:Array<Float> = getCoords(nextDir, curWorld);
        var x:Float = coords[0];
        var y:Float = coords[1];
        var anim:Int = 0;

        var theTweenX:FlxTween;
        var theTweenY:FlxTween;

        switch(curWorld){

            case 0: //!WORLD 0
                theTweenX = FlxTween.tween(pibe, {x: x}, 0.8);
            
    }
}
function goToWorld(){
 if(curSelected == 1){
    FlxG.switchState(new ModState("WarpWorlds/Irregularity Isle"));      
 }
}