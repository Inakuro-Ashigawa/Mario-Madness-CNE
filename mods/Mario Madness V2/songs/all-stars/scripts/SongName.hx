
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextFormat;

public var camSong:FlxCamera;
public var titleText:FlxText;
public var autorText:FlxText;
public var line1:FlxSprite;
public var line2:FlxSprite;

function create() {

    //wizards code edited
    
    camSong = new FlxCamera();
    camSong.bgColor = 0x00000000;
    FlxG.cameras.add(camSong, false);
    
    titleText = new FlxText(400, 304.5, 0, "no", 42);
    titleText.setFormat(Paths.font("mariones.ttf"), 42, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFFF42626);
    titleText.borderSize = 3;
    titleText.screenCenter(FlxAxes.X);

    var format = new FlxTextFormat(0x000000, false, false, 0xFFF42626);
    format.leading = -5;

    autorText = new FlxText(400, titleText.y + 70, 0, "All Stars    (Act 1)", 35);
    autorText.setFormat(Paths.font("mariones.ttf"), 35, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFFF42626);
    autorText.borderSize += 2;
    autorText.screenCenter(FlxAxes.X);
    autorText.addFormat(format);

    porterText = new FlxText(327.5, autorText.y - 55, 0, "nope", 22.5);
	porterText.setFormat(Paths.font("mariones.ttf"), 30, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, 0xFFF42626);
    porterText.borderColor = FlxColor.RED;
	porterText.borderSize += 2;
    porterText.screenCenter(FlxAxes.X);
    porterText.addFormat(format);

    var checkwidth:Float = autorText.width;
    if (titleText.width >= autorText.width)
        checkwidth = titleText.width;

    line2 = new FlxSprite(566, titleText.y + 57).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
    line2.screenCenter(FlxAxes.X);

    line1 = new FlxSprite(line2.x - 5, line2.y - 2).makeGraphic(Std.int(checkwidth + 10), 8, 0xFFF42626);

    for (i in [titleText, autorText, line1, line2,porterText]) {
        i.cameras = [camSong];
        i.alpha = 0;
        add(i);
    }
}

function stepHit(c)
    switch (c) {
        case 32:   showSongName("All Stars  (Act 1)", "IKENNY", "Ported by : WHISPER");
        case 1760:  showSongName("All Stars  (Act 2)", "scrumbo_");
        case 3216:  showSongName("All Stars  (Act 3)", "theWAHbox ft. RedTV53");
        case 4816:  showSongName("All Stars  (Act 4)", "RedTV53 ft. FriedFrick");
            
        case 64, 1792, 3248, 4848: hideSongName();
    }

function showSongName(topText:String, bottomText:String, porter:String) {

    titleText.text = topText;
    autorText.text = bottomText;
    porterText.text = porter;

    titleText.y = 304.5;
    autorText.y = titleText.y + 70;
    line2.y = titleText.y + 57;
    line1.y = line2.y - 2;
    
    porterText.screenCenter(FlxAxes.X);
    autorText.screenCenter(FlxAxes.X);
    titleText.screenCenter(FlxAxes.X);

    FlxTween.tween(titleText, {alpha: 1, y: titleText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(autorText, {alpha: 1, y: autorText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(line1, {alpha: 1, y: line1.y + 30}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(line2, {alpha: 1, y: line2.y + 30}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(porterText, {alpha: 1, y: line2.y + 100}, 0.5, {ease: FlxEase.cubeOut});
}

function hideSongName() {
    FlxTween.tween(titleText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(autorText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(line1, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(line2, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
    FlxTween.tween(porterText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
}
