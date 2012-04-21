package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        [Embed(source="../media/back.png")] private var BackgroundImageClass:Class;
//        [Embed(source="../media/litteworld.png")] public var PlayerImage:Class;
//        [Embed(source="../media/rock.png")] public var RockImage:Class;

        private var background:FlxSprite;
        private var player:Player;
//        private var rock:FlxSprite;
        private var rocks:FlxGroup;
        private var bullets:FlxGroup;
        private var cursor:Cursor;
        private var explosions:FlxGroup;
        private var explosionSpots:FlxGroup;
        private var gameOver:Boolean;

        override public function create():void
        {
            gameOver = false;

            //Background
            background = new FlxSprite(0, 0, BackgroundImageClass);
            add(background);

            //Create player
            player = new Player((FlxG.width/2), (FlxG.height/2), 32, 32);
            player.maxVelocity.x = 80;
            player.maxVelocity.y = 80;
            add(player);

            /*
            //Create rock
            rock = new FlxSprite((FlxG.width/4)-32, (FlxG.height/4)-32, RockImage);
            rock.maxVelocity.x = 80;
            rock.maxVelocity.y = 80;
            add(rock);
            super.create();
            */

            //Rocks
            rocks = new FlxGroup();
            add(rocks);
            spawnRock();
            spawnRock();
            spawnRock();
            spawnRock();
            spawnRock();
            spawnRock();

            //Bullets
            bullets = new FlxGroup();
            add(bullets);

            //Cursor
            cursor = new Cursor();
            add(cursor);

            //Explosions
            explosions = new FlxGroup();
            add(explosions);

            //Explosion spots, where we click
            explosionSpots = new FlxGroup();
            add(explosionSpots);
        }

        override public function update():void
        {
/*
            if(FlxG.keys.LEFT)
                player.x -= 2;
            if(FlxG.keys.RIGHT)
                player.x += 2;
            if(FlxG.keys.UP)
                player.y -= 2;
            if(FlxG.keys.DOWN)
                player.y += 2;
*/
            if(gameOver)
            {
                if(FlxG.keys.justPressed("SPACE"))
                {
                    FlxG.switchState(new PlayState());
                }
            }
            else
            {
                FlxG.overlap(explosionSpots, bullets, overlapExplosionSpotsBullets);
                FlxG.overlap(explosions, rocks, overlapExplosionRocks);
                FlxG.overlap(rocks, player, overlapRocksPlayer);

                //Simple ai movement
                //rock.x += 5;
                if(FlxG.mouse.justPressed())
                {
                    var bullet:Bullet = new Bullet(this, player.realx, player.realy, FlxG.mouse.x, FlxG.mouse.y)
                    bullets.add(bullet);
                    explosionSpots.add(new ExplosionSpot(FlxG.mouse.x, FlxG.mouse.y,bullet.id));
                }
            }

            super.update();
        }

        private function spawnRock():void
        {
            var type:int = Math.round(Math.random() * 4);
            var x: Number;
            var y: Number;
            if(type == 0)
            {
                x = FlxG.width;
                y = (Math.random() * (FlxG.height - 100.0)) + 50.0;
            }
            else if(type == 1)
            {
                x = 0;
                y = (Math.random() * (FlxG.height - 100.0)) + 50.0;
            }
            else if(type == 2)
            {
                x = (Math.random() * (FlxG.height - 100.0)) + 50.0;
                y = FlxG.height;
            }
            else if(type == 3)
            {
                x = (Math.random() * (FlxG.height - 100.0)) + 50.0;
                y = 0;
            }
                //var type:int = Math.round(Math.random());
            rocks.add(new Rock(x, y, type));
        }

        public function spawnExplosion(x:Number, y:Number):void
        {
            //explosions.add(new Explosion(x,y, 32, 32));
            spawnRock();
        }

        private function overlapExplosionSpotsBullets(explosionSpot: ExplosionSpot, bullet: Bullet):void
        {
            if(explosionSpot.id == bullet.id)
            {
                var emitter:FlxEmitter = createEmitter();
                emitter.at(explosionSpot);

                explosions.add(new Explosion(explosionSpot.x, explosionSpot.y));
                bullet.kill();
                explosionSpot.kill();
            }
//            FlxG.score += 1;
//            scoreText.text = FlxG.score.toString();
//            FlxG.play(SoundExplosionAlien);

        }

        private function createEmitter():FlxEmitter
        {
            var emitter:FlxEmitter = new FlxEmitter();
            //emitter.delay = 1;
            emitter.gravity = 0;
            emitter.maxRotation = 0;
            emitter.setXSpeed(-500, 500);
            emitter.setYSpeed(-500, 500);
            var particles: int = 10;

            for(var i: int = 0; i < particles; i++)
            {
                var particle:FlxParticle = new MyParticle();
                particle.makeGraphic(2, 2, 0xFF597137);
                particle.exists = true;
                emitter.add(particle);
            }

//            emitter.makeParticles(Bullet)

            emitter.start();
            add(emitter);
            return emitter;
        }

        private function overlapExplosionRocks(explosion: Explosion, rock: Rock):void
        {
            rock.kill();
        }

        private function overlapRocksPlayer(rock: Rock, player:Player):void
        {
            var emitter:FlxEmitter = createEmitter();
            emitter.at(player);

            player.kill();
            rock.kill();
            FlxG.shake(0.02);

            var gameOverText:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width,
                    "GAME OVER\nPress space to restart");
            gameOverText.setFormat(null, 16, 0x76a2c4, "center");
            add(gameOverText);
//            FlxG.play(SoundExplosionShip);
            gameOver = true;
        }


    }
}
