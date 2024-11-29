var cancelCameraMove:Bool = false;

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function stepHit(){
   if (curStep == 26){
      dad.playAnim("gonnatell");
   }
   if (curStep == 52){
      gf.playAnim("notgonna");
      cancelCameraMove = true;
      FlxTween.tween(camFollow, {x: 900, y: 450}, 1.5, {ease: FlxEase.quadOut});
      FlxTween.tween(camGame, {zoom: 1.3}, 2,  {ease: FlxEase.cubeInOut});
   }
   if (curStep == 68){
      dad.playAnim("betternot");
   }
   if (curStep == 110){
      cancelCameraMove = false;
      FlxTween.tween(camGame, {zoom: .9}, 5,  {ease: FlxEase.cubeInOut});
   }
   if (curStep == 120){
      dad.playAnim("hey");
      camHUD.alpha = 1;
   }
   if (curStep == 518){
      for (i in playerStrums.members){
			FlxTween.tween(i, {alpha: i.alpha - 1}, .5, {ease: FlxEase.circOut});
		}
      dad.playAnim("dumbass");
      gf.playAnim("sadr");

      for (i in playerStrums.members){
			FlxTween.tween(i, {x: i.x - 600}, 1, {startDelay: .6,ease: FlxEase.circOut});
		}
      for (i in playerStrums.members){
			FlxTween.tween(i, {alpha: i.alpha + 1}, 1, {startDelay: 1,ease: FlxEase.circOut});
		}
   }
}