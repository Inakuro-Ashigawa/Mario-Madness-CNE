import BGSprite;

function create() {
    defaultCamZoom = 0.7;

    introLength = 0;
    bgsign = new BGSprite('mario/IHY/Luigi_IHY_Background_Assets_ete_sech_v2', 1160, 300, 0.6, 0.6);
    bgsign.setGraphicSize(Std.int(bgsign.width * 0.8));
    bgsign.alpha = 0;
    add(bgsign);
    remove(dad);
    remove(boyfriend);
    remove(gf);
    add(gf);
    add(dad);
    add(boyfriend);
    boyfriend.x = 870;
    boyfriend.y = 60;
    dad.x = 250;
    dad.y = 100;
    gf.x = -200;
    gf.y = 80;
}

function onCountdown(e) {
    e.cancel();
}