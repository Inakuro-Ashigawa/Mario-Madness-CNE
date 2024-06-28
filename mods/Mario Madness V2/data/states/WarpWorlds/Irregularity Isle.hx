function create(){
    bgworld2 = new FlxSprite(0, 10);
    bgworld2.frames = Paths.getSparrowAtlas('warpzone/0/bg2');
    bgworld2.setGraphicSize(Std.int(bgworld2.width * 3));
    bgworld2.animation.addByPrefix('idle', "idle", 6, false);
    bgworld2.animation.play('idle');
    bgworld2.antialiasing = false;
    bgworld2.screenCenter();
    bgworld2.y -= 11;
    bgworld2.x -= 280;
    add(bgworld2);


}