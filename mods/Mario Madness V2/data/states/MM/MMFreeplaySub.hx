import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxObject;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

var tween:FlxTween;
var tween2:FlxTween;

var coord:Float;

var grpOptions:FlxTypedGroup<Alphabet>;

var curSelected:Int = 0;
var iconArray:Array<AttachedSprite> = [];

var fuck:Int = 1;
var obo:Bool = false;

var boxgrp:FlxTypedSpriteGroup;

var estatica:FlxSprite;
var cartel:FlxSprite;
var descText:FlxText;
var intendedColor:Int;
var colorTween:FlxTween;

var nextAccept:Int = 5;

var arrowR:FlxSprite;
var arrowL:FlxSprite;
var degR:FlxSprite;
var degL:FlxSprite;
var checkRight:FlxObject;
var checkLeft:FlxObject;
var checkBack:FlxObject;
var side:Int;
public var bloom:CustomShader;


function create(){

FlxG.sound.music.volume = 1;
FlxG.sound.music.play();
    bloom = new CustomShader("Bloom");
   grpOptions = new FlxTypedGroup();
   add(grpOptions);

    boxgrp = new FlxTypedSpriteGroup();

    curSelected = 0;


    bgFP = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/freeplay/HUD_Freeplay_2'));
    bgFP.scale.set(1.4, 1.4);
    bgFP.updateHitbox();
    bgFP.screenCenter();
    bgFP.alpha = 0;
    bgFP.scrollFactor.set(0, 0);
    bgFP.color = 0x00FF0000;
    add(bgFP);

    estatica = new FlxSprite();
    estatica.frames = Paths.getSparrowAtlas('modstuff/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.7;
    estatica.scrollFactor.set();
    estatica.updateHitbox();
    add(estatica);

    for (i in 0...canciones.length)
    {
        var char:FlxSprite = new FlxSprite(430 * fuck, 100).loadGraphic(Paths.image('modstuff/freeplay/charicon/Char' + canciones[i][2]));
        char.x -= char.width / 2;
        char.y += 270 - (char.height / 2);
        char.ID = i;
        if(i != curSelected) char.color = 0x00610000;
        boxgrp.add(char);

        fuck += 1;
    }
   add(boxgrp);
	coord = (-430 * curSelected) + 210;
	boxgrp.x = coord;
	boxgrp.y = 120;
	boxgrp.alpha = 0;
	tween = FlxTween.tween(boxgrp, {y: 0, alpha: 1}, 0.2, {ease: FlxEase.quadInOut});

    arrowL = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/freeplay/arrow'));
    arrowL.color = FlxColor.RED;
    arrowL.scale.set(0.6, 0.6);
    arrowL.flipX = true;
    add(arrowL);

    arrowR = new FlxSprite(1200, 0).loadGraphic(Paths.image('modstuff/freeplay/arrow'));
    arrowR.color = FlxColor.RED;
    arrowR.scale.set(0.6, 0.6);
    add(arrowR);

    cartel = new FlxSprite(0, 20).loadGraphic(Paths.image('modstuff/freeplay/HUD_Freeplay_1'));
    cartel.updateHitbox();
    cartel.screenCenter(FlxAxes.X);
    cartel.scrollFactor.set(0.4, 0.4);
    add(cartel);
    tween = FlxTween.tween(cartel, {y: 0}, 3, {ease: FlxEase.quadInOut, type: 4});

	descText = new FlxText(50, 620, 1180, "", 32);
	descText.setFormat(Paths.font("Mario64.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	descText.scrollFactor.set(0.4, 0.4);
	descText.updateHitbox();
	descText.screenCenter(FlxAxes.X);
	descText.borderSize = 4.4;
	add(descText);

	checkLeft = new FlxObject(-173.4, 0, 600, 1200);
	checkLeft.scrollFactor.set(0, 0);
	add(checkLeft);

	checkRight = new FlxObject(853, 0, 600, 1200);
	checkRight.scrollFactor.set(0, 0);
	add(checkRight);

	checkLeft = new FlxObject(-173.4, 0, 600, 1200);
	checkLeft.scrollFactor.set(0, 0);
	add(checkLeft);

	descText.color = FlxColor.RED;
	boxgrp.color = FlxColor.RED;
	cartel.color = FlxColor.RED;
	descText.alpha = 0;
	cartel.alpha = 0;
	tween = FlxTween.tween(descText, {alpha: 1}, 0.3, {ease: FlxEase.quadOut});
	tween = FlxTween.tween(cartel, {alpha: 1}, 0.3, {ease: FlxEase.quadOut});

	changeSelection(-0);
}
function caminar(lag:Bool = false)
	{
		// trace((-430 * curSelected) - (boxgrp.members[0].width / 2));
		coord = (-430 * curSelected) + 210;
		tween = FlxTween.tween(boxgrp, {x: coord}, 0.2, {
			ease: FlxEase.expoOut,
			onComplete: function(twn:FlxTween)
			{
				quieto = false;
			}
		});

		boxgrp.forEach(function(char:FlxSprite)
			{
				if (char.ID == curSelected)
				{
					FlxTween.tween(char, {y: 100 + (270 - (char.height / 2))}, 0.2, {ease: FlxEase.expoOut});
					FlxTween.color(char, 0.2, 0xBE610000, FlxColor.RED, {ease: FlxEase.expoOut});
				}
				else{
					if(char.color != 0xBE610000){
					FlxTween.tween(char, {y: 150 + (270 - (char.height / 2))}, 0.2, {ease: FlxEase.expoOut});
					FlxTween.color(char, 0.2, FlxColor.RED, 0xBE610000, {ease: FlxEase.expoOut});
					}
				}
			});
	}
var quieto:Bool = false;
function update(elapsed:Float){
		if (!obo)
		{
			caminar();
			obo = true;
		}

		arrowL.screenCenter(FlxAxes.Y);
		arrowR.screenCenter(FlxAxes.Y);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
			if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(checkLeft) && !quieto)
			{
				changeSelection(-1);
				caminar();
				quieto = true;
				arrowL.scale.set(0.9, 0.9);
				arrowR.scale.set(0.6, 0.6);
				FlxTween.cancelTweensOf(arrowL.scale);
				FlxTween.tween(arrowL.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.expoOut});
			}
			else if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(checkRight) && !quieto)
			{
				changeSelection(1);
				caminar();
				quieto = true;
				arrowR.scale.set(0.9, 0.9);
				arrowL.scale.set(0.6, 0.6);
				FlxTween.cancelTweensOf(arrowR.scale);
				FlxTween.tween(arrowR.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.expoOut});
			}
			else if (FlxG.mouse.justPressed && !quieto)
			{
				goToSong();
			}
		var upP = FlxG.keys.justPressed.UP;
		var downP = FlxG.keys.justPressed.DOWN;
		var leftP = FlxG.keys.justPressed.LEFT;
		var rightP = FlxG.keys.justPressed.RIGHT;
                if (!quieto)
		{
			if (upP || leftP)
			{
				changeSelection(-1);
				caminar();
				quieto = true;
			}
			if (downP || rightP)
			{
				changeSelection(1);
				caminar();
				quieto = true;
			}
			if (controls.ACCEPT && nextAccept <= 0)
			{
				goToSong();
			}
		}

		if (controls.BACK && !quieto)
		{
			curSelected = 0;
			close();
		}
		if (nextAccept > 0)
		{
			nextAccept -= 1;
		}


}
	 function unselectableCheck(num:Int)
	{
		return canciones[num].length <= 0;
	}
function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 1);
                trace(canciones[curSelected][1]);
		do
		{
			curSelected += change;
			if (curSelected < 0)
				curSelected = canciones.length - 1;
			if (curSelected >= canciones.length)
				curSelected = 0;
		}
		while (unselectableCheck(curSelected));

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (!unselectableCheck(bullShit - 1))
			{
				item.alpha = 0.6;
				if (item.targetY == 0)
				{
					item.alpha = 1;
				}
			}
		}
		descText.text = canciones[curSelected][0];
	}

function goToSong(){
	FlxG.sound.play(Paths.sound('FREEPLAY_START'), 1);
	quieto = true;
	tween.cancel();


	if (bloom != null) {
		bloom.Size = 2;
					bloom.dim = .1;

		var twn1:NumTween;
		var twn2:NumTween;

		twn1 = FlxTween.num(2, 0, 0.5, {
			onUpdate: (_) -> {
				bloom.Size = twn1.value;
			}
		});

		twn2 = FlxTween.num(0.1, 2, 0.5, {
			onUpdate: (_) -> {
				bloom.dim = twn2.value;
			}
		});

		FlxG.camera.shake(0.002, 0.2);
	}

	boxgrp.forEach(function(char:FlxSprite)
		{
			if (char.ID != curSelected){
				FlxTween.tween(char, {alpha: 0}, 1, {ease: FlxEase.quadIn});
			}else{
				FlxTween.tween(char, {alpha: 0}, 2, {startDelay: 1, ease: FlxEase.quadIn});
			}
		});

	tween = FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.2}, 2, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween){
		tween = FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.2}, 10, {ease: FlxEase.cubeInOut});
	}});
	
	tween = FlxTween.tween(estatica, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	tween = FlxTween.tween(bgFP, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	tween = FlxTween.tween(descText, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	tween = FlxTween.tween(cartel, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	FlxTween.tween(arrowL, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	FlxTween.tween(arrowR, {alpha: 0}, 1, {ease: FlxEase.quadIn});
	
	tween = FlxTween.tween(FlxG.sound.music, {volume: 0}, 0.2, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){FlxG.sound.music.stop();}});
	if (canciones[curSelected][0] == "Starman Slaughter w/Lyrics") {
		PlayState.loadWeek({
			name: canciones[curSelected][1] + "week",
			id: canciones[curSelected][1] + "week",
			sprite: null,
			chars: [null, null, null],
			songs: [for (song in ['starman-slaughter']) {name: song, hide: false}],
			difficulties: ['lyric']
		}, "lyric");
	} else if (canciones[curSelected][0] == "Paranoia w/Lyrics") {
		PlayState.loadWeek({
			name: canciones[curSelected][1] + "week",
			id: canciones[curSelected][1] + "week",
			sprite: null,
			chars: [null, null, null],
			songs: [for (song in ['paranoia']) {name: song, hide: false}],
			difficulties: ['lyric']
		}, "lyric");
	} else {
		PlayState.loadWeek({
			name: canciones[curSelected][1] + "week",
			id: canciones[curSelected][1] + "week",
			sprite: null,
			chars: [null, null, null],
			songs: [for (song in [canciones[curSelected][1]]) {name: song, hide: false}],
			difficulties: ['hard']
		}, "hard");
	}
	new FlxTimer().start(3, function() {FlxG.switchState(new PlayState());});
	trace(canciones[curSelected][1]);
} 