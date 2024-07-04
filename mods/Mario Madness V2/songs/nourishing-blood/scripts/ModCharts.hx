importScript("data/modchart/Modchart");

function beatHit(){
    if (healthBar.percent > 80)
    {
        FlxTween.angle(icoP2, -10, -20, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut});
    }
    else
    {
        icoP2.angle = 0;
    }
}
