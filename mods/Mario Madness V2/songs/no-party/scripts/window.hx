import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCategory;
import openfl.Lib;

function create(){
	Lib.current.scaleX = 2.5;
	Lib.current.scaleY = 2.5;
	window.move(window.x + Std.int((window.width - 512) / 2), window.y + Std.int((window.height - 768) / 2));
	FlxG.resizeWindow(512, 768);
	FlxG.resizeGame(512, 768);
}

function destroy(){
    window.resizable = true;
    window.resize(resizex, resizey);
    FlxG.resizeWindow(resizex, resizey);
	FlxG.resizeGame(resizex, resizey);
    window.move(winX, winY);
}