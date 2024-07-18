function onEvent(_) {
	switch (_.event.name){
		case 'Character Cam Pos':
            var char = _.event.params[0];
            var v1 = _.event.params[1];
            var v2 = _.event.params[2];
            if(v1 == null){
                _.event.params[1] = strumLines.members[char].characters[0].cameraOffset.x;
            }
            if(v2 == null){
                _.event.params[2] = strumLines.members[char].characters[0].cameraOffset.y;
            }
            strumLines.members[char].characters[0].cameraOffset.set(v1, v2);  
    }
}