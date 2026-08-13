--[[
    Script by Tobias00723                          ████████
    from the TGFB server                      ████████  ████████
    Discord : https://discord.gg/hEHd4A3czx ██████          ██████
    any questions?                   ^^   ████     ▒      ▒     █████
    find me on my discord server     ^^ ████      ▒▒      ▒▒▒      ███
    _________________________________ ████       ▒▒▒      ▒▒▒       ███
                                      ███       ▒▒▒▒      ▒▒▒▒       ███
                                     ██       ▒▒▒▒        ▒▒▒▒▒      ███
                                    ███      ▒▒▒▒▒▒        ▒▒▒▒▒▒      ███
        Script as is.               ███     ▓▒▒▒▒▒▒        ▒▒▒▒▒▒▒     ███
                                    ███    ▒▒▒▒▒▒▒▒        ▓▒▒▒▒▒▒▓    ███
        Enjoy The open sauce!       ███   ▓▒▒▓▒▒▓▒▓         ▒▒▓▒▒▒▒▒   ███
                                    ███  ▓▒▓▓▒▓▓▒▓          ▓▓▒▓▓▓▓▓▓  ███
   If used credit, is appreaciated.  █  ▓▓▓▒▓ ▓▓▓▒          ▓▓▓▓ ▒▓▒▓▓  █
        Happy "borrowing" :)           ▓▓▓▓    ▓▓▓   ████    ▓▓▓   ▓▓▓▓
    _________________________________ ▓▓▓      ▓▓    ▓▓▓▓    ▓▓      ▓▓▓
                                     ▓▓        ▓▓    ▓▓▓▓    ▓▓        ▓▓
                                    ▓▓          ▓    ▓▓▓▓     ▓         ▓▓
    Copyright (c) 2025 TGFB                          ▓▓▓▓
    All rights reserved.                             ▓▓▓▓
]]


do
    ---@meta

    --classes
    do
    end

    ---atmosphere is a singleton whose functions return atmospheric data about the mission. Currently limited only to wind data.
    ---@class atmosphere
    atmosphere = {}

    --Functions
    do
        ---Returns the temperature and pressure at a given point in 3d space. Temperature is returned in Kelvins Pressure is returned in Pascals
        ---https://wiki.hoggitworld.com/view/DCS_func_getTemperatureAndPressure
        ---@param vec3 vec3
        ---@return number temperature Kelvin
        ---@return number pressure Pascals
        function atmosphere.getTemperatureAndPressure(vec3) end

        ---Returns a velocity vector of the wind at a specified point
        ---https://wiki.hoggitworld.com/view/DCS_func_getWind
        ---@param vec3 vec3
        ---@return vec3 wind a velocity vector in m/s, pointing the way the wind blows TO
        function atmosphere.getWind(vec3) end

        ---Returns a velocity vector of the wind at a specified point, this time factoring turbulence into the equation.
        ---https://wiki.hoggitworld.com/view/DCS_func_getWindWithTurbulence
        ---@param vec3 vec3
        ---@return vec3 wind a velocity vector in m/s, pointing the way the wind blows TO
        function atmosphere.getWindWithTurbulence(vec3) end
    end
end
