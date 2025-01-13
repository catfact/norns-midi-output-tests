-- send random notes / modwheel to all devices (assigned or not)
local send_to_all_devices = function(midi_data) 
    local devices = midi.devices
    for i, device in ipairs(devices) do
        device:send(midi_data)
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
        send_to_all_devices(noteoff_data)
    end
    local noteon_data = {type='note_on', note=next_note}
    local cc_data = {type='cc', cc=cc_num, val=cc_val}
    send_to_all_devices(noteon_data)
    send_to_all_devices(cc_data)
    last_note = next_note
end

local time_delta = 0.25
i
nit = function()
    
    print('all midi devices:')
    for i, device in ipairs(devices) do
        print(device.name)
    end

    local m = metro.init(tick, time_delta)
    m:start()
end
