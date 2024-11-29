var leftArm:FlxSprite;
public var chase = false;
function postCreate(){
    curCameraTarget = 1;

    leftArm = new FlxSprite(boyfriend.x, boyfriend.y + 420);
    leftArm.frames = Paths.getFrames('characters/HellishHights/overdue/Too_Late_Pico_FINALSEQUENCE_assets');
    leftArm.animation.addByPrefix('singLEFT', 'TopLeftBack', 24, true);
    leftArm.animation.addByPrefix('singUP', 'TopUpBack', 24, true);
    leftArm.animation.addByPrefix('singRIGHT', 'TopRightBack', 24, true);
    leftArm.alpha = 0.001;
    insert(members.indexOf(boyfriend), leftArm);
}
function update(elapsed:Float) { 
    if(chase == true){
    if (boyfriend.animation.curAnim.name == "singRIGHT") {
        leftArm.animation.play('singRIGHT');
        leftArm.setPosition(boyfriend.x + 20, boyfriend.y + 420);
        leftArm.alpha = 1;
    }
    else if (boyfriend.animation.curAnim.name == "singLEFT") {
        leftArm.animation.play('singLEFT');
        leftArm.setPosition(boyfriend.x + 210, boyfriend.y + 440);
        leftArm.alpha = 1;
    }
    else if (boyfriend.animation.curAnim.name == "singUP") {
        leftArm.animation.play('singUP');
        leftArm.setPosition(boyfriend.x + 240, boyfriend.y + 420);
        leftArm.alpha = 1;
    }
    else { 
        leftArm.alpha = 0;
    }
  }
}
