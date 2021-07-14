package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;

using StringTools;

class ByteBeep extends MusicBeatState
{
    var bg:FlxSprite = new FlxSprite(-80, 0).loadGraphic(Paths.image('menuBG'));
    var byte:Character;
    var camFollow:FlxObject;

    override function create() 
        {
            super.create();
            var daByte = "byte";
            Conductor.songPosition = 0;

            byte = new Character(100,100,daByte);

            //var byte:ByteWolfSprite = new ByteWolfSprite(400,400,1,false);
            //byte.screenCenter();

            camFollow = new FlxObject(byte.getGraphicMidpoint().x, byte.getGraphicMidpoint().y, 1, 1);
	    	add(camFollow);

            Conductor.changeBPM(100);

            bg.scrollFactor.set(0.9,0.9);
            bg.antialiasing = true;
            bg.screenCenter();

            FlxG.camera.scroll.set();
            FlxG.camera.target = null;

            add(bg);
            add(byte);
            //byte.updateHitbox();
        }
    var isCat:Bool = false;

    override function update(elapsed:Float)
        {
            super.update(elapsed);

                if (controls.BACK && !isCat)
                    FlxG.switchState(new OptionsMenu());
        }
}

