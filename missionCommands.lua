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
        --Menu_path
        do
            ---The opaque handle every missionCommands add* call hands back: an array of
            ---the menu titles leading to that entry. Pass it as the `path` of a nested
            ---item, or to the matching removeItem* to delete the entry again.
            ---@class Menu_path
            ---@field [number] string
        end
    end

    ---The missionCommands singleton allows for greater access and flexibility of use for the F10 Other radio menu. Added commands can contain sub-menus and directly call lua functions.
    ---https://wiki.hoggitworld.com/view/DCS_singleton_missionCommands
    ---@class missionCommands
    missionCommands = {}


    --Functions
    do
        ---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for both teams. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu. Path is an optional value that defines whether or not the command will be in a named submenu. FunctionToCall is the name of the function, with the optional argument value designating any passed values.
        ---https://wiki.hoggitworld.com/view/DCS_func_addCommand
        ---@ExampleDesc A submenu with one command under it, carrying a payload
        ---@Example local menu = missionCommands.addSubMenu('Support')
        ---@Example missionCommands.addCommand('Request CAS', menu, request, {kind = 'CAS'})
        ---@generic A
        ---@param name string
        ---@param path? Menu_path nil puts the command in the root menu
        ---@param functionToRun fun(arg: A)
        ---@param anyArguement? A handed straight back to functionToRun on click
        ---@return Menu_path path pass this to missionCommands.removeItem to delete it again
        function missionCommands.addCommand(name, path, functionToRun, anyArguement) end

        ---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for the specified coalition. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu. Path is an optional value that defines whether or not the command will be in a named submenu. FunctionToCall is the name of the function, with the optional argument value designating any passed values.
        ---https://wiki.hoggitworld.com/view/DCS_func_addCommandForCoalition
        ---@generic A
        ---@param coalitionSide coalition.side
        ---@param name string
        ---@param path? Menu_path nil puts the command in the root menu
        ---@param functionToRun fun(arg: A)
        ---@param anyArguement? A handed straight back to functionToRun on click
        ---@return Menu_path path pass this to missionCommands.removeItemForCoalition to delete it again
        function missionCommands.addCommandForCoalition(coalitionSide, name, path, functionToRun, anyArguement) end

        ---Adds a command to the "F10 Other" radio menu allowing players to run specified scripting functions. Command is added for the specified groupId. The string name is the text that will be displayed in the F10 Other menu and is also used in the function to remove the command from the menu. Path is an optional value that defines whether or not the command will be in a named submenu. FunctionToCall is the name of the function, with the optional argument value designating any passed values.
        ---https://wiki.hoggitworld.com/view/DCS_func_addCommandForGroup
        ---@generic A
        ---@param groupId number
        ---@param name string
        ---@param path? Menu_path nil puts the command in the root menu
        ---@param functionToRun fun(arg: A)
        ---@param anyArguement? A handed straight back to functionToRun on click
        ---@return Menu_path path pass this to missionCommands.removeItemForGroup to delete it again
        function missionCommands.addCommandForGroup(groupId, name, path, functionToRun, anyArguement) end

        ---Creates a submenu of a specified name for all players. Can be used to create nested sub menues. If the path is not specified, submenu is added to the root menu.
        ---https://wiki.hoggitworld.com/view/DCS_func_addSubMenu
        ---@nodiscard
        ---@param name string
        ---@param path? Menu_path nil puts the submenu in the root menu
        ---@return Menu_path path pass this as the path of the items that go inside it
        function missionCommands.addSubMenu(name, path) end

        ---Creates a submenu of a specified name for the specified coalition. Can be used to create nested sub menues. If the path is not specified, submenu is added to the root menu.
        ---https://wiki.hoggitworld.com/view/DCS_func_addSubMenuForCoalition
        ---@nodiscard
        ---@param coalitionSide coalition.side
        ---@param name string
        ---@param path? Menu_path nil puts the submenu in the root menu
        ---@return Menu_path path pass this as the path of the items that go inside it
        function missionCommands.addSubMenuForCoalition(coalitionSide, name, path) end

        ---Creates a submenu of a specified name for the specified group. Can be used to create nested sub menues. If the path is not specified, submenu is added to the root menu.
        ---https://wiki.hoggitworld.com/view/DCS_func_addSubMenuForGroup
        ---@nodiscard
        ---@param groupId number
        ---@param name string
        ---@param path? Menu_path nil puts the submenu in the root menu
        ---@return Menu_path path pass this as the path of the items that go inside it
        function missionCommands.addSubMenuForGroup(groupId, name, path) end

        --No Docu
        function missionCommands.doAction() end

        ---Removes the item of the specified path from the F10 radio menu for all. If the value is nil all items will be removed from the radio menu. If the path given is a submenu then all items nested within will be removed.
        ---https://wiki.hoggitworld.com/view/DCS_func_removeItem
        ---@param path? Menu_path nil clears the whole F10 Other menu
        function missionCommands.removeItem(path) end

        ---Removes the item of the specified path from the F10 radio menu for the specified coalition. If the value is nil all items will be removed from the radio menu.
        ---https://wiki.hoggitworld.com/view/DCS_func_removeItemForCoalition
        ---@param coalitionSide coalition.side
        ---@param path? Menu_path nil clears the whole F10 Other menu for that coalition
        function missionCommands.removeItemForCoalition(coalitionSide, path) end

        ---Removes the item of the specified path from the F10 radio menu for the specified group. If the value is nil all items will be removed from the radio menu.
        ---https://wiki.hoggitworld.com/view/DCS_func_removeItemForGroup
        ---@param groupId number
        ---@param path? Menu_path nil clears the whole F10 Other menu for that group
        function missionCommands.removeItemForGroup(groupId, path) end
    end
end
