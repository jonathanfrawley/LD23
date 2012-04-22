package
{
    import org.flixel.*;

    public class Kitten extends FlxSprite
    {
//        [Embed(source="../media/kitten.png")] public var KittenImage:Class;
        [Embed(source="../media/kitten_icon_anim.png")] public var KittenImage:Class;

        public var realx:Number;
        public var realy:Number;
        private var w:Number = 12;
        private var h:Number = 5;

        public function Kitten(x: Number, y: Number):void
        {
            //super(x - w, y - h, KittenImage);
            super(x - w, y - h);
            realx = x;
            realy = y;

            loadGraphic(KittenImage,true);
            addAnimation("Default",[0,1,2,3],20);
            play("Default");
        }

        override public function update():void
        {
            super.update();
        }
    }
}
