enemy_controller = {}
enemy_controller.enemies = {}

function love.load()
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  -- success = love.window.setFullscreen(true, "desktop")
  -- Define player
  player = {}
  player.x = 100
  player.y = 550
  player.width = 80
  player.height = 20
  -- Define player projectiles
  player.bullets = {}
  player.fire = function()
    bullet = {}
	bullet.width = 10
	bullet.height = 10
    bullet.x = player.x + player.width / 2 - bullet.width / 2
    bullet.y = player.y
    table.insert(player.bullets,bullet)
  end
  enemy_controller:spawnEnemy(30, 30)
end

function enemy_controller:spawnEnemy(x, y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.width = 20
  enemy.height = 20
  enemy.bullets = {}
  enemy.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  enemy.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
  fixture = love.physics.newFixture(enemy.body, enemy.shape, 1) -- Attach fixture to body and give it a density of 1.
  fixture:setRestitution(0.9) --let the ball bounce
  table.insert(enemy_controller.enemies,enemy)
end



function love.update(dt)
  world:update(dt)
  unit = dt*100
  -- Handle input
  if love.keyboard.isDown('right') then
    player.x = player.x + unit
  elseif love.keyboard.isDown('left') then
    player.x = player.x - unit
  end
  if love.keyboard.isDown('escape') then
    love.event.quit()
  end
  if love.keyboard.isDown("space") then
    player.fire()
  end
  
  -- Update other stuff
  for _,v in pairs(player.bullets) do
    v.y = v.y - 10
  end
end

function love.draw()
  -- Draw player
  love.graphics.rectangle('fill',player.x,player.y,player.width,player.height)
  -- Draw player projectiles
  for _,v in pairs(player.bullets) do
    love.graphics.rectangle('fill',v.x,v.y,bullet.width,bullet.height)
  end
  -- Draw enemies
  for _,enemy in pairs(enemy_controller.enemies) do
    love.graphics.rectangle('fill',enemy.body:getX(),enemy.body:getY(),enemy.width,enemy.height)
  end
end


