var perspect:CustomShader = null;
var fullTimer:Float = 0;

function create(){
    perspect = new CustomShader("perspective");
    if (FlxG.save.data.virtualShaders && FlxG.save.data.virtualBetter) camGame.addShader(perspect);
}
function update(elapsed:Float){
    fullTimer += elapsed;
    perspect.data.time = [fullTimer,fullTimer];

}