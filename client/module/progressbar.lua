function progressBar(duration, label, useWhileDead, canCancel, anim_dict, anim_clip, anim_flag, disable_move, disable_car, disable_combat)
    if config.progressBar == 'qb-progressbar' then
        local isDone, success = false, false

        exports['progressbar']:Progress({
            name            = 'prog_' .. GetGameTimer(),
            duration        = duration,
            label           = label,
            useWhileDead    = useWhileDead,
            canCancel       = canCancel,
            controlDisables = {
                disableMovement    = disable_move,
                disableCarMovement = disable_car,
                disableMouse       = false,
                disableCombat      = disable_combat,
            },
            animation = {
                animDict = anim_dict,
                anim     = anim_clip,
                flags    = anim_flag,
            },
            prop    = {},
            propTwo = {},
        }, function(cancelled)
            success = not cancelled
            isDone  = true
        end)

        while not isDone do
            Citizen.Wait(0)
        end

        return success
        
    elseif config.progressBar == 'ox_lib' then
        return lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = useWhileDead,
            canCancel = canCancel,
            anim = {
                dict = anim_dict,
                clip = anim_clip,
                flag = anim_flag
            },
            disable = {
                move = disable_move,
                car = disable_car,
                combat = disable_combat
            }
        })
    end

    return false
end