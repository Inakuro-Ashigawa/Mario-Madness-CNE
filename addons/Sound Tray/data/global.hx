var lerpYPos:Float = -115;
var alphaTarget:Float = 0.0001;

var bars:Array<FlxSprite> = [];

var volumeTimer:FlxTimer;

static var camVolume:FlxCamera;

function preStateSwitch()
	FlxG.sound.soundTrayEnabled = false;

function postStateSwitch(){
	var graphicScale:Float = 0.6;

	lerpYPos = -115;
	alphaTarget = 0.0001;

	camVolume = new FlxCamera();
	camVolume.y = -115;
	camVolume.alpha = 0.0001;
	camVolume.bgColor = 0;
	FlxG.cameras.add(camVolume, false);

	bg = new FlxSprite(9, -5).loadGraphic(Paths.image("soundtray/volumebox"));
	bg.scale.set(graphicScale, graphicScale);
	bg.screenCenter(FlxAxes.X);
	bg.cameras = [camVolume];
	bg.color = FlxColor.RED;
    FlxG.state.add(bg);

    // makes an alpha'd version of all the bars (bar_10.png)
    backingBar = new FlxSprite(9, bg.y + 30).loadGraphic(Paths.image("soundtray/bars_10"));
	backingBar.alpha = 0.4;
	backingBar.screenCenter(FlxAxes.X);
    backingBar.scale.set(graphicScale, graphicScale);
	backingBar.cameras = [camVolume];
	backingBar.color = FlxColor.RED;
    FlxG.state.add(backingBar);

	bars = [];

	for (i in 1...11){
		var bar = new FlxSprite(9, backingBar.y).loadGraphic(Paths.image("soundtray/bars_" + i));
		bar.scale.set(graphicScale, graphicScale);
		bar.screenCenter(FlxAxes.X);
		bar.cameras = [camVolume];
		bar.color = FlxColor.RED;
		FlxG.state.add(bar);
		bars.push(bar);
	}

	volUp = FlxG.sound.load(Paths.sound('soundtray/Volup'));
	volDown = FlxG.sound.load(Paths.sound('soundtray/Voldown'));
	volMax = FlxG.sound.load(Paths.sound('soundtray/VolMAX'));
}

function update(){
	camVolume.y = CoolUtil.fpsLerp(camVolume.y, lerpYPos, 0.1);
	camVolume.alpha = CoolUtil.fpsLerp(camVolume.alpha, alphaTarget, 0.25);

	var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
	
	if (FlxG.sound.muted)
		globalVolume = 0;

	for (i in 0...bars.length){
		if (i < globalVolume)
			bars[i].visible = true;
		else
			bars[i].visible = false;
	}
}

function postUpdate(){
	var volDown = FlxG.sound.volumeDownKeys;
	var volUp = FlxG.sound.volumeUpKeys;
	var mutekey = FlxG.sound.muteKeys;

	if (FlxG.keys.anyJustReleased(volDown))
		vsliceSoundtray("down");
	if (FlxG.keys.anyJustReleased(volUp))
		vsliceSoundtray("up");
	if (FlxG.keys.anyJustReleased(mutekey))
		vsliceSoundtray("mute");
}

function vsliceSoundtray(keyPressed:String){
	trace("volume: " + FlxG.sound.volume);

	lerpYPos = 0;
	alphaTarget = 1;

	switch(keyPressed){
		case "down":
			volDown.stop();
			volDown.play();
		case "up":
			if (FlxG.sound.volume != 1){
				volUp.stop();
				volUp.play();
			}else{
				volMax.stop();
				volMax.play();
			}
		case "mute":
			// nothing happens here, just something to prevent a null function error
	}

	if (volumeTimer != null)
		volumeTimer.cancel();
	volumeTimer = new FlxTimer().start(2, function(){
		lerpYPos = -115;
		alphaTarget = 0.0001;
	});
}