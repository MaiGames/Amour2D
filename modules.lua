modules = {

    Core         = require "amour.core",
    Basic        = require "amour.objects.basic",

    Stage        = require "amour.stage",
    StageManager = require "amour.stage.manager",
    StageObject  = require "amour.stage.object",
    Hitbox       = require "amour.stage.hitbox",

    Timer        = require "amour.util.timer",
    TimerManager = require "amour.util.timer.manager",

    Color        = require "amour.util.color",
    Math         = require "amour.util.math",
    Vector       = require "amour.util.math.vector",

    class        = require "lib.lua-oop",

    declare = function()

        class = modules.class

        Core = modules.Core
        Basic = modules.Basic

        Stage = modules.Stage
        StageObject = modules.StageObject
        StageManager = modules.StageManager
        Hitbox = modules.Hitbox

        Color = modules.Color
        Math = modules.Math
        Vector = modules.Vector
        Vector2 = modules.Vector.Vector2

        Timer = modules.Timer
        TimerManager = modules.TimerManager

    end

}

return modules