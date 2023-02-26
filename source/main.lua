import "CoreLibs/object"
import "CoreLibs/graphics"

import "sceneManager"
import "quizSelect"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

SCENE_MANAGER = SceneManager()

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

loadGame()

function pd.update()
	quizSelect()
	pd.update = quizSelect.update
end



--local function updateGame()
--	quiz:update() -- DEMO
--	quizSelect:update()
--end
--
--local function drawGame()
--	gfx.clear() -- Clears the screen
--	if quizSelected == null then
--		quizSelect:draw()
--		quizSelected = quizSelect:getSelectedQuiz()
--	else
--		print("drawing")
--		quiz:draw(quizSelected)
--	end
--
--end
--
--loadGame()
--
--function playdate.update()
--	updateGame()
--	drawGame()
--end


