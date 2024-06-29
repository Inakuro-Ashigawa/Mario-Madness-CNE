
function stepHit(){
    if (curStep == 26){
       dad.playAnim("mom");
    }
    if (curStep == 52){
       defaultCamZoom = 0.8;
       strumLines.members[2].characters[0].playAnim("snitch");
       FlxTween.tween(camGame, {zoom: 1.3}, 2,  {ease: FlxEase.cubeInOut});
    }
    if (curStep == 68){
       dad.playAnim("not");
    }
    if (curStep == 110){
       boyfriend.alpha = 1;
       strumLines.members[3].characters[0].alpha = 1;
       FlxTween.tween(camGame, {zoom: .7}, 5,  {ease: FlxEase.cubeInOut});
    }
    if (curStep == 120){
        dad.playAnim("hi");
        camHUD.alpha = 1;
        iconP2.alpha = 1;
        iconP1.alpha = 1;
        healthBar.visible = true;
        timeBarBG.visible = true;
        timeBar.visible = true;
        timeTxt.visible = true;
        hudTxt.visible = true;
        for (i in cpuStrums.members) 
            FlxTween.tween(i, {alpha: 1}, .1, {ease: FlxEase.smootherStepInOut});
        for (i in playerStrums.members) 
            FlxTween.tween(i, {alpha: 1}, .1, {ease: FlxEase.smootherStepInOut});
    }
}