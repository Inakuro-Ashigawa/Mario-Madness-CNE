import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;

var autor:String = "";
var porter:String = "";
var camSong = new FlxCamera();
var gbcolor:FlxColor = 0xFFF42626;
var txtcolor:FlxColor = FlxColor.RED;
var format = new FlxTextFormat(0x000000, false, false, gbcolor);

function create(){

    titleText = new FlxText(400, 350.4, 0, PlayState.SONG.meta.displayName, 42);
	titleText.setFormat(Paths.font("mariones.ttf"), 42, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
	titleText.borderSize = 3;
    titleText.borderColor = FlxColor.RED;
    if(FlxG.save.data.callLuigi)
        titleText.borderColor = 0xFF25cd49;
    else
        titleText.borderColor = txtcolor;
    titleText.cameras = [camSong];
	titleText.screenCenter(FlxAxes.X);
	titleText.alpha = 0;
	add(titleText);

	autorText = new FlxText(375, titleText.y - 70, 0, autor, 35);
	autorText.setFormat(Paths.font("mariones.ttf"), 35, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
	autorText.borderSize += 2;
    if(FlxG.save.data.callLuigi)
        autorText.borderColor = 0xFF25cd49;
    else
        autorText.borderColor = txtcolor;
    autorText.cameras = [camSong];
    autorText.screenCenter(FlxAxes.X);
	autorText.alpha = 0;
	add(autorText);

    porterText = new FlxText(327.5, autorText.y - 55, 0, porter, 22.5);
	porterText.setFormat(Paths.font("mariones.ttf"), 22.5, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, gbcolor);
    if(FlxG.save.data.callLuigi)
        porterText.borderColor = 0xFF25cd49;
    else
        porterText.borderColor = txtcolor;
	porterText.borderSize += 2;
    porterText.cameras = [camSong];
    porterText.screenCenter(FlxAxes.X);
	porterText.alpha = 0;
	add(porterText);

    var checkwidth:Float = autorText.width;

    if (titleText.width >= autorText.width)
    {
        checkwidth = titleText.width;
    }


    titleLine2 = new FlxSprite(566, titleText.y + 57).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
    titleLine2.cameras = [camSong];
    titleLine2.screenCenter(FlxAxes.X);
    titleLine2.alpha = 0;

    titleLine1 = new FlxSprite(titleLine2.x - 5, titleLine2.y - 2).makeGraphic(Std.int(checkwidth + 10), 8, gbcolor);
    if(FlxG.save.data.callLuigi)
        titleLine1.color = 0xFF25cd49;
    else
        titleLine1.color = gbcolor;
    titleLine1.cameras = [camSong];
    titleLine1.alpha = 0;
    add(titleLine1);
    add(titleLine2);

    porterLine2 = new FlxSprite(566, titleText.y - 84).makeGraphic(Std.int(Math.max(autorText.width, autorText.width)), 5, FlxColor.BLACK);
    porterLine2.cameras = [camSong];
    porterLine2.screenCenter(FlxAxes.X);
    porterLine2.alpha = 0;

    porterLine1 = new FlxSprite(porterText.x - 5, porterText.y - 2).makeGraphic(Std.int(Math.max(autorText.width + 10, porterText.length + 1000)), 8, gbcolor);
    if(FlxG.save.data.callLuigi)
        porterLine1.color = 0xFF25cd49;
    else
        porterLine1.color = gbcolor;
    porterLine1.cameras = [camSong];
    porterLine1.alpha = 0;


    camSong.bgColor = 1;
    camSong.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camSong, false);
}

function update(){
    // mfw when upscroll players - apurples, a downscroll player
    if (!downscroll){
        autorText.y = titleText.y + 70;
        porterText.y = autorText.y + 55;
    }
}

function onEvent(_){
    if (_.event.name == "Show Song" && _.event.params[0]){
        autorText.text = _.event.params[1];
        porterText.text = "Ported by: " + _.event.params[2];
        porterText.scale.set(_.event.params[3], _.event.params[3]);
        window.title = "Friday Night Funkin': Mario's Madness | " + PlayState.SONG.meta.displayName + " | " + autorText.text + " | " + porterText.text;
        for (i in [autorText, porterText]) i.screenCenter(FlxAxes.X);
        for (i in [titleText, autorText, porterText, titleLine1, titleLine2, porterLine1, porterLine2]){
            if (downscroll) FlxTween.tween(i, {alpha: 1, y: i.y + 30}, 0.5, {ease: FlxEase.cubeOut});
            else FlxTween.tween(i, {alpha: 1, y: i.y - 30}, 0.5, {ease: FlxEase.cubeOut});
        }

        new FlxTimer().start(_.event.params[4], function (tmr:FlxTimer){
            for (i in [titleText, autorText, porterText, titleLine1, titleLine2, porterLine1, porterLine2]) FlxTween.tween(i, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
        });
    }
}