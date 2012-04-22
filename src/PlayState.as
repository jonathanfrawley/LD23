package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        [Embed(source="../media/back.png")] private var BackgroundImageClass:Class;
        [Embed(source="../media/particle.png")] private var RockParticleImage:Class;
        [Embed(source = "../media/explosion0.mp3")] private var ExplosionSound0:Class;
        [Embed(source = "../media/explosion1.mp3")] private var ExplosionSound1:Class;
        [Embed(source = "../media/fire.mp3")] private var FireSound:Class;
        //[Embed(source = "../media/music_0.mp3")] private var Music0:Class;
        [Embed(source = "../media/music_4.mp3")] private var Music0:Class;
//        [Embed(source="../media/litteworld.png")] public var PlayerImage:Class;
//        [Embed(source="../media/rock.png")] public var RockImage:Class;

        private var background:FlxSprite;
        private var player:Player;
//        private var rock:FlxSprite;
        private var rocks:FlxGroup;
        private var enemyShips:FlxGroup;
        private var bullets:FlxGroup;
        private var cursor:Cursor;
        private var explosions:FlxGroup;
        private var explosionSpots:FlxGroup;
        private var gameOver:Boolean;
        private var spawnTimer:Number;
        private var spawnInterval:Number = 2.5;
        private var winTimer:Number;
        private var win:Boolean;
        private var winTimerText:FlxText;
        private var level:int;
        private static var currentMusic:int = -1;

        //private var explosionSound0:FlxSound;

        override public function create():void
        {
            init();
/*
            level = 0;

            gameOver = false;
            win = false;

            //Background
            background = new FlxSprite(0, 0, BackgroundImageClass);
            add(background);

            //Create player
            player = new Player((FlxG.width/2), (FlxG.height/2), 32, 32);
            player.maxVelocity.x = 80;
            player.maxVelocity.y = 80;
            add(player);


            //Rocks
            rocks = new FlxGroup();
            add(rocks);

            //Enemy Ships
            enemyShips = new FlxGroup();
            add(enemyShips);

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

            //reset spawn timer
            resetSpawnTimer();

            winTimer = 30;

            winTimerText = new FlxText(0, 0, FlxG.width, new String(winTimer));
            winTimerText.setFormat(null, 16, 0x76a2c4, "center");
            add(winTimerText);

            //explosionSound0 = FlxG.loadSound(ExplosionSound0, 1.0, false, false, false);
*/
        }

        private function init():void
        {
            level = 0;

            gameOver = false;
            win = false;

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

            //Enemy Ships
            enemyShips = new FlxGroup();
            add(enemyShips);

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

            //reset spawn timer
            resetSpawnTimer();

            //winTimer = 30;
            winTimer = 30;


            winTimerText = new FlxText(0, 0, FlxG.width, new String(winTimer));
            winTimerText.setFormat(null, 16, 0x76a2c4, "center");
            add(winTimerText);

            //explosionSound0 = FlxG.loadSound(ExplosionSound0, 1.0, false, false, false);
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
                    //var newState:PlayState = new PlayState();
                    //newState.setLevel(level);
                    //FlxG.switchState(newState);
                    init();
                }
            }
            else if(win)
            {
                if(FlxG.keys.justPressed("SPACE"))
                {
                    //var newState:PlayState = new PlayState();
                    //newState.setLevel(level+1);
                    //FlxG.switchState(newState);
                    init();
                    setLevel(level+1);
                }
            }
            else
            {

                if(currentMusic != level)
                {
                    if(FlxG.music == null)
                    {
                        FlxG.playMusic(Music0,1);
                        currentMusic = level;
                    }
                }

                FlxG.overlap(explosionSpots, bullets, overlapExplosionSpotsBullets);
                FlxG.overlap(explosions, rocks, overlapExplosionRocks);
                FlxG.overlap(rocks, player, overlapRocksPlayer);
                FlxG.overlap(enemyShips, player, overlapShipsPlayer);
                FlxG.overlap(enemyShips, explosions, overlapShipsExplosions);

                //Simple ai movement
                //rock.x += 5;
                if(FlxG.mouse.justPressed())
                {
                    var bullet:Bullet = new Bullet(this, player.realx, player.realy, FlxG.mouse.x, FlxG.mouse.y)
                    bullets.add(bullet);
                    explosionSpots.add(new ExplosionSpot(FlxG.mouse.x, FlxG.mouse.y,bullet.id));
                    FlxG.play(FireSound);
                }

                spawnTimer -= FlxG.elapsed;
                if(spawnTimer < 0)
                {
                    if(Math.round(Math.random())==0)
                    {
                        spawnRock();
                    }
                    else
                    {
                        spawnEnemyShip();
                    }
                    resetSpawnTimer();
                }

                winTimer -= FlxG.elapsed;
                if(winTimer < 0)
                {
                    win = true;
                    var winText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                            "You Win\nPress space to continue");
                    winText.setFormat(null, 16, 0x76a2c4, "center");
                    add(winText);
                }

                winTimerText.kill();
                winTimerText = new FlxText(0, 0, FlxG.width, new String(Math.round(winTimer)));
                winTimerText.setFormat(null, 16, 0x76a2c4, "center");
                add(winTimerText)

            }

            super.update();
        }

        private function spawnRock():void
        {
            var type:int = Math.round(Math.random() * 3);
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

        private function spawnEnemyShip():void
        {
            var type:int = Math.round(Math.random() * 3);
            //var type:int = 0;
            var x: Number;
            var y: Number;
/*
            if(type == 0)
            {
                x = (Math.random() * (FlxG.height - 100.0)) + 50.0;
                y = FlxG.height;
            }
            else if(type == 1)
            {
                x = (Math.random() * (FlxG.height - 100.0)) + 50.0;
                y = 0;
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
*/
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
            enemyShips.add(new EnemyShip(x, y, type));
        }

        private function overlapExplosionSpotsBullets(explosionSpot: ExplosionSpot, bullet: Bullet):void
        {
            if(explosionSpot.id == bullet.id)
            {
//                var emitter:flxemitter = createrockemitter();
//                emitter.at(explosionspot);

                explosions.add(new Explosion(explosionSpot.realx, explosionSpot.realy));
                bullet.kill();
                explosionSpot.kill();
                FlxG.play(ExplosionSound1);
            }
//            FlxG.score += 1;
//            scoreText.text = FlxG.score.toString();
//            FlxG.play(SoundExplosionAlien);

        }

        private function createRockEmitter():FlxEmitter
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

            emitter.makeParticles(RockParticleImage)

            emitter.start();
            add(emitter);
            return emitter;
        }

        private function overlapExplosionRocks(explosion: Explosion, rock: Rock):void
        {
            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(rock);
            rock.kill();
            FlxG.play(ExplosionSound0,1,false);
            //explosionSound0.play();
        }

        private function overlapRocksPlayer(rock: Rock, player:Player):void
        {
            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(player);

            player.kill();
            rock.kill();
            FlxG.shake(0.02);

            var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                    "GAME OVER\nPress space to restart");
            gameOverText.setFormat(null, 16, 0x76a2c4, "center");
            add(gameOverText);
//            FlxG.play(SoundExplosionShip);
            gameOver = true;
            FlxG.play(ExplosionSound0,1,false);
            //explosionSound0.play();
        }

        private function resetSpawnTimer():void
        {
            spawnTimer = spawnInterval;
/*
            spawnInterval *= 0.95;
            if(spawnInterval < 0.1)
            {
                spawnInterval = 0.1;
            }
*/
        }

        private function overlapShipsPlayer(ship:EnemyShip, player:Player):void
        {
            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(player);

            player.kill();
            ship.kill();
            FlxG.shake(0.02);

            var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                    "GAME OVER\nPress space to restart");
            gameOverText.setFormat(null, 16, 0x76a2c4, "center");
            add(gameOverText);
//            FlxG.play(SoundExplosionShip);
            gameOver = true;
            FlxG.play(ExplosionSound0,1,false);
            //explosionSound0.play();
        }

        private function overlapShipsExplosions(ship:EnemyShip, explosion:Explosion):void
        {
            //explosionSound0.play();

            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(ship);
            ship.kill();
            FlxG.play(ExplosionSound0,1,false);
        }

        public function setLevel(level:int):void
        {
            this.level = level;
            //Do some extra stuff here...
        }

    }
}
