importScript("data/modchart/Modchart");

function stepHit(curStep){
    switch curStep {
        case 724:
            for (i in playerStrums.members){
                i.x = i.x + -300;
                FlxTween.tween(i, {x: i.x - 400}, 1, {ease: FlxEase.quadInOut, type: 4});
            }
    }
}