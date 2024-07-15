function postCreate(){
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 0;
    add(blackBarThingie);

    healthBar.createFilledBar(FlxColor.fromRGB(255, 255, 255), FlxColor.fromRGB(0, 0, 0));
    healthBar.updateFilledBar();
    healthBar.updateBar();

    timeBar.createFilledBar(0xFF000000, 0xFFF42626);
    timeBar.numDivisions = 800;

    //healthBarBG.color = FlxColor.WHITE;

    for (i in [timeBar, timeBarBG, timeTxt, botplayTxt,hudTxt])
        i.color = FlxColor.WHITE;
    
}
function events(event){
    if (event == "gf"){
        FlxTween.tween(gf, {y: gf.y - 450}, 1, {ease: FlxEase.quadOut});
    }
}