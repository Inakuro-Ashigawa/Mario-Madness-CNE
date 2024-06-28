
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
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

var grpCut:FlxTypedGroup<FlxSprite>;
var grpCut = new FlxTypedGroup();

function create()
	{
		PlayState.isStoryMode = true;
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

		titleText = new FlxText(920, 0, 400, "Includes\n?????\n?????\n?????", 32);
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

		grpCut.visible = false;

		add(grpCut);

		for (i in 0...cutscenes.length)
			{
				var imageCut:FlxSprite = new FlxSprite().loadGraphic(Paths.image('modstuff/storymode/cutscenes/' + (i + 1)));
				imageCut.updateHitbox();
				imageCut.ID = i;

				if(cutReq[i])grpCut.add(imageCut);
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

	}

}
function leave(){
	FlxG.switchState(new MainMenuState());
	FlxG.sound.play(Paths.sound('cancelMenu'));
}