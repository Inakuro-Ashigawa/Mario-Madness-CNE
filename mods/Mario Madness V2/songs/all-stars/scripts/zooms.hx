var dadZoom:Float = .35;
var bfZoom:Float = .6;
function update(elapsed:Float){
    switch (curCameraTarget){
        case 0: defaultCamZoom = dadZoom;
        case 1: defaultCamZoom = bfZoom;
    }
}
