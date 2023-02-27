import "sceneManager"
import "quiz"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local quizSelected = null
local selected = 1
quiz = quiz
class("quizSelect").extends()

function quizSelect:init()    
	--self.table = null; read in list of possible json files later
	local myInputHandlers = {
		upButtonUp = function()
			selected = selected - 1
            print(tostring(selected))
			quizSelect:refresh()
		end,
	
		downButtonUp = function()
			selected = selected + 1
            print(tostring(selected))
			quizSelect:refresh()
		end,
        AButtonUp = function ()
            self:makeSelection()
        end
	}	
	playdate.inputHandlers.push(myInputHandlers)
	quizSelect:refresh()
end

function quizSelect:update()
	--quizSelect:drawSelection()
	
end

function quizSelect:refresh()
	gfx.clear()
	quizSelect:drawList()
	quizSelect:drawSelection()
end

function quizSelect:drawSelection()
	self.rect = {
		x = 21,
		y = 0,
		questiony = 25,
		width = 302,
		height= 28,
		slectedBoxMargin = 8
	}
	local rect = self.rect;
	if selected == 1 then
        print("selecting 1")
		rect.y = self.rect.questiony-self.rect.slectedBoxMargin
	end
	if selected == 2 then
        print("selecting 2")
		rect.y = self.rect.questiony + 50 -self.rect.slectedBoxMargin
	end
	if selected == 3 then
		rect.y = self.rect.questiony + 100 - self.rect.slectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end

function quizSelect:drawList()
	self.quiz = {
        x =25,
        y= 25,
		width =300,
		height =20
	}
	print("about to draw selects")
	self.quiz.selected = selected
    local listParts = self.quiz;
	local option1 = "Math";
	local option2 = "Geography"

	gfx.drawTextInRect(tostring(option1), listParts.x,listParts.y, listParts.width, listParts.height)
	gfx.drawTextInRect(tostring(option2), listParts.x,listParts.y+50, listParts.width, listParts.height)  
end

function quizSelect:makeSelection()
    print("A pressed")
    if selected == 1 then
        quizSelected = "math1"
		gfx.clear()
		quiz:init(quizSelected)
		
    end
    if selected == 2 then
        quizSelected = "geog1"
		gfx.clear()
		quiz:init(quizSelected)
    end
end

function quizSelect:getSelectedQuiz()
    if(quizSelected ~= nil) then
        print("returning selected quiz: ".. quizSelected)
        return quizSelected;
    end
end
