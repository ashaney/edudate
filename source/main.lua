import "quiz"
import "quizSelect"
local quiz = quiz(1, -1)
local quizSelect = quizSelect(1, -1)

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

local quizSelected = null;


local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

local function updateGame()
	quiz:update() -- DEMO
	quizSelect:update()
end

local function drawGame()
	gfx.clear() -- Clears the screen
	if quizSelected == null then
		quizSelect:draw()
		quizSelected = quizSelect:getSelectedQuiz()
	else
		print("drawing")
		quiz:draw(quizSelected)
	end

end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
end


