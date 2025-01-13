local midi = import("midi")

send_to_all_devices = function(midi_event) 
    local devices = midi.devices()
    for i, device in ipairs(devices) do
        device:send(midi_event)
    end
end

local last_note = nil
local cc_num = 1

tick = function() 
    local cc_val = next_cc_value()
    local next_note = next_note_value()
    if last_note ~= nil then
        send_to_all_devices(midi.note_off(last_note))
    end
    send_to_all_devices(midi.note_on(next_note))
    send_to_all_devices(midi.cc(cc_num, cc_val))
    last_note = next_note
end

local time_delta = 0.1
init = function()
    local m = metro.init(tick, time_delta)
    m:start()
end

local next_note_value = function()
    return math.random(0, 127)
end

local next_cc_value = function()
    return math.random(0, 127)
end
