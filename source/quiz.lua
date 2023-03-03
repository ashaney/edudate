import "CoreLibs/graphics"
import "CoreLibs/object"
import "quizSelect"

local gfx <const> = playdate.graphics
local snd = playdate.sound
local questionNumber = 1
local selected = 1

local table = null
local score = 0
local numberOfOptions = 3
local numberOfQuestions = 0
local isShowingScore = false
local percent = 0
local s = snd.fileplayer.new("sounds/endsound")

class("quiz").extends(gfx.sprite)

function quiz:init(quizSelected)
    
	self.table = null;
	local myInputHandlers = {
		upButtonUp = function()
			if selected > 1 then
				selected = selected - 1
				quiz:refresh()
			end
		end,	
		downButtonUp = function()
			if selected < numberOfOptions then
				selected = selected + 1
				quiz:refresh()
			end
		end,
		-- rightButtonUp = function()
		-- 	if questionNumber < 4 then
		-- 		questionNumber = questionNumber + 1
		-- 	end
		-- 	quiz:refresh()
		-- end,
		-- leftButtonUp = function()
		-- 	if questionNumber > 1 then
		-- 		questionNumber = questionNumber - 1
		-- 	end
		-- 	quiz:refresh()
		-- end		,
		
		BButtonUp = function()
			quizSelect()
		end,
		AButtonUp = function ()
			if isShowingScore then
				quizSelect()
			else
				quiz:checkAnswer()
			end
		end
	}	
	playdate.inputHandlers.push(myInputHandlers)
	self:initializeQuestions(quizSelected)
	quiz:refresh()
end

function quiz:refresh()
	gfx.clear()
	quiz:draw()
	quiz:drawSelection()  
	quiz:drawScore();
end

function quiz:update()

end

function quiz:draw(quizSelected)
	self.quiz = {
		questionx = 25,
		questiony = 25,
		answer1x = 50,
		answer1y =75,
		answer2y = 125,
		answer3y =175,
		width =300,
		height =20,
		slectedBoxMargin = 8,
		questionsInitialized = 0
	}
	--if self.quiz.questionsInitialized == 0 then
	--	self:initializeQuestions(quizSelected)
	--	self.quiz.questionsInitialized = 1
	--end	
    local quizParts = self.quiz;
	local text = table["questions"][tostring(questionNumber)]["text"]
	local option1 = table["questions"][tostring(questionNumber)]["option1"]
	local option2 = table["questions"][tostring(questionNumber)]["option2"]
	local option3 = table["questions"][tostring(questionNumber)]["option3"]

    gfx.drawTextInRect(text, quizParts.questionx, quizParts.questiony, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option1), quizParts.answer1x,quizParts.answer1y, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option2), quizParts.answer1x,quizParts.answer2y, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option3), quizParts.answer1x,quizParts.answer3y, quizParts.width, quizParts.height)
	--gfx.drawRect(48, 199, 302, 22);
end

function quiz:drawSelection()
	self.rect = {
		x = 46,
		y = 0,
		width = 302,
		height= 28
	}
	local rect = self.rect;
	if selected == 1 then
		rect.y = self.quiz.answer1y-self.quiz.slectedBoxMargin
	end
	if selected == 2 then
		print("answer 2");
		rect.y = self.quiz.answer2y-self.quiz.slectedBoxMargin
	end
	if selected == 3 then
		rect.y = self.quiz.answer3y-self.quiz.slectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end

function quiz:initializeQuestions(quizSelected)	
	isShowingScore = false
	score = 0
	selected = 1
	questionNumber = 1
	table = playdate.datastore.read("json\\"..quizSelected)
	numberOfQuestions = self:getTableSize(table["questions"])
end

function quiz:drawScore()
	gfx.drawTextInRect("Score: " .. tostring(score), 300, 10, 200, 20)
end

function quiz:checkAnswer()
	if selected == table["questions"][tostring(questionNumber)]["correct"] then
		score = score + 1
	end
	if numberOfQuestions > questionNumber then
		questionNumber = questionNumber + 1
		selected = 1
		quiz:refresh()
	else
		percent = 100 * (score / numberOfQuestions)
        gfx.clear()
		s:play()
        gfx.drawTextInRect("Your score is:", 50, 50, 250, 20)
        gfx.drawTextInRect(tostring(score).." out of "..tostring(numberOfQuestions), 75, 75, 250, 20)
		gfx.drawTextInRect("That is a ", 50, 150, 250, 20)
		percent = math.floor(percent)
        gfx.drawTextInRect(tostring(percent).."%!", 165, 150, 250, 20)
		if percent >= 80 then
			gfx.drawTextInRect("Good job!", 50, 200, 250, 20)
		else
			gfx.drawTextInRect("Better luck next time", 50, 200, 275, 20)
		end
		isShowingScore = true
	end
	
end

function quiz:getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end