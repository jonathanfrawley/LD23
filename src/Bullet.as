package
{
    import org.flixel.*;

    public class Bullet extends FlxSprite
    {
        [Embed(source="../media/bullet.png")] private var BulletImage:Class;

        private var myState: PlayState;
        private var nearRadius: Number = 100;
        private var xTarget:Number;
        private var yTarget:Number;
        public static var bulletIdIdx:Number = 0;
        public var id:Number = 0;

        public function Bullet(state:PlayState, x: Number, y: Number, xTarget:Number, yTarget:Number):void
        {
            super(x - 16, y - 16, BulletImage);
            velocity.x = xTarget - x;
            velocity.y = yTarget - y;
            state = myState;
            this.xTarget = xTarget;
            this.yTarget = yTarget;
            //Give an id
            this.id = Bullet.bulletIdIdx;
            Bullet.bulletIdIdx += 1;
        }


        override public function update():void
        {
/*
            if(MathHelp.dist(x,y,xTarget,yTarget) < nearRadius)
            {
                //myState.spawnExplosion(x,y);
            }
*/
            super.update();
        }
    }
}

