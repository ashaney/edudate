local pd <const> = playdate
local gfx <const> = playdate.graphics

class('SceneManager').extends()

function SceneManager:switchScene(scene)
    self.newScene = scene
    self:loadNewScene()
end

function SceneManager:loadNewScene()
    self:cleanupScene()
    self.newScene()    
end

function SceneManager: cleanupScene()
    gfx.sprite.removeAll()
end
