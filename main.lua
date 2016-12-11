function 

function love.load()
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
end

function love.update(dt)
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
end


