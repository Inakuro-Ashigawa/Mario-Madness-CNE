
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
import sys.FileSystem;
import StringTools;
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
var vid = new FlxVideoSprite();	

var bg:FlxSprite;
var bg1:FlxSprite;
var chars:FlxSprite;
var selSpr:FlxSprite;
var lineSpr:FlxSprite;
var opNum:Int = 0;
var alpOp:FlxSprite;
var songsText:FlxText;
var titleText:FlxText;
var cutText:FlxText;
var startText:FlxText;
var quieto:Bool = true;
var inCutscene:Bool = false;
var overlay:FlxSprite;
var flicker:FlxSprite;

var opUp:FlxObject;
var opDown:FlxObject;
var vid:VideoSprite;

var dumbTween:FlxTween;
var dumbTween2:FlxTween;

var cutscenes:Array<String> = ['Itsame_cutscene', 'ss_cutscene', 'post_ss_cutscene', 'ihy_cutscene', 'overdue_cutscn', 'demise_cutscene_SOUND', 'promocut', 'abandoncut'];
var cutReq:Array<Bool> = [];

var grpCut:FlxTypedSpriteGroup;
var bloom:CustomShader;
function create()
	{
        bloom = new CustomShader("Bloom");
        bloom.data.Size.value = [1, 1];
        bloom.data.dim.value = [.5, .5];
        FlxG.camera.addShader(bloom);

 		grpCut = new FlxTypedSpriteGroup();

		PlayState.isStoryMode = playCutscenes =  true;
		lerpCamZoom = true;
		camZoomMulti = 0.94;

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		bg1 = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/bg1'));
		bg1.scale.set(1.15, 1.15);
		bg1.updateHitbox();
		bg1.screenCenter();
		bg1.alpha = 0;
		add(bg1);

		chars = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/bg2'));
		chars.updateHitbox();
		chars.setPosition(750, 0);
		chars.scrollFactor.set(0.5, 0.5);
		chars.alpha = 0;
		chars.origin.set(chars.width/2, 0);
		add(chars);

		lineSpr = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/barraselect'));
		lineSpr.updateHitbox();
		lineSpr.setPosition(-2000, 220);
		lineSpr.scrollFactor.set(1.2, 1.2);
		add(lineSpr);
		

		selSpr = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/text1'));
		selSpr.updateHitbox();
		selSpr.setPosition(-50, 200);
		selSpr.scrollFactor.set(1.2, 1.2);
		selSpr.alpha = 0;
		selSpr.y += 20;
		add(selSpr);

		alpOp = new FlxSprite().makeGraphic(Std.int(selSpr.width), Std.int(selSpr.height / 2), FlxColor.BLACK);
		alpOp.updateHitbox();
		alpOp.setPosition(0, selSpr.y + Std.int(selSpr.height / 2));
		alpOp.scrollFactor.set(1.2, 1.2);
		alpOp.alpha = 0;
		add(alpOp);

		songsText = new FlxText(650, 0, 400, "vs. Super Horror Mario", 32);
		songsText.setFormat(Paths.font("mariones.ttf"), 16, FlxColor.RED, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songsText.scrollFactor.set(1, 1);
		songsText.updateHitbox();
		add(songsText);

		titleText = new FlxText(880, 0, 400, "Includes\n?????\n?????\n?????", 32);
		titleText.setFormat(Paths.font("mariones.ttf"), 16, FlxColor.RED, "right", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleText.scrollFactor.set(1, 1);
		titleText.updateHitbox();
		add(titleText);

		if(FlxG.save.data.storySave == 1) titleText.text = "Includes\nIt's-a-me\nStarman Slaughter";

		startText = new FlxText(800, 600, 400, "Press Enter to Begin", 32);
		startText.setFormat(Paths.font("mariones.ttf"), 24, FlxColor.RED, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		startText.scrollFactor.set(1, 1);
		startText.updateHitbox();
		add(startText);

		cutText = new FlxText(800, 0, 400, "CUTSCENES", 32);
		cutText.setFormat(Paths.font("mariones.ttf"), 32, FlxColor.RED, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		cutText.scrollFactor.set(1, 1);
		cutText.updateHitbox();
		cutText.visible = false;
		add(cutText);

		add(grpCut);
		grpCut.visible = false;


		for (i in 0...cutscenes.length)
			{
				var imageCut:FlxSprite = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/cutscenes/' + (i + 1)));
				imageCut.updateHitbox();
				imageCut.ID = i;

				grpCut.add(imageCut);
				imageCut.y += 100 + (150 * i);
				imageCut.x += 750; 
				if(i >= 4){
					imageCut.y -= (150 * 4);
					imageCut.x += 250;
				}

			}
		opUp = new FlxObject(selSpr.x, selSpr.y + 10, selSpr.width, Std.int(selSpr.height / 2));
		opUp.scrollFactor.set(1.2, 1.2);
		add(opUp);

		opDown = new FlxObject(selSpr.x, selSpr.y + 10 + Std.int(selSpr.height / 2), selSpr.width, Std.int(selSpr.height / 2));
		opDown.scrollFactor.set(1.2, 1.2);
		add(opDown);

		overlay = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/black_vignette'));
		overlay.scrollFactor.set(0, 0);
		overlay.updateHitbox();
		overlay.alpha = 0;
		add(overlay);
		
		
		flicker = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		flicker.scrollFactor.set(0, 0);
		flicker.updateHitbox();
		flicker.alpha = 0.1;
		add(flicker);

		bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.alpha = 0;

		FlxFlicker.flicker(flicker, 999999999999);

		FlxTween.tween(chars, {alpha: 1, y: 50}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(bg1, {alpha: 1}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(selSpr, {alpha: 1, x: 0}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(alpOp, {alpha: 0.4}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(lineSpr, {x: -100}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(songsText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(titleText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(cutText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
		FlxTween.tween(overlay, {alpha: .4}, 4, {ease: FlxEase.expoOut});
	}

var tottalTimer:Float = 0;
function update(elapsed:Float){
	tottalTimer += elapsed;

	chars.angle = 2 * Math.sin(tottalTimer/2);
	chars.offset.y = 3 * Math.sin(tottalTimer+.67);


	overlay.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
	flicker.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);

		if (controls.ACCEPT && quieto)
		{
			selectWeek();
		}
		else if(controls.ACCEPT && inCutscene){
			finishVideo();
		}

	if (controls.BACK && quieto)
	{
		PlayState.isStoryMode = false;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		leave();
	}

	WEHOVERING = false;

	if (FlxG.mouse.overlaps(opUp) && quieto)
			{
				if(opNum != 0){
				opNum = 0;
				FlxTween.cancelTweensOf(lineSpr);
				lineSpr.y = selSpr.y + 5;
				alpOp.y = selSpr.y + Std.int(selSpr.height / 2);
				lineSpr.x = -1200;
				FlxTween.tween(lineSpr, {x: -100}, 0.5, {ease: FlxEase.expoOut});
				}

				if(FlxG.mouse.justPressed && chars.visible == false){
					changeOp(0);
				}
			}
			

		if (FlxG.mouse.overlaps(opDown) && quieto)
			{
				if(opNum != 1){
				opNum = 1;
				FlxTween.cancelTweensOf(lineSpr);
				lineSpr.y = selSpr.y + Std.int(selSpr.height / 2);
				alpOp.y = selSpr.y;
				lineSpr.x = -1200;
				FlxTween.tween(lineSpr, {x: -100}, 0.5, {ease: FlxEase.expoOut});
				}

				if(FlxG.mouse.justPressed && cutText.visible == false){
					changeOp(1);
				}

	}
if(cutText.visible && quieto){

		grpCut.forEach(function(spr:FlxSprite)
			{
				spr.color = 0xFF7C0000;
				if (FlxG.mouse.overlaps(spr))
				{
					spr.color = 0xFFFFFFFF;
				}
	
				if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr)){
					quieto = false;
					startVideo(cutscenes[spr.ID]);
				}
			});
		}


}
function changeOp(option:Int){
	chars.visible = false;
	titleText.visible = false;
	songsText.visible = false;
	cutText.visible = false;
	startText.visible = false;
	grpCut.visible = false;
	FlxG.sound.play(Paths.sound('scrollMenu'), 1);
	if(option == 0){
		chars.visible = true;
		titleText.visible = true;
		songsText.visible = true;
		startText.visible = true;
	}else{
		cutText.visible = true;
		grpCut.visible = true;
	}
}

function leave(){
	FlxG.switchState(new MainMenuState());
	FlxG.sound.play(Paths.sound('cancelMenu'));
}

	function selectWeek()
	{
		quieto = false;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		FlxG.camera.flash(FlxColor.RED, 0.5);
		new FlxTimer().start(1, function(tmr:FlxTimer)
			{
		FlxG.sound.play(Paths.sound('riser'), 1);
		bloom.data.Size.value = [0];
		bloom.data.dim.value = [.8];

		var twn1:NumTween;
		var twn2:NumTween;

		twn1 = FlxTween.num(0, 2, 2, {
			onUpdate: (_) -> {
				bloom.data.Size.value = [twn1.value];
			}
		});

		twn2 = FlxTween.num(.8, 0.1, 2, {
			onUpdate: (_) -> {
				bloom.data.dim.value = [twn2.value];
			}
		});

		for (i in 0...10){
			new FlxTimer().start(0.2 * i, function(tmr:FlxTimer)
				{
					FlxG.camera.shake(0.0004 * i, 0.2);
				});
		}
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2, {ease: FlxEase.circIn});
		FlxTween.tween(FlxG.sound.music, {volume: 0}, 2, {ease: FlxEase.circIn});
                PlayState.loadWeek({
			name: "Main week",
			id: "Main week",
			sprite: null,
			chars: [null, null, null],
			songs: [for (song in ['its-a-me', 'starman-slaughter']) {name: song, hide: false}],
			difficulties: ['hard']
		}, "hard");

		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxG.camera.alpha = 0;
			FlxG.switchState(new PlayState());
		});
		});
	}
	public function startVideo(name:String)		{
		FlxTween.tween(FlxG.sound.music, {volume: 0}, 1, {ease: FlxEase.circIn});

		add(bg);
		FlxTween.tween(bg, {alpha: 1}, 1);
	
		new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				inCutscene = true;
				FlxG.camera.zoom = 1;
				vid = new FlxVideoSprite();	
				vid.load(Assets.getPath(Paths.file("videos/" + name + ".mp4")));
				vid.scrollFactor.set(0, 0);
                vid.play();
				add(vid);

				FlxG.camera.filtersEnabled = false;
            vid.bitmap.onEndReached.add(function() {    
					finishVideo();
				});
			});
			
		}

	public function finishVideo(){
		vid.destroy();
		new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				remove(bg);
				quieto = true;
			});
		FlxTween.tween(FlxG.sound.music, {volume: 1}, 1, {ease: FlxEase.circIn});
		FlxTween.tween(bg, {alpha: 0}, 1);
	}
	