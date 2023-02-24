import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("quiz").extends()

function quiz:init()
    self.label = {
		questionx = 25,
		questiony = 25,
		answer1x = 50,
		answer1y =75,
		answer2y = 125,
		answer3y =175,
		width =300,
		height =20,
		selected = 1,
		slectedBoxMargin = 8
	}
end

function quiz:update()
    
end

function quiz:draw(selected)
	self.label.selected = selected
    local label = self.label;
    gfx.drawTextInRect("Question: Where is Benis?", label.questionx, label.questiony, label.width, label.height)
	gfx.drawTextInRect("A:" .. " n ur butt", label.answer1x,label.answer1y, label.width, label.height)
	gfx.drawTextInRect("B:" .. " n ur mouf", label.answer1x,label.answer2y, label.width, label.height)
	gfx.drawTextInRect("C:" .. " n ur ear", label.answer1x,label.answer3y, label.width, label.height)
	self:drawSelection();
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
	if self.label.selected == 1 then
		rect.y = self.label.answer1y-self.label.slectedBoxMargin
	end
	if self.label.selected == 2 then
		print("answer 2");
		rect.y = self.label.answer2y-self.label.slectedBoxMargin
	end
	if self.label.selected == 3 then
		rect.y = self.label.answer3y-self.label.slectedBoxMargin
	end
	gfx.drawRect(rect.x, rect.y, rect.width, rect.height);
end