package
{
    import org.flixel.*;

    public class PlayState extends FlxState
    {
        [Embed(source="../media/back.png")] private var BackgroundImageClass:Class;
        [Embed(source="../media/particle.png")] private var RockParticleImage:Class;
        [Embed(source="../media/littelittleworld.png")] private var HealthImage:Class;
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
        private var waveTimer:Number;
        private var waveInterval:Number = 10.0;
        private var winTimer:Number;
        private var win:Boolean;
        private var winTimerText:FlxText;
        private var waveTimerText:FlxText;
        public var level:int;
        private static var currentMusic:int = -1;
        private var kittens:FlxGroup;
        private var kittensAnimated:FlxGroup;

        private var scoreText:FlxText;
        private var healthText:FlxText;

//        private var levelTime:Number;
        private var spawnInterval:Number;
        private var playerHealth:Number;

        private var playerHealthSprite0:FlxSprite;
        private var playerHealthSprite1:FlxSprite;
        private var playerHealthSprite2:FlxSprite;

        private static var kittenChance:int = 0.5;
        //private static var kittenChance:int = 1.0;

        //private var explosionSound0:FlxSound;

        override public function create():void
        {
            init();
            //FlxG.level=10;
            setLevel(FlxG.level);
            //setLevel(1);
        }

        public function init():void
        {
//            level = FlxG.Level;

            gameOver = false;
            win = false;

            //Background
            background = new FlxSprite(0, 0, BackgroundImageClass);
            add(background);

            //Create player
            player = new Player((FlxG.width/2), (FlxG.height/2), 32, 32);
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

            //wave timer
            resetWaveTimer();

            winTimer = 30;
            winTimerText = new FlxText(0, 0, FlxG.width, "");
            winTimerText.setFormat(null, 16, 0x76a2c4, "center");
            add(winTimerText);

            waveTimerText = new FlxText(0, 0, FlxG.width, "");
            waveTimerText.setFormat(null, 16, 0x76a2c4, "left");
            add(waveTimerText);

            scoreText = new FlxText(0, 0, FlxG.width, "Score:" + new String(FlxG.score) + "Level:" + new String(level));
            scoreText.setFormat(null, 16, 0x76a2c4, "right");
            add(scoreText);

            //explosionSound0 = FlxG.loadSound(ExplosionSound0, 1.0, false, false, false);
            kittens = new FlxGroup();
            add(kittens);

            kittensAnimated = new FlxGroup();
            add(kittensAnimated);

            spawnKittenAnimated(10,10);
            spawnKitten(10,10);

            healthText = new FlxText(0, 0, FlxG.width, "Level:" + new String(level));
            healthText.setFormat(null, 16, 0x76a2c4, "left");
            add(healthText);

            playerHealth = 3;

            var xoffset:int = 74;
            var yoffset:int = 4;
            playerHealthSprite0 = new FlxSprite(xoffset,yoffset,HealthImage);
            add(playerHealthSprite0);
            playerHealthSprite1 = new FlxSprite(xoffset+20,yoffset,HealthImage);
            add(playerHealthSprite1);
            playerHealthSprite2 = new FlxSprite(xoffset + 40,yoffset,HealthImage);
            add(playerHealthSprite2);
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
                    setLevel(this.level);
                }
            }
            else if(win)
            {
                if(FlxG.keys.justPressed("SPACE"))
                {
                    //var newState:PlayState = new PlayState();
                    //newState.setLevel(level+1);
                    //FlxG.switchState(newState);
/*
                    if(level==3)
                    {
                        FlxG.level = 0;
                        FlxG.switchState(new CreditsState());
                    }
                    else
                    {
*/
                    //init();
                    //setLevel(this.level+1);
                    if(this.level==0)
                    {
                        FlxG.level++;
                        FlxG.switchState(new StoryState2());
                    }
                    else if(this.level==1)
                    {
                        FlxG.level++;
                        FlxG.switchState(new StoryState3());
                    }
                    else if(this.level==2)
                    {
                        FlxG.level++;
                        FlxG.switchState(new StoryState4());
                    }

                    else if(this.level==3)
                    {
                        FlxG.level++;
                        FlxG.switchState(new StoryState5());
                    }
 //                   }
                }
            }
            else
            {

                if(currentMusic != level)
                {
                    if(FlxG.music == null)
                    {
                        //TODO:Enable for multiple levels
                        FlxG.playMusic(Music0,1);
                        currentMusic = level;
                    }
                }

                FlxG.overlap(explosionSpots, bullets, overlapExplosionSpotsBullets);
                FlxG.overlap(explosions, rocks, overlapExplosionRocks);
                FlxG.overlap(rocks, player, overlapRocksPlayer);
                FlxG.overlap(enemyShips, player, overlapShipsPlayer);
                FlxG.overlap(enemyShips, explosions, overlapShipsExplosions);
                FlxG.overlap(kittens, explosions, overlapKittensExplosions);
                FlxG.overlap(kittensAnimated, enemyShips, overlapKittensBadGuy);
                FlxG.overlap(kittensAnimated, rocks, overlapKittensBadGuy);

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

                waveTimer -= FlxG.elapsed;
                if(waveTimer<(winTimer-1)) //Otherwise we don't care.
                {
                    if(waveTimer < 0)
                    {
                        waveEnemyShip();
                        resetWaveTimer();
                    }
                    else if(waveTimer < 5)
                    {
                        waveTimerText.kill();
                        waveTimerText = new FlxText(0, 100, FlxG.width, "NEXT WAVE IN: " + new String(Math.round(waveTimer)));
                        waveTimerText.setFormat(null, 16, 0xbf4949, "center");
                        add(waveTimerText)
                    }
                    else
                    {
                        waveTimerText.kill();
                    }
                }
                else
                {
                    waveTimerText.kill();
                }

                if(level != 10)
                {
                    winTimer -= FlxG.elapsed;
                    if(winTimer < 0)
                    {
                        win = true;
                        var winText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                                "You Win\nScore:" + new String(FlxG.score) + "\nPress space to continue");
                        winText.setFormat(null, 16, 0x5cbf49, "center");
                        add(winText);
                    }

                    winTimerText.kill();
                    winTimerText = new FlxText(0, 0, FlxG.width, new String(Math.round(winTimer)));
                    winTimerText.setFormat(null, 16, 0x76a2c4, "center");
                    add(winTimerText)

                    scoreText.kill();
                    scoreText = new FlxText(0, 0, FlxG.width, "Score:" + new String(FlxG.score) + "\nLevel:" + new String(level));
                    scoreText.setFormat(null, 16, 0x76a2c4, "right");
                    add(scoreText);
                }
                else
                {
                    scoreText.kill();
                    scoreText = new FlxText(0, 0, FlxG.width, "Score:" + new String(FlxG.score) + "\nLevel: Infinite");
                    scoreText.setFormat(null, 16, 0x76a2c4, "right");
                    add(scoreText);
                }
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
            //possibleSpawnItem(rock.realx, rock.realy);
            //possibleSpawnItem(rock.x, rock.y);
            explosion.kill();
            rock.kill();
            FlxG.play(ExplosionSound0,1,false);
            possibleSpawnItem(explosion.realx, explosion.realy);
            //explosionSound0.play();
            FlxG.score += 10;
        }

        private function possibleSpawnItem(x:Number,y:Number):void
        {
            if(Math.random() < kittenChance)
            {
                spawnKitten(x,y);
            }
        }

        private function gameOverCheck():void
        {
            if(playerHealth==0)
            {
                player.kill();
                var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                        "GAME OVER\nScore:" + new String(FlxG.score) + "\nPress space to restart");
                gameOverText.setFormat(null, 16, 0xbf4949, "center");
                add(gameOverText);
    //            FlxG.play(SoundExplosionShip);
                gameOver = true;
                FlxG.play(ExplosionSound0,1,false);
                //explosionSound0.play();
            }
            else if(playerHealth==1)
            {
                playerHealthSprite1.kill();
            }
            else if(playerHealth==2)
            {
                playerHealthSprite2.kill();
            }
        }

        private function overlapRocksPlayer(rock: Rock, player:Player):void
        {
            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(player);

            rock.kill();
            FlxG.shake(0.02);
            playerHealth--;
            gameOverCheck();
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

        private function resetWaveTimer():void
        {
            waveTimer = getWaveInterval();
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

//            player.kill();
            ship.kill();
            FlxG.shake(0.02);
            playerHealth--;
            gameOverCheck();

/*
            var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width,
                    "GAME OVER\nPress space to restart");
            gameOverText.setFormat(null, 16, 0xbf4949, "center");
            add(gameOverText);
//            FlxG.play(SoundExplosionShip);
            gameOver = true;
            FlxG.play(ExplosionSound0,1,false);
*/
            //explosionSound0.play();
        }

        private function overlapShipsExplosions(ship:EnemyShip, explosion:Explosion):void
        {
            //explosionSound0.play();

            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(ship);
            ship.kill();
            FlxG.play(ExplosionSound0,1,false);
            FlxG.score += 100;
        }

        private function overlapKittensExplosions(kitten:Kitten, explosion:Explosion):void
        {
            kitten.kill()
            explosion.kill();
            spawnKittenAnimated(kitten.realx, kitten.realy);
        }

        private function overlapKittensBadGuy(kittenAnim:KittenAnimated, badguy:FlxSprite):void
        {
            badguy.kill();

            var emitter:FlxEmitter = createRockEmitter();
            emitter.at(badguy);
            badguy.kill();
            FlxG.play(ExplosionSound0,1,false);
            FlxG.score += 10;
        }

        public function setLevel(level:int):void
        {
            this.level = level;
            //Do some extra stuff here...make levels harder as we increase.
            if(level==0)
            {
                spawnInterval = 2.5;
                //winTimer = 30;
                winTimer = 3;
            }
            else if(level==1)
            {
                spawnInterval = 1.5;
                //winTimer = 30;
                winTimer = 3;
            }
            else if(level==2)
            {
                spawnInterval = 1.0;
                //winTimer = 30;
                winTimer = 3;
            }
            else if(level==3)
            {
                spawnInterval = 0.5;
                //winTimer = 30;
                winTimer = 3;
            }
            else if(level==10)
            {
                spawnInterval = 0.5;
                //winTimer = 30;
                winTimer = 100000000;
            }
            resetSpawnTimer();
            resetWaveTimer();

            healthText.kill();
            healthText = new FlxText(0, 0, FlxG.width, "Health:");
            healthText.setFormat(null, 16, 0x5cbf49, "left");
            add(healthText);
        }

        private function getWaveInterval():Number
        {
            if(level == 0)
            {
//                return 25;
                return 10;
            }
            else if(level == 1)
            {
                return 20;
            }
            else if(level == 2)
            {
                return 15;
            }
            else if(level == 3)
            {
                return 10;
            }
            else if(level == 10)
            {
                return 10;
            }
            else
            {
                return 20;
            }
        }

        private function waveEnemyShip():void
        {
            var waveAmount:int = 10;
            for(var i:int=0;i<waveAmount;i++)
            {
                spawnEnemyShip();
            }
        }

        private function spawnKitten(x:Number,y:Number):void
        {
            kittens.add(new Kitten(x, y));
        }

        private function spawnKittenAnimated(x:Number,y:Number):void
        {
            kittensAnimated.add(new KittenAnimated(x, y));
        }

    }
}
