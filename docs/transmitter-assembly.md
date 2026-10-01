# Transmitter Assembly

The transmitter is the mobile part of the system: an ultrasonic transmitter on
a tower, driven by its own Arduino Uno (the *transmitter station*) that stays
phase-locked to the base station over a 2.4 GHz radio link. It is the thing
being tracked — put it on the vehicle, robot, or person whose position you
want.

## Parts

### Printed

Exports are in `Transmitter-Models/STL/`; sources and the full assembly
(`Transmitter Assembly.SLDASM`, with a drawing in
`Transmitter Assembly.SLDDRW`) in `Transmitter-Models/Solidwork/`.

**Tower**, bottom to top:

| STL | Size (mm) | Role |
|---|---|---|
| `Transmitter-tower-base-flared` | 84.7 × 38.4 × 44.6 | Flared foot that mounts the tower to the vehicle or platform |
| `Transmitter-tower-middle` | 44.6 × 60 × 44.6 | 60 mm riser section |
| `Transmitter-tower-middle-2` | 44.6 × 35 × 44.6 | 35 mm riser section — combine with the 60 mm one to set height |
| `Transmitter-tower-top-attachment` | 68 × 40 × 68 | Top of the tower; the transducer holder mounts on this |

**Transducer holders** — two variants:

| STL | Size (mm) | Role |
|---|---|---|
| `Transmitter-holder-multi-top` | 68 × 20.6 × 68 | Top half of the 68 mm ring holder for a multi-transducer head |
| `Transmitter-holder-multi-bottom` | 68 × 10.5 × 68 | Bottom half of the same ring |
| `Transmitter-holder-single-top` | 10.5 × 9 × 28.9 | Top half of the clip for a single transducer |
| `Transmitter-holder-single-bottom` | 20 × 19 × 28.9 | Bottom half of the single-transducer clip |

The **multi** holder's 68 mm footprint matches the top attachment; the
**single** holder is a small clip for one HC-SR04-style transducer. Print the
pair for whichever head you are building.

### Electronics

| Item | Qty | Notes |
|---|---|---|
| Arduino Uno | 1 | The transmitter station |
| nRF24L01+ radio module | 1 | 2.4 GHz, SPI, with a 10 µF capacitor across `VCC`/`GND` |
| HC-SR04-style ultrasonic transmitter | 1 | Trigger pin driven from Uno pin `5` |
| Status LEDs + resistors | 5 | Optional; pins 3, 4, 6, 7, 8 |
| Battery / power for the Uno | 1 | The transmitter is untethered |

## Building the tower

1. Print the four tower sections and one holder pair.
2. Stack **base-flared → middle (and/or middle-2) → top-attachment**. Use the
   60 mm, the 35 mm, or both risers to bring the transducer up to the same
   height as the receivers.
3. Clamp the transducer in the holder — the two halves close around it — and
   seat the holder on the top attachment.
4. Mount the flared base on the platform to be tracked, with the transducer
   facing up / outwards so it has line of sight to the receivers on both sides
   of the arena.
5. Mount the transmitter-station Uno, radio, and power on the same platform
   and wire the transducer's trigger to pin `5`.