import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics
local quizSelected = null
local selected = 1

class("quizSelect").extends()

function quizSelect:init()
    self.quiz = {
        x =25,
        y= 25,
		width =300,
		height =20,
		selected = 1,
		slectedBoxMargin = 8
	}
	--self.table = null; read in list of possible json files later
	local myInputHandlers = {
		upButtonUp = function()
			selected = selected - 1
            print(tostring(selected))
		end,
	
		downButtonUp = function()
			selected = selected + 1
            print(tostring(selected))
		end,
        AButtonUp = function ()
            self:makeSelection()
        end
	}	
	playdate.inputHandlers.push(myInputHandlers)	
    
end

function quizSelect:update()
end

function quizSelect:draw()
    print("about to draw selects")
	self.quiz.selected = selected
    local listParts = self.quiz;
	local option1 = "Math";
	local option2 = "Geography"

	gfx.drawTextInRect(tostring(option1), listParts.x,listParts.y, listParts.width, listParts.height)
	gfx.drawTextInRect(tostring(option2), listParts.x,listParts.y+50, listParts.width, listParts.height)
	self:drawSelection();
end

function quizSelect:drawSelection()
	self.rect = {
		x = 21,
		y = 0,
		width = 302,
		height= 28
	}
	local rect = self.rect;
	if self.quiz.selected == 1 then
        print("selecting 1")
		rect.y = self.quiz.y-self.quiz.slectedBoxMargin
	end
	if self.quiz.selected == 2 then
        print("selecting 2")
		rect.y = self.quiz.y + 50 -self.quiz.slectedBoxMargin
	end
	if self.quiz.selected == 3 then
		rect.y = self.quiz.y + 100 - self.quiz.slectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end

function quizSelect:makeSelection()
    print("A pressed")
    if selected == 1 then
        quizSelected = "math1"
    end
    if selected == 2 then
        quizSelected = "geog1"
    end
end

function quizSelect:getSelectedQuiz()
    if(quizSelected ~= nil) then
        print("returning selected quiz: ".. quizSelected)
        return quizSelected;
    end
end
