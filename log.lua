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
        --Log_level
        do
            ---A log level / output rule: one of the log.* constants, or several of
            ---them added together. They are BIT FLAGS, so log.ERROR + log.WARNING is
            ---a valid value even though no single constant carries that number --
            ---which is why this is an alias over number and not an @enum.
            ---@alias Log_level number
        end
    end

    ---The log singleton writes into dcs.log directly, below env.info / env.warning /
    ---env.error. The constants sit FLAT on the log table alongside its functions --
    ---log.INFO, log.write -- exactly as DCS exposes them.
    ---Several names share a value on purpose (ERROR and THREAD are both 8, MESSAGE
    ---and ASYNC both 0); that is DCS's own table, not a transcription slip.
    ---@class log
    log =
    {
        MESSAGE          = 0,
        ASYNC            = 0,
        TIME             = 1,
        TIME_UTC         = 1,
        IMMEDIATE        = 1,
        LEVEL            = 2,
        ALERT            = 2,
        MODULE           = 4,
        THREAD           = 8,
        ERROR            = 8,
        WARNING          = 16,
        INFO             = 64,
        DEBUG            = 128,
        TIME_RELATIVE    = 128,
        TIME_LOCAL       = 129,
        EXTRA_INFO       = 512,
        MODELTIME        = 512,
        ALL              = 255,
        ALL_LEVELS       = 255,
        TRACE            = 256,
        FULL             = 271,
        NO_HEADER_FOOTER = 16384,
        RELIABLE         = 32768,
        BACKUP           = 32768,
    }

    --Functions
    do
        --no Docu
        function log.alert() end

        --no Docu
        function log.debug() end

        --no Docu
        function log.error() end

        --no Docu
        function log.info() end

        --no Docu
        function log.set_output() end

        --no Docu
        function log.set_output_rules() end

        --no Docu
        function log.warning() end

        --no Docu
        ---@param logger string
        ---@param level Log_level
        ---@param msg string
        function log.write( logger, level, msg ) end

        --no Docu
        function log.backup() end
    end
end
