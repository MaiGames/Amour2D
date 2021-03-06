local class = require "lib.lua-oop"

local Geometry = require "amour.util.math.geometry"
local Color = require "amour.util.color"

local StageObject = require "amour.stage.object"

local Basic = {}

-- BASIC SHAPES

local RectangleObj = class("Obj-Rect", StageObject)
Basic.RectangleObj = RectangleObj

function RectangleObj:constructor(position, rotation, size, color)

    StageObject.constructor(self, position, rotation, size, color)

end

function RectangleObj:update(dt)

    self:setPolygon(GeometryRect.getRectanglePolygon(self.absPosition, self.absRotation, self.size, self.offset))

end

function RectangleObj:draw()

    if not self.drawPoly then
        return 
    end

    local r, g, b, a = self.color:getDecimal()

    love.graphics.push()
    love.graphics.setColor(r, g, b, a)
    love.graphics.polygon("fill", self.drawPoly)
    love.graphics.pop()

end

local CircleObj = class("Obj-Circle", StageObject)
Basic.CircleObj = CircleObj

function CircleObj:constructor(position, rotation, radius, color)

    if not radius then
        radius = 20
    end

    StageObject.constructor(self, position, rotation, Geometry.Vector2:new(radius, radius), color)

    self.radius = radius

end

function CircleObj:update()

    self.size:set(self.radius, self.radius)

end

function CircleObj:draw()

    local r, g, b, a = self.color:getDecimal()

    love.graphics.push()
    love.graphics.setColor(r, g, b, a)
    love.graphics.circle("fill", self.absPosition.x, self.absPosition.y, self.radius)
    love.graphics.pop()

end

StaticSpriteObj = class("Obj-StaticSprite", StageObject)
Basic.StaticSpriteObj = StaticSpriteObj

function StaticSpriteObj:constructor(position, rotation, size, color, image)

    StageObject.constructor(self, position, rotation, size, color)

    self.image = image

end

function StaticSpriteObj:init()

    if type(self.image) == "string" then
        self.image = love.graphics.newImage(self.image)
    end

end

function StaticSpriteObj:update()

    self.poly, self.drawPoly = GeometryRect.getRectanglePolygon(self.absPosition, self.absRotation, self.size, self.offset)

end

function StaticSpriteObj:draw()

    local r, g, b, a = self.color:getDecimal()

    local scaleX, scaleY = Core.getImageScaleForNewDimensions(self.image, self.size.x, self.size.y)

    love.graphics.push()
    love.graphics.translate(self.absPosition.x, self.absPosition.y)
    love.graphics.rotate(self.absRotation:get())
    love.graphics.setColor(r, g, b, a)
    love.graphics.draw(self.image, 0 - (self.size.x * self:getOffset()), 0 - (self.size.y * self:getOffset()), nil, scaleX, scaleY)
    love.graphics.pop()

end

function StaticSpriteObj:setOriginalDimensions()

    local w, h = self.image:getDimensions()
    self.size:set(w, h)

end

-- MISCELANEOUS


ParentObj = class("Obj-Parent", StageObject)
Basic.ParentObj = ParentObj

function ParentObj:constructor()

    local Vector2 = Geometry.Vector2
    local Rotation2 = Geometry.Rotation2

    StageObject.constructor(self, Vector2:new(0, 0, false), Rotation2:new(0, false), Vector2:new(0, 0, false), Color:new(0, 0, 0, 0))

end

FpsObj = class("Obj-Fps", StageObject)
Basic.FpsObj = FpsObj

function FpsObj:constructor(position, color)

    StageObject.constructor(self, position, nil, nil, color)

end

function FpsObj:draw()

    love.graphics.push()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.print(tostring(love.timer.getFPS()), self.absPosition.x, self.absPosition.y)
    love.graphics.pop()

end

MouseObj = class("Obj-Mouse", StageObject)
Basic.MouseObj = MouseObj

function MouseObj:constructor()

    StageObject.constructor(self, nil, nil, Geometry.Vector2:new(6, 6), nil)

end

function MouseObj:update()
    self.position:set(love.mouse.getX(), love.mouse.getY())
end

TextObj = class("Obj-Text", StageObject)
Basic.TextObj = TextObj

function TextObj:constructor(position, color, text, fontSize)

    StageObject.constructor(self, position, nil, nil, color)

    if not fontSize then
        fontSize = 12
    end

    if not text then
        text = ""
    end

    self.text = text
    self.fontSize = fontSize

end

function TextObj:draw()

    love.graphics.push()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.setNewFont(self.fontSize)
    love.graphics.print(tostring(self.text), self.absPosition.x, self.absPosition.y)
    love.graphics.pop()

end

return Basic
