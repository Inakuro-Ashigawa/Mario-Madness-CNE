import haxe.ds.StringMap;
public var boyfriendMap:StringMap<Character> = new StringMap();
public var dadMap:StringMap<Character> = new StringMap();
public var gfMap:StringMap<Character> = new StringMap();
public static var isCameraOnForcedPos:Bool = false; isCameraOnForcedPos = false;

function onEvent(event) {
	switch (event.event.name) {
		case 'Psych Events':
			var value1:String = event.event.params[1];
			var value2:String = event.event.params[2];
			var flValue1:Null<Float> = Std.parseFloat(value1);
			var flValue2:Null<Float> = Std.parseFloat(value2);
			if (Math.isNaN(flValue1)) flValue1 = null;
			if (Math.isNaN(flValue2)) flValue2 = null;
			
			switch (event.event.params[0]) {
				case 'Hey!':
					var value:Int = 2;
					switch (StringTools.trim(value1.toLowerCase())) {
						case 'bf' | 'boyfriend' | '0': value = 0;
						case 'gf' | 'girlfriend' | '1': value = 1;
					}

					if (flValue2 == null || flValue2 <= 0) flValue2 = 0.6;

					if (value != 0) {
						if(StringTools.startsWith(dad?.curCharacter, 'gf')) {
							dad?.playAnim('cheer', true, 'LOCK');
							dad?.extra.set('heyTimer', new FlxTimer().start(flValue2, function() {
								if (dad?.lastAnimContext == 'LOCK') dad?.dance();
							}));
						} else if (gf != null) {
							gf?.playAnim('cheer', true, 'LOCK');
							gf?.extra.set('heyTimer', new FlxTimer().start(flValue2, function() {
								if (gf?.lastAnimContext == 'LOCK') gf?.dance();
							}));
						}
					}
					if (value != 1) {
						boyfriend?.playAnim('hey', true, 'LOCK');
						boyfriend?.extra.set('heyTimer', new FlxTimer().start(flValue2, function() {
							if (boyfriend?.lastAnimContext == 'LOCK') boyfriend?.dance();
						}));
					}

				case 'Set GF Speed':
					if (flValue1 == null || flValue1 < 1) flValue1 = 1;
					gfSpeed = Math.round(flValue1);
					
				case 'Add Camera Zoom':
					if (Options.camZoomOnBeat && FlxG.camera.zoom < maxCamZoom) {
						if (flValue1 == null) flValue1 = 0.015;
						if (flValue2 == null) flValue2 = 0.03;
	
						FlxG.camera.zoom += flValue1;
						camHUD.zoom += flValue2;
					}
					
				case 'Play Animation':
					var char:Array<Character> = strumLines.members[0].characters;
					switch (StringTools.trim(value2.toLowerCase())) {
						case 'bf' | 'boyfriend':
							char = strumLines.members[1].characters;
						case 'gf' | 'girlfriend':
							char = strumLines.members[2].characters;
						default:
							if (flValue2 == null) flValue2 = 0;
							switch (Math.round(flValue2)) {
								case 1: char = strumLines.members[1].characters;
								case 2: char = strumLines.members[2].characters;
							}
					}

					for (char in char) char?.playAnim(value1, true);
					
				case 'Camera Follow Pos':
					if (camFollow != null) {
						isCameraOnForcedPos = false;
						if (flValue1 != null || flValue2 != null) {
							isCameraOnForcedPos = true;
							if (flValue1 == null) flValue1 = 0;
							if (flValue2 == null) flValue2 = 0;
							camFollow.x = flValue1;
							camFollow.y = flValue2;
						}
					}

				case 'Alt Idle Animation':
					var char:Array<Character> = strumLines.members[0].characters;
					switch (StringTools.trim(value1.toLowerCase())) {
						case 'gf' | 'girlfriend': char = strumLines.members[2].characters;
						case 'boyfriend' | 'bf': char = strumLines.members[1].characters;
						default:
							var val:Int = Std.parseInt(value1);
							if (Math.isNaN(val)) val = 0;
							switch (val) {
								case 1: char = strumLines.members[1].characters;
								case 2: char = strumLines.members[2].characters;
							}
					}

					for (char in char) char?.idleSuffix = value2;
					
				case 'Screen Shake':
					var valuesArray:Array<String> = [value1, value2];
					var targetsArray:Array<FlxCamera> = [camGame, camHUD];
					for (i in 0...targetsArray.length) {
						var split:Array<String> = valuesArray[i].split(',');
						var duration:Float = 0;
						var intensity:Float = 0;
						if (split[0] != null) duration = Std.parseFloat(StringTools.trim(split[0]));
						if (split[1] != null) intensity = Std.parseFloat(StringTools.trim(split[1]));
						if (Math.isNaN(duration)) duration = 0;
						if (Math.isNaN(intensity)) intensity = 0;

						if (duration > 0 && intensity != 0) targetsArray[i].shake(intensity, duration);
					}
					
				case 'Change Character':
					var charType:Int = 0;
					switch(StringTools.trim(value1.toLowerCase())) {
						case 'gf' | 'girlfriend': charType = 2;
						case 'dad' | 'opponent': charType = 1;
						default:
							charType = Std.parseInt(value1);
							if (Math.isNaN(charType)) charType = 0;
					}

					switch(charType) {
						case 0:
							if (boyfriend != null && boyfriend.curCharacter != value2) {
								if (!boyfriendMap.exists(value2)) addCharacterToList(value2, charType);

								var lastAlpha:Float = boyfriend.alpha;
								boyfriend.alpha = 0.00001;
								boyfriend = boyfriendMap.get(value2);
								boyfriend.alpha = lastAlpha;
								iconP1.setIcon(boyfriend != null ? boyfriend.getIcon() : 'face');
							}

						case 1:
							if (dad != null && dad.curCharacter != value2) {
								if (!dadMap.exists(value2)) addCharacterToList(value2, charType);

								var wasGf:Bool = StringTools.startsWith(dad.curCharacter, 'gf-') || dad.curCharacter == 'gf';
								var lastAlpha:Float = dad.alpha;
								dad.alpha = 0.00001;
								dad = dadMap.get(value2);
								if (gf != null) {
									if (!StringTools.startsWith(dad.curCharacter, 'gf-') && dad.curCharacter != 'gf')
										if (wasGf) gf.visible = true;
									else gf.visible = false;
								}
								dad.alpha = lastAlpha;
								iconP2.setIcon(dad != null ? dad.getIcon() : 'face');
							}

						case 2:
							if (gf != null && gf.curCharacter != value2) {
								if (!gfMap.exists(value2)) addCharacterToList(value2, charType);

								var lastAlpha:Float = gf.alpha;
								gf.alpha = 0.00001;
								gf = gfMap.get(value2);
								gf.alpha = lastAlpha;
							}
					}
					if (Options.colorHealthBar) {
						var leftColor:Int = dad != null && dad.iconColor != null ? dad.iconColor : (PlayState.opponentMode ? 0xFF66FF33 : 0xFFFF0000);
						var rightColor:Int = boyfriend != null && boyfriend.iconColor != null ? boyfriend.iconColor : (PlayState.opponentMode ? 0xFFFF0000 : 0xFF66FF33);
						healthBar.createFilledBar(leftColor, rightColor);
					}
					
				case 'Change Scroll Speed':
					if (scrollSpeedTween != null) scrollSpeedTween.cancel();
					if (flValue1 == null) flValue1 = 1;
					if (flValue2 == null) flValue2 = 0;
					var newValue:Float = SONG.scrollSpeed * flValue1;
					if (flValue2 <= 0) scrollSpeed = newValue;
					else scrollSpeedTween = FlxTween.tween(this, {scrollSpeed: newValue}, flValue2, {ease: FlxEase.linear});
				case 'Set Property':
					try {
						var contents:Array<String> = value1.split('.');
						var ah:String = contents[0];
						contents.remove(ah);
						var great:String = contents.join('.');
						Reflect.setProperty(Reflect.getProperty(this, ah), great, value2);
					} catch(e:Dynamic) trace('ERROR ("Set Property" Event) - ' + e);
					
				case 'Play Sound':
					if (flValue2 == null) flValue2 = 1;
					FlxG.sound.play(Paths.sound(value1), flValue2);
			}
	}
}

function onCameraMove(event) {
	if (isCameraOnForcedPos && !event.cancelled) {
		event.position.set(camFollow.x, camFollow.y);
	}
}

function postCreate() {
	if (boyfriend != null) boyfriendMap.set(boyfriend.curCharacter, boyfriend);
	if (dad != null) dadMap.set(dad.curCharacter, dad);
	if (gf != null) gfMap.set(gf.curCharacter, gf);
	for (event in events) {
		switch (event.name) {
			case 'Psych Events':
				switch (event.params[0]) {
					case 'Change Character':
						var charType:Int = 0;
						switch (event.params[1].toLowerCase()) {
							case 'gf' | 'girlfriend' | '1': charType = 2;
							case 'dad' | 'opponent' | '0': charType = 1;
							default:
								var val1:Int = Std.parseInt(event.params[1]);
								if (Math.isNaN(val1)) val1 = 0;
								charType = val1;
						}
						
						addCharacterToList(event.params[2], charType);
				}
			case 'Play Sound': Paths.sound(event.params[1]); //Precache sound
		}
	}
}

// change char stuff
function addCharacterToList(newCharacter:String, type:Int) {
	switch (type) {
		case 0:
			if (boyfriend != null && !boyfriendMap.exists(newCharacter)) {
				var newBoyfriend:Character = new Character(boyfriend.x, boyfriend.y, newCharacter, boyfriend.isPlayer);
				boyfriendMap.set(newCharacter, newBoyfriend);
				insert(members.indexOf(boyfriend), newBoyfriend);
				newBoyfriend.alpha = 0.00001;
				newBoyfriend.drawComplex(FlxG.camera);
			}

		case 1:
			if (dad != null && !dadMap.exists(newCharacter)) {
				var newDad:Character = new Character(dad.x, dad.y, newCharacter, dad.isPlayer);
				dadMap.set(newCharacter, newDad);
				insert(members.indexOf(dad), newDad);
				newDad.alpha = 0.00001;
				newDad.drawComplex(FlxG.camera);
			}

		case 2:
			if (gf != null && !gfMap.exists(newCharacter)) {
				var newGf:Character = new Character(gf.x, gf.y, newCharacter, gf.isPlayer);
				gfMap.set(newCharacter, newGf);
				insert(members.indexOf(gf), newGf);
				newGf.alpha = 0.00001;
				newGf.drawComplex(FlxG.camera);
			}
	}
}