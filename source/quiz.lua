import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics
local questionNumber = 1
local selected = 1

class("quiz").extends()

function quiz:init()
    self.quiz = {
		questionx = 25,
		questiony = 25,
		answer1x = 50,
		answer1y =75,
		answer2y = 125,
		answer3y =175,
		width =300,
		height =20,
		selected = 1,
		slectedBoxMargin = 8,
		score = 0
	}
	self.table = null;
	local myInputHandlers = {
		upButtonUp = function()
			selected = selected - 1
		end,
	
		downButtonUp = function()
			selected = selected + 1
		end,
		rightButtonUp = function()
			if questionNumber < 4 then
				questionNumber = questionNumber + 1
			end
		end,
		leftButtonUp = function()
			if questionNumber > 1 then
				questionNumber = questionNumber - 1
			end
		end		
	}	
	playdate.inputHandlers.push(myInputHandlers)


	self:initializeQuestions()
	
end

function quiz:update()
    
end

function quiz:draw()
	self.quiz.selected = selected
    local quizParts = self.quiz;
	local text = self.table["questions"][tostring(questionNumber)]["text"]
	local option1 = self.table["questions"][tostring(questionNumber)]["option1"]
	local option2 = self.table["questions"][tostring(questionNumber)]["option2"]
	local option3 = self.table["questions"][tostring(questionNumber)]["option3"]

    gfx.drawTextInRect(text, quizParts.questionx, quizParts.questiony, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option1), quizParts.answer1x,quizParts.answer1y, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option2), quizParts.answer1x,quizParts.answer2y, quizParts.width, quizParts.height)
	gfx.drawTextInRect(tostring(option3), quizParts.answer1x,quizParts.answer3y, quizParts.width, quizParts.height)
	self:drawSelection();
	self:drawScore();
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
	if self.quiz.selected == 1 then
		rect.y = self.quiz.answer1y-self.quiz.slectedBoxMargin
	end
	if self.quiz.selected == 2 then
		print("answer 2");
		rect.y = self.quiz.answer2y-self.quiz.slectedBoxMargin
	end
	if self.quiz.selected == 3 then
		rect.y = self.quiz.answer3y-self.quiz.slectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end

function quiz:initializeQuestions()	
	self.table = playdate.datastore.read("json\\math1")
	print(self.table["questions"]["1"]["text"])
end

function quiz:drawScore()
	gfx.drawTextInRect("Score: " .. tostring(self.quiz.score), 300, 10, 200, 20)
end