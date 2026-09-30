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

!!! note "Part naming"
    The STL and SolidWorks names now match, but a few are worth knowing:
    `Transmitter-holder-multi-bottom` was exported from the part originally
    called *Transmitter HolderTop*, and `Transmitter-tower-top-attachment`
    from *Transmitter base attachment*. The `single` holder sources live under
    `Receiver-Arena-Models/Solidwork/Receiver-Parts/` despite being
    transmitter parts. `Transmitter-holder-multi-top.STL` is a 3.5 MB mesh
    (72k triangles) — slice it once and keep the G-code.

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

## Transmitter-station wiring

| Pin | Direction | Signal |
|---|---|---|
| `2` | IN | nRF24L01+ `IRQ` — must be an interrupt-capable pin; `onRadioIRQ()` runs on the falling edge |
| `3`, `4`, `6` | OUT | `STAT_1`–`STAT_3` LEDs (reserved) |
| `5` | OUT | Trigger to the ultrasonic transmitter, 50 µs pulse |
| `7` | OUT | `PULSE_TRIG` LED — lit after the first trigger fires |
| `8` | OUT | `RADIO_STATUS` LED — solid once the radio initialises; slow blink = radio init failed |
| `9` / `10` | OUT | nRF24L01+ `CE` / `CSN` |
| `11`–`13` | — | Hardware SPI to the radio |

Unlike the base station, the transmitter station has **no serial command
interface**. Once flashed it runs on its own: every radio packet from the base
station nudges its Timer1 back into phase (`pllCorrect`), and every compare
match at 10 Hz fires the trigger after the `tick_delay` the packet carried
(2 ms by default, giving the receivers time to settle into receive mode).

!!! note "It is the radio *receiver*"
    The firmware directory is `transmitter-station/` because the board drives
    the ultrasonic transmitter, but on the radio link it is the receiving end —
    its source comments call it the *receiver program*. Both are right.

## Flashing and checking

Flash the prebuilt image from the
[UltraGPS-Arduino releases](https://github.com/Imperious22M/UltraGPS-Arduino/releases/latest):

```bash
arduino-cli upload -p /dev/ttyACM1 -b arduino:avr:uno \
    --input-file ultragps-transmitter-station-v1.0.hex
```

Then:

1. Power the transmitter station. `RADIO_STATUS` (pin 8) should go solid. If it
   blinks on a two-second cycle the radio did not initialise — check the SPI
   wiring and the capacitor.
2. Send `P` to the base station over serial. `PULSE_TRIG` (pin 7) on the
   transmitter lights on the first trigger, and the base station prints six
   non-zero tick counts if the transducer has line of sight to the receivers.
3. Place the transmitter on each calibration point and run **Calibration** in
   `ultragps-control`, then open **Position** to see it tracked.

The pulse rate, radio channel, and pipe addresses are compile-time settings
that must match on both Arduinos — see the
[firmware configuration reference](https://imperious22m.github.io/UltraGPS-Arduino/configuration/).

## Work in progress

`scratch/` (git-ignored) holds unfinished transmitter-side parts:
`Doppler Probe Extension.SLDPRT`, `transceiver.SLDPRT`, `leftside` /
`rightside` halves, and a set of weighted base variants
(`Base_*_weighted.stl`). None are part of the current assembly.
