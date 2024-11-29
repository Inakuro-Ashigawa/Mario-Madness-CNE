var Lcolor = 0x69BB68;
var Bcolor = 0xC4E0F5;
var Mcolor = 0xA51E2C;
function ChangeIcon(name){
	var isPlayer:Bool = true;
	var icon:HealthIcon = isPlayer ? icoP1 : icoP2;
	if (name == "L"){
		icon.setIcon(gf.icon,150, 150);
	}else{
		icon.setIcon(boyfriend.healthIcon,150, 150);
	}

	if (Options.colorHealthBar && name== "L"){
		healthBar.createColoredFilledBar(Lcolor,Mcolor);
	}else if(Options.colorHealthBar && name== "B"){
		healthBar.createColoredFilledBar(Bcolor,Mcolor);
	}
	healthBar.updateBar();
}
function events(event){
    if (event == "moveNotes"){
        //ChangeIcon("L");
    }
}