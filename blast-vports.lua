-- send random notes / modwheel to all assigned devices

local send_to_all_vports = function(midi_data) 
    for i, port in ipairs(midi.vports) do
        if port.device ~= nil then
            port.device:send(midi_data)
        end
    end
end

local last_note = nil
local cc_num = 1

local next_note_value = function()
    return math.random(0, 36) + 36
end

local next_cc_value = function()
    return math.random(0, 127)
end

tick = function() 
    local cc_val = next_cc_value()
    local next_note = next_note_value()
    if last_note ~= nil then
        local noteoff_data = {type='note_off', note=last_note}
        send_to_all_vports(noteoff_data)
    end
    local noteon_data = {type='note_on', note=next_note}
    local cc_data = {type='cc', cc=cc_num, val=cc_val}
    send_to_all_vports(noteon_data)
    send_to_all_vports(cc_data)
    last_note = next_note
end

local time_delta = 0.25

init = function()

    print('midi vports:')
    for i, port in ipairs(midi.vports) do
        if port.device ~= nil then
            print(port.device.name)
        end
    end

    local m = metro.init(tick, time_delta)
    m:start()
end
