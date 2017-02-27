------------------------------------------------------
--	Simple fire effect with canvas and particle system
------------------------------------------------------

-- Returns canvas of given width and height containing a white circle
function initCanvas (width, height)
	local c = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(c) -- Switch to drawing on canvas 'c'
	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle("fill", width / 2, height / 2, 10, 100)
	love.graphics.setCanvas() -- Switch back to drawing on main screen
	return c
end

-- Returns particle system with given image and maximum particles to mimic fire
function initPartSys (image, maxParticles)
	local ps = love.graphics.newParticleSystem(image, maxParticles)
	ps:setParticleLifetime(0.1, 0.5) -- (min, max)
	ps:setSizeVariation(1)
	ps:setLinearAcceleration(-200, -2000, 200, 100) -- (minX, minY, maxX, maxY)
	ps:setColors(234, 217, 30, 128, 224, 21, 21, 0) -- (r1, g1, b1, a1, r2, g2, b2, a2 ...)
	return ps
end

function love.load ()
	love.window.setTitle("Left-click to make fire!")
	local canvas = initCanvas(20, 40)
	psystem = initPartSys (canvas, 1500)
end

function love.mousemoved (x, y, dx, dy)
	-- To move the particles along with the emitter, do this offset in love.graphics.draw instead of setPosition
	psystem:setPosition(x, y)
end

function love.update (dt)
	-- Only emit particles when left mouse button is down
	if love.mouse.isDown(1) then
		psystem:setEmissionRate(3000)
	else
		psystem:setEmissionRate(0)
	end

	-- Particle system should usually be updated from within love.update
	psystem:update(dt)
end

function love.draw ()
	-- Try different blend modes out - https://love2d.org/wiki/BlendMode
	love.graphics.setBlendMode("add")

	-- Redraw particle system every frame
	love.graphics.draw(psystem)
end
