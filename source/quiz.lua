import "CoreLibs/graphics"
import "CoreLibs/object"

import "quizSelect"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local questionNumber = 1
local selected = 1

local table = null
local score = 0

local questionInitialized = 0

class("quiz").extends(gfx.sprite)

function quiz:init(quizSelected)
    
	self.table = null;
	local myInputHandlers = {
		upButtonUp = function()
			selected = selected - 1
			quiz:refresh()
		end,
	
		downButtonUp = function()
			selected = selected + 1
			quiz:refresh()
		end,
		rightButtonUp = function()
			if questionNumber < 4 then
				questionNumber = questionNumber + 1
			end
			quiz:refresh()
		end,
		leftButtonUp = function()
			if questionNumber > 1 then
				questionNumber = questionNumber - 1
			end
			quiz:refresh()
		end	,
		AButtonUp = function()
			score += 1
			print(score)
			quiz:refresh()
		end,
		BButtonUp = function()
			print("Back to main screen")
			gfx.clear()
			quizSelect()
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
	self:drawScore();
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
		selectedBoxMargin = 8,
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
		rect.y = self.quiz.answer1y-self.quiz.selectedBoxMargin
	end
	if selected == 2 then
		print("answer 2");
		rect.y = self.quiz.answer2y-self.quiz.selectedBoxMargin
	end
	if selected == 3 then
		rect.y = self.quiz.answer3y-self.quiz.selectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end

function quiz:initializeQuestions(quizSelected)	
	table = playdate.datastore.read("json\\"..quizSelected)
	print(table["questions"]["1"]["text"])
end

function quiz:drawScore()
	gfx.drawTextInRect("Score: " .. score, 300, 10, 200, 20)
end