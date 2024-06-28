
import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.app.Application;
import openfl.text.TextFormat;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import lime.utils.Assets;

import StringTools;
var options:Array<String> = ['Notes', 'Controls', 'Preferences', 'Mario Options', 'Delete Data'];
var grpOptions:FlxTypedGroup<AlphabetTyped>;
var grpOptions = new FlxTypedGroup();

var curSelected:Int = 0;
var menuBG:FlxSprite;

var cosotexto:Array<String> = ['idk', 'sexo'];
var txtthing:String = Paths.txt('wea');
var noway:FlxText;
var noMan:FlxText;
var splitHex:Array<String>;
var splitName:Array<String>;
var cambiotexto:Int = 0;
function create(){

    FlxG.sound.playMusic(Paths.music('options'), 1);
    FlxG.camera.bgColor = 0x00FFFFFF;

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


    tornado = new FlxSprite(2280, -90);
    tornado.frames = Paths.getSparrowAtlas('modstuff/adios');
    tornado.animation.addByPrefix('idle', "adios pose", 4);
    tornado.animation.play('idle');
    tornado.scrollFactor.set();
    tornado.setGraphicSize(Std.int(tornado.width * 45));
    tornado.visible = true;
    tornado.antialiasing = false;
    tornado.updateHitbox();
    add(tornado);


    add(grpOptions);

    for (i in 0...options.length)
    {
        var optionText:FlxText = new FlxText(0, 0, 0, options[i], 32);
        optionText.setFormat(Paths.font("mariones.ttf"), 48, FlxColor.RED, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        optionText.borderSize = 4; optionText.ID = i;
        optionText.screenCenter();
        optionText.y += (100 * (i - (options.length / 2))) + 50;
        grpOptions.add(optionText);

        optionText.x -= 600+(500*i);
        FlxTween.tween(optionText, {x: optionText.x + 600+(500*i)}, .4 +(0.2*i), {ease: FlxEase.circInOut});
    }
    var verText:FlxText = new FlxText(100, 600, 1280, "Mario's Madness - Codename \nv2.0", 16);
    verText.setFormat(Paths.font("mariones.ttf"), 16, FlxColor.RED, "left");
    verText.scrollFactor.set(0.2, 0.2);
    add(verText);

    verText.alpha = 0; verText.y += 20;
    FlxTween.tween(verText, {y: verText.y - 20, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: .5});
}
function update(elapsed:Float){
    if (controls.BACK)  leave();
}
function leave(){
    FlxG.switchState(new MainMenuState());
    FlxG.sound.play(Paths.sound('cancelMenu'));
    FlxG.sound.music.stop();
    FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);
}