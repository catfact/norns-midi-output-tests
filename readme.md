two scripts:

`blast-devices.lua`

sends a sequence of random mod wheel values and note on/offs, to all connected MIDI devices (whether or not assigned to a `vport` / device slot.) all messages on channel 1. if a device doesn't seem to be receiving these messages, there may be a bug in norns which prevents device compatibility.

`blast-vports.lua`

sends same kind of messages to all vports and their assigned devices. if a device isn't receiving these, check vport->device assignment under `SYSTEM > DEVICES > MIDI` menu.
