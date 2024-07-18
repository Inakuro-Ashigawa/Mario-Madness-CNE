import haxe.ds.StringMap;

var intensity = 5; // How far the camera moves on press, default is 5
                   // 5 = 50 Pixels

var alignX = true; // Makes up and down movement 70% of left and right movement, defualt is true

var move = true;   // Do you want the camera to move? default is true (can also be toggled with "toggleMovePress" event)

function onCameraMove(event) {
	if (event.position.x == dad.getCameraPosition().x && event.position.y == dad.getCameraPosition().y)
		{
			camTarget = "dad";
		}
	else if (event.position.x == boyfriend.getCameraPosition().x && event.position.y == boyfriend.getCameraPosition().y)
		{
			camTarget = "boyfriend";
		}

	if (dad.animation.curAnim.name == "idle" && boyfriend.animation.curAnim.name == "idle" && move) {} else
	{
		event.cancel();
	}
}
var inte = intensity*10;
var inteW = (intensity*10)* (alignX ? 0.7 : 1);
var posOffsets = [
		[-inte, 0],
		[0, inteW],
		[0, -inteW],
		[inte, 0]
	];
function onNoteHit(event) {
    if (move) {
        if (camTarget == "dad")
            {
                camFollow.setPosition(dad.getCameraPosition().x + posOffsets[event.direction][0], dad.getCameraPosition().y + posOffsets[event.direction][1]);
            }
        else if (camTarget == "boyfriend")
            {
                camFollow.setPosition(boyfriend.getCameraPosition().x + posOffsets[event.direction][0], boyfriend.getCameraPosition().y + posOffsets[event.direction][1]);
            }
    }
}

function toggleMovePress(event) {
    move = !move;
}

function onEvent(e){
	switch (e.event.name) {
		case 'Psych Events':
			var value1:String = e.event.params[1];
			var value2:String = e.event.params[2];
			var flValue1:Null<Float> = Std.parseFloat(value1);
			var flValue2:Null<Float> = Std.parseFloat(value2);
			if (Math.isNaN(flValue1)) flValue1 = null;
			if (Math.isNaN(flValue2)) flValue2 = null;
			switch (e.event.params[0]) {
				case 'Camera Follow Pos':
					if (flValue1 != null || flValue2 != null) {
						move = false;
					}else if(flValue1 == null && flValue2 == null) {
						move = true;
					}
			}
		}
}