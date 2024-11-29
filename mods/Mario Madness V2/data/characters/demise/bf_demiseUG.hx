var legs:FunkinSprite;
var leftArm:FunkinSprite;
function postCreate() {

	leftArm = new FunkinSprite(0, 0, Paths.image('characters/HellishHights/mx/Demise_BF_Assets_Underground'));
	XMLUtil.addAnimToSprite(leftArm, {
		name: 'arm',
		anim: 'BF Right Arm',
		fps: 40,
		loop: true,
		animType: 'loop',
		indices: [],
		x: 0,
		y: 0,
		forced: true,
	});
	leftArm.playAnim('arm', true);
	new FlxTimer().start(0.001, () -> state.insert(state.members.indexOf(this), leftArm));
    extra.set('arm', leftArm);


    legs = new FunkinSprite(0, 0, Paths.image('characters/HellishHights/mx/Demise_BF_Assets_Underground'));
	XMLUtil.addAnimToSprite(legs, {
		name: 'legs',
		anim: 'Bottom',
		fps: 40,
		loop: true,
		animType: 'loop',
		indices: [],
		x: 0,
		y: 0,
		forced: true,
	});
    legs.playAnim('legs', true);
	new FlxTimer().start(0.001, () -> state.insert(state.members.indexOf(this), legs));
    extra.set('legs', legs);
}
function update(elapsed:Float) {
	legs.alpha = alpha;
	legs.visible = visible;
	legs.color = color;
	legs.setPosition(x + globalOffset.x + 10, y + globalOffset.y + 240);
	leftArm.setPosition(x + globalOffset.x + 30, y + globalOffset.y + 180);

}
function onDance() {
	leftArm.alpha = 1;
	leftArm.playAnim('arm', true);
}
function onPlaySingAnim(){
	leftArm.alpha = 0;
}