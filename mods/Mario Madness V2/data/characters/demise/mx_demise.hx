var legs:FunkinSprite;
var leftArm:FunkinSprite;
function postCreate() {

	leftArm = new FunkinSprite(0, 0, Paths.image('characters/HellishHights/mx/MX_Demise_Assets'));
	XMLUtil.addAnimToSprite(leftArm, {
		name: 'arm',
		anim: 'MX Running Right Arm',
		fps: 24,
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


    legs = new FunkinSprite(0, 0, Paths.image('characters/HellishHights/mx/MX_Demise_Assets'));
	XMLUtil.addAnimToSprite(legs, {
		name: 'legs',
		anim: 'MX Running Leg',
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
	leftArm.alpha = alpha;
	legs.color = color;
	legs.setPosition(x + globalOffset.x + 10, y + globalOffset.y + 500);
	leftArm.setPosition(x + globalOffset.x + 30, y + globalOffset.y + 180);

}
function onTryDance() {
	leftArm.alpha = 1;
	leftArm.playAnim('arm', true);
}
function onPlaySingAnim(){
	leftArm.alpha = 0;
}