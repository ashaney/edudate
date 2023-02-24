import "quiz" -- DEMO
local quiz = quiz(1, -1) -- DEMO

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local quizSelected = null;


local function loadGame()
	
	-- myInputHandlers are in effect
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

local function updateGame()
	quiz:update() -- DEMO
end

local function drawGame()
	gfx.clear() -- Clears the screen
	quiz:draw() -- DEMO

end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
end


