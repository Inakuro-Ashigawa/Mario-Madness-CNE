importScript("data/modchart/Modchart");

function stepHit(curStep){
    switch curStep {
        case 726:
        FlxTween.tween(playerStrums, {x: playerStrums.x - 400}, 5, {ease: FlxEase.quadInOut, type: 4});
    }
}