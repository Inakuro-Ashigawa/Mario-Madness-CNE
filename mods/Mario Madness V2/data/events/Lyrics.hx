import flixel.text.FlxTextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxText.FlxTextAlign;

var camLyric:FlxCamera;

// Og Script by BCTIX New One by the Project Restoration Team
var lyricsConfig = {
	xOffset: 0,
	yOffset: 0,
	color: FlxColor.RED,
	borderColor: FlxColor.BLACK,
	font: 'mariones',
	size: 24,
	borderSize: 2,
	textSpaceMovementMult: 1, // Multiplier for how far the text history moves. make it -1 to move down
	showHistory: true
}

var textGroup:FlxTypedGroup;

function create() {

    	camLyric = new FlxCamera();
    	camLyric.bgColor = 0x00000000;
    	FlxG.cameras.add(camLyric, false);

	textGroup = new FlxTypedGroup();
	add(textGroup);
}

function onEvent(eventEvent) {
	if (eventEvent.event.name != 'Lyrics') return;

	switch (eventEvent.event.params[0]) {
		case 'Add Text':
			addText(eventEvent.event.params[1]);

		case 'Force remove all text':
			killText();

		case 'Set Color':
			lyricsConfig.color = eventEvent.event.params[2];

		case 'Set Border Color':
			lyricsConfig.borderColor = eventEvent.event.params[2];

		case 'Set Font':
			lyricsConfig.font = eventEvent.event.params[1];

		case 'Set Size':
			lyricsConfig.size = eventEvent.event.params[1];
	}
}

function addText(setText) {

	for (i in textGroup.members) {
		if (lyricsConfig.showHistory) {
			var spaceToMove = !camHUD.downscroll ? lyricsConfig.size : -1 * lyricsConfig.size;
			spaceToMove *= lyricsConfig.textSpaceMovementMult;
			FlxTween.tween(i, {alpha: i.alpha - 0.7, y: i.y - spaceToMove}, 0.3, {
				ease: FlxEase.cubeOut,
				onComplete: function(t) {
					if (i.alpha == 0) {
						textGroup.remove(i, true);
						i.destroy();
					}
				}
			});
		} else {
			textGroup.remove(i, true);
			i.destroy();
		}
	}

	var text = new FlxText(0, 500);
	text.setFormat(getFont(), lyricsConfig.size, lyricsConfig.color, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, lyricsConfig.borderColor);
	text.borderSize = lyricsConfig.borderSize;
	text.text = setText;
	text.screenCenter(FlxAxes.X);
	text.x += lyricsConfig.xOffset;
	text.y += lyricsConfig.yOffset;
	text.cameras = [camLyric];
	textGroup.add(text);
}

function getFont() {
	if (StringTools.endsWith(lyricsConfig.font, '.ttf') || StringTools.endsWith(lyricsConfig.font, '.otf'))
		return Paths.font(lyricsConfig.font);

	if (Assets.exists(Paths.font(lyricsConfig.font) + '.ttf'))
		return Paths.font(lyricsConfig.font) + '.ttf';

	if (Assets.exists(Paths.font(lyricsConfig.font) + '.otf'))
		return Paths.font(lyricsConfig.font) + '.otf';
}

function killText() {
	for (i in textGroup.members) {
		FlxTween.tween(i, {alpha: 0}, 0.3, {
			ease: FlxEase.cubeOut,
			onComplete: function(t) {
				textGroup.remove(i, true);
				i.destroy();
			}
		});
	}
}
