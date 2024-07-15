import flixel.group.FlxGroup.FlxTypedGroup;

var tween:FlxTween;
var tween2:FlxTween;

var coord:Float;

var grpOptions:FlxTypedGroup<Alphabet>;

var curSelected:Int = 0;
var iconArray:Array<AttachedSprite> = [];

var fuck:Int = 1;
var obo:Bool = false;

var boxgrp:FlxTypedGroup<FlxSprite>;

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

function create(){

    grpOptions = new FlxTypedGroup();
    add(grpOptions);

    curSelected = 0;

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
    boxgrp = new FlxTypedGroup();
    add(boxgrp);

    boxgrp.x = (-430 * curSelected) + 210;
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
}