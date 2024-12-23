import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import FlxG;
import lime.utils.Assets;
import openfl.utils.Assets;
import PlayState;
import funkin.game.StrumLine;
import flixel.tweens.FlxTweenType;

var pauseCam = new FlxCamera();
var bg:FlxSprite;
var menuItems:Array<String> = ['Resume', 'Restart', 'Botplay','Exit'];
var curSelected:Int = 0;
var num:NumTween;
var staticShader:CustomShader = null;
var modeTxt:FlxText;
var songandcredits:FlxText;
var desctext:FlxText;
var txtdesc:String;
var songName = PlayState.SONG.meta.displayName;
var author = PlayState.SONG.meta.author;
var funni:Array<String> = [];

function create(event) {
    event.cancel();
    event.music = "mario/mario-time" + Std.string(FlxG.random.int(1,3));

    cameras = [];

    FlxG.cameras.add(pauseCam, false);

    pauseCam.bgColor = 0x88000000;
    pauseCam.alpha = 0;

    bg = new FlxSprite(-400,0).loadGraphic(Paths.image("menus/MMpausemenu/momichi"));
    bg.cameras = [pauseCam];
    bg.alpha = 0;
    add(bg);

    modeTxt = new FlxText(566, 31,0,"",17);
    modeTxt.alpha = 0;
    modeTxt.setFormat(Paths.font("mariones.ttf"),17,FlxColor.WHITE, "Center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    add(modeTxt);
    if (PlayState.isStoryMode){
	modeTxt.text = "Story Mode";
    }else if (PlayState.isWarp){
	modeTxt.text = "Warp Zone";
    }else{
	modeTxt.text = "Freeplay";
    }

    desctext = new FlxText(566, 271, 0, "", 12);
    desctext.text = "Description";
    desctext.alpha = 0;
    desctext.setFormat(Paths.font("mariones.ttf"), 17);
    add(desctext);

    line1 = new FlxSprite(566, modeTxt.y + 30).makeGraphic(630, 3, FlxColor.WHITE);
    line1.alpha = 0;
    add(line1);

    line2 = new FlxSprite(566, desctext.y + 30).makeGraphic(630, 3, FlxColor.WHITE);
    line2.alpha = 0;
    add(line2);

    txtdesc = Paths.txt("desc/" + songName);
    if (muymalo > 1){
        txtdesc = Paths.txt('desc/' + songName + muymalo);
    }
    else
    {
        txtdesc = Paths.txt('desc/' + songName);
    }
    funni = CoolUtil.coolTextFile(txtdesc);

    descAll = new FlxText(566, desctext.y + 40, 700, "", 12);
    descAll.text = funni[0];
    descAll.alpha = 0;
    descAll.setFormat(Paths.font("mariones.ttf"), 17);
    add(descAll);

    title = new FlxText(566, modeTxt.y + 40, 700, songName, 22);
    title.setFormat(Paths.font('mariones.ttf'), 22);
    title.alpha = 0;
    title.scrollFactor.set();
    title.updateHitbox();
    add(title);

    levelDifficulty = new FlxText(566, modeTxt.y + 60, 700, "", 32);
    levelDifficulty.text = "\n" + author;
    levelDifficulty.alpha = 0;
    levelDifficulty.scrollFactor.set();
    levelDifficulty.setFormat(Paths.font('mariones.ttf'), 17);
    levelDifficulty.updateHitbox();
    add(levelDifficulty);

    creditsTxt = new FlxText(566, levelDifficulty.y + 60, 700, "", 12);
    creditsTxt.text = funni[1];
    creditsTxt.alpha = 0;
    creditsTxt.setFormat(Paths.font("mariones.ttf"), 17);
    add(creditsTxt);

    botplaytxt = new FlxText(1150,690,0,"Botplay", 17);
    botplaytxt.alpha = FlxG.save.data.botplayOption ? 1 : 0;
    botplaytxt.setFormat(Paths.font("mariones.ttf"), 17);
    add(botplaytxt);

    for (q in [bg,modeTxt,descAll,desctext,creditsTxt,line1,line2,title,levelDifficulty]) {
        FlxTween.tween(q, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
    }

    grpMenuShit = new FlxTypedGroup();
	add(grpMenuShit);

    for (i in 0...4) {
        var option = menuItems[i];
        var button = new FlxSprite(-252,(130 * i) + 100); //25
        button.scale.set(0.5,0.5);
        button.frames = Paths.getFrames('menus/MMpausemenu/'+ option);
        button.animation.addByPrefix("idle", option + " basic", 24, false);
        button.animation.addByPrefix("Selected", option + " white", 24, false);
        button.animation.play("idle");
        button.ID = i;
        grpMenuShit.add(button);
        button.antialiasing = true;
        button.updateHitbox();
    }
    grpMenuShit.members[1].alpha = 0.6;
    grpMenuShit.members[2].alpha = 0.6;
    grpMenuShit.members[3].alpha = 0.6;
    FlxTween.tween(bg, {x:-200}, 1, {ease:FlxEase.circOut});
    for (i in grpMenuShit.members) {
        FlxTween.tween(i, {x:25}, 1, {ease:FlxEase.circOut});
    }

    cameras = [pauseCam];
}

function destroy() {
	FlxG.cameras.remove(pauseCam);
}

var canDoShit = true;
var time:Float = 0;
function update(elapsed:Float) {
    pauseCam.alpha = lerp(pauseCam.alpha, 1, 0.25);
    time +- elapsed;

    if (!canDoShit) return;
	var oldSec = curSelected;
	if (controls.DOWN_P)
		changeSelection(1, false);
	if (controls.UP_P)
		changeSelection(-1);

	if (oldSec != curSelected) {
        FlxG.sound.play(Paths.sound("MMpausemenu/scroll"));
	}

    if (controls.ACCEPT) {
		var option = menuItems[curSelected];
		if (option == "Resume" || option == "Exit") {
            grpMenuShit.members[curSelected].animation.play("Selected");
			canDoShit = false;
            FlxTween.tween(bg, {x:-400}, 1, {ease:FlxEase.circOut});
            for (i in grpMenuShit.members) {
                FlxTween.tween(i, {x:-252}, 1, {ease:FlxEase.circOut});
            }
			FlxTween.tween(bg, {alpha: 0}, 0.125, {ease: FlxEase.cubeOut, onComplete: function() {
				selectOption();
			}});
		} else if (option == "Restart") {
            grpMenuShit.members[curSelected].animation.play("Selected");
            blink();
            FlxG.sound.play(Paths.sound("MMpausemenu/restart"));
            new FlxTimer().start(1, () -> {selectOption();}, 1);
            canDoShit = false;
        } else if (option == "Botplay") {
            grpMenuShit.members[curSelected].animation.play("Selected");
            selectOption();
            new FlxTimer().start(0.2, () -> {grpMenuShit.members[curSelected].animation.play("idle");}, 1);
        } else {
            grpMenuShit.members[curSelected].animation.play("Selected");
			selectOption();
		}
	}

}

function blink() {
    num = FlxTween.num(1, 0, 0.1, {ease:FlxEase.circInOut, type: FlxTweenType.PINGPONG, onUpdate: (_) -> {
        grpMenuShit.members[curSelected].alpha = num.value;
        if (num.value) grpMenuShit.members[curSelected].animation.play("Selected");
        if (num.value == 1) grpMenuShit.members[curSelected].animation.play("idle");
    }});
}

function selectOption() {
	var event = EventManager.get(NameEvent).recycle(menuItems[curSelected]);
	pauseScript.call("onSelectOption", [event]);

	if (event.cancelled) return;

	var daSelected:String = event.name;

	switch (daSelected)
	{
		case "Resume":
			close();
		case "Restart":
			parentDisabler.reset();
			PlayState.instance.registerSmoothTransition();
			FlxG.resetState();
		case "Botplay":
            if (FlxG.save.data.ShowPsychUI) {
                FlxG.save.data.callLuigi = !FlxG.save.data.callLuigi;
            }
            //player.cpu = !player.cpu; Imma figure out why this doesn't work (Yes I have tried putting PlayState.player.cpu)
		case "Exit":
			CoolUtil.playMenuSong();
			FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
	}
}

function changeSelection(change:Int = 0):Void {
		var event = EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + change, 0, menuItems.length-1), change, change != 0);
		pauseScript.call("onChangeItem", [event]);
		if (event.cancelled) return;

		curSelected = event.value;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.ID = bullShit - curSelected;
			bullShit++;

			if (item.ID == 0)
				item.alpha = 1;
			else
				item.alpha = 0.6;
		}
}