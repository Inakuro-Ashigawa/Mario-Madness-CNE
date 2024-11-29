import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
var midsongVid:FlxVideoSprite;
var camvid:FlxCamera;

function create(){

    camvid = new FlxCamera();
    camvid.bgColor = 0x00000000;
    FlxG.cameras.add(camvid, false);

    if (PlayState.difficulty == "lyric")
        midsongVid = new FlxVideoSprite(213,120);
	midsongVid.load(Assets.getPath(Paths.file("videos/Funnies/paranoia.mp4")));
	midsongVid.cameras = [camvid];
	midsongVid.play();
	midsongVid.pause();
	midsongVid.bitmap.volume = 0;
        midsongVid.scale.set(1.5,1.5);
	midsongVid.alpha = 0.0001;
        add(midsongVid);
}
function videoH(){
	midsongVid.play();
	midsongVid.alpha = 1;
        camHUD.alpha = 0.001;
}
function noVid(){
	remove(midsongVid);
        camHUD.alpha = 1;
}
function onSubstateOpen(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.pause();
function onSubstateClose(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.resume();
function focusGained() if (midsongVid != null && !paused && midsongVid.alpha == 1) midsongVid.resume();