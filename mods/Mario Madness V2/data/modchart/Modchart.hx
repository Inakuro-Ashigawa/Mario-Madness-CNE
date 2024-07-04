// you probably dont need these but still importing just to be safe lol
import funkin.game.StrumLine;
import funkin.game.Strum;
import funkin.game.Note;



/*
 *  THE CREDITS:
 *      - syrup
 *          creator of modchart system
 *      
 * 
 *  that's really about it lmfao
*/

/**
 *   To do:
 *   - fix offsets when hitting notes while shake note function occurs
 *   - add a swap scroll transition function (W.I.P)
 *   - doc of descriptions for these functions
*/


public function tweenStrumX(daStrumline:Int = 0, daStrum:Int = 0, newXPos:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum], {x: strumLines.members[daStrumline].members[daStrum].x + newXPos}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumY(daStrumline:Int = 0, daStrum:Int = 0, newYPos:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum], {y: newYPos}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumScaleX(daStrumline:Int = 0, daStrum:Int = 0, newScaleX:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum].scale, {x: newScaleX}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumScaleY(daStrumline:Int = 0, daStrum:Int = 0, newScaleY:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum].scale, {y: newScaleY}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumAlpha(daStrumline:Int = 0, daStrum:Int = 0, newAlpha:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum], {alpha: newAlpha}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumAngle(daStrumline:Int = 0, daStrum:Int = 0, newAngle:Float, steps:Int, ease:FlxEase = FlxEase.linear)
    FlxTween.tween(strumLines.members[daStrumline].members[daStrum], {angle: newAngle}, (Conductor.stepCrochet * steps / 1000), {ease: ease});

public function tweenStrumColor(daStrumline:Int = 0, daStrum:Int = 0, steps:Int, preColor:FlxColor = FlxColor.WHITE, afterColor:FlxColor = FlxColor.BLACK)
    FlxTween.color(strumLines.members[daStrumline].members[daStrum],(Conductor.stepCrochet * steps / 1000), preColor, afterColor);

public function shakeStrum(daStrumline:Int = 0, daStrum:Int = 0, intensity:Float, steps:Int, style:FlxAxes = FlxAxes.XY)
    FlxTween.shake(strumLines.members[daStrumline].members[daStrum], intensity, (Conductor.stepCrochet * steps / 1000), style);

public function setStrumPosX(daStrumline:Int = 0, daStrum:Int = 0, newXPos:Float)
    strumLines.members[daStrumline].members[daStrum].x = strumLines.members[daStrumline].members[daStrum].x + newXPos;

public function setStrumPosY(daStrumline:Int = 0, daStrum:Int = 0, newYPos:Float)
    strumLines.members[daStrumline].members[daStrum].y = newYPos;

public function setStrumScale(daStrumline:Int = 0, daStrum:Int = 0, newScaleX:Float = 1, newScaleY:Float = 1)
    strumLines.members[daStrumline].members[daStrum].scale.set(newScaleX, newScaleY);

public function setStrumAlpha(daStrumline:Int = 0, daStrum:Int = 0, newAlpha:Float)
    strumLines.members[daStrumline].members[daStrum].alpha = newAlpha;

public function setStrumAngle(daStrumline:Int = 0, daStrum:Int = 0, newAngle:Float)
    strumLines.members[daStrumline].members[daStrum].angle = newAngle;

public function setStrumColor(daStrumline:Int = 0, daStrum:Int = 0, newColor:FlxColor)
    strumLines.members[daStrumline].members[daStrum].color = newColor;

public function flipStrumX(daStrumline:Int = 0, daStrum:Int = 0, flipped:Bool = true)
    strumLines.members[daStrumline].members[daStrum].flipX = flipped;

public function flipStrumY(daStrumline:Int = 0, daStrum:Int = 0, flipped:Bool = true)
    strumLines.members[daStrumline].members[daStrum].flipY = flipped;

public function swapScroll()
    if (!downscroll)
        downscroll = true;
    else
        downscroll = false;

public function setNoteScrollSpd(daStrumline:Int = 0, daNote:Int = 0, newScrollSpeed:Float = 1){
    strumLines.members[daStrumline].members[daNote].scrollSpeed = newScrollSpeed;
    strumLines.members[daStrumline].notes.limit = 1500 / scrollSpeed; // prevents notes appearing randomly

    // i hate this
    Math.max(Math.max(strumLines.members[daStrumline].members[0].scrollSpeed, strumLines.members[daStrumline].members[1].scrollSpeed), Math.max(strumLines.members[daStrumline].members[2].scrollSpeed, strumLines.members[daStrumline].members[3].scrollSpeed));
}

public function tweenNoteScrollSpd(daStrumline:Int = 0, daNote:Int = 0, newScrollSpd:Float, steps:Int, ease:FlxEase = FlxEase.linear){
    var theNote = strumLines.members[daStrumline].members[daNote];
    var funnyTween:NumTween;
    funnyTween = FlxTween.num(theNote.scrollSpeed, newScrollSpd, (Conductor.stepCrochet * steps / 1000), {ease: ease, onUpdate: function(){
        theNote.scrollSpeed = funnyTween.value;
    }});
}