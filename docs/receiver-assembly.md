# Receiver Assembly

Each of the six receivers is an ultrasonic receiver module on a small PCB,
raised off the arena floor on a printed tower and wired back to the
base-station Arduino. This page covers one tower, six are needed for the default 
system setup.

## Parts

### Printed

Exports are in `Receiver-Arena-Models/STL/Receiver-Holder/`; sources in
`Receiver-Arena-Models/Solidwork/Receiver-Parts/`.

| STL | Size (mm) | Role |
|---|---|---|
| `Receiver-tower-base` | 100 × 80 × 100 | Foot of the tower. Seats on the arena base / PVC extender. |
| `Receiver-tower-middle-connector` | 20 × 80 × 20 | 80 mm riser between base and top. Stack more than one to raise the receiver. |
| `Receiver-tower-top-ultrasonic-holder` | 45 × 55.4 × 20 | Cradle for the receiver module and its board. |

The SolidWorks assemblies show how they go together:

| Assembly | Contents |
|---|---|
| `ReceiverAssem.SLDASM` | Full tower |
| `receiverwithboardholder.SLDASM` | Receiver module + PCB in the top holder (`ReceiverWboard.SLDPRT` in `Receiver-tower-top-ultrasonic-holder`) |

### Electronics (per receiver)

| Item | Qty | Notes |
|---|---|---|
| Ultrasonic receiver module (HC-SR04-style receive side) | 1 | Echo output goes to the base station |
| Receiver PCB | 1 | Modelled as `ReceiverWboard.SLDPRT`; KiCad sources live outside this repo |
| Cable to the base station | 1 | Long enough to reach the base station from the far end of the arena (up to ~4 m) |

## Building a tower

1. Print the three parts. They are designed for the orientation they were
   exported in; the base is the tallest print at 100 mm.
2. Press the **middle connector** into the base. Add a second connector if the
   receiver needs to sit higher — the transmitter and receivers should be at
   roughly the same height so the direct path, not a floor reflection, is the
   first echo.
3. Fit the receiver module and its board into the **top holder**, then seat
   the holder on the connector.
4. Point the receiver towards the centre of the arena.
5. Label the tower **1–6** according to its position in the
   [arena layout](arena-assembly.md#layout).

## Wiring to the base station

All six echo lines terminate on the base-station Arduino Uno. The firmware
reads them as a group with a single `PINC & 63` register read, so they **must**
stay on `A0`–`A5` — a receiver moved to a digital pin is silently dropped from
the measurement.

| Receiver label | Config id | Base-station pin |
|---:|---:|---|
| 1 | 0 | `A0` |
| 2 | 1 | `A1` |
| 3 | 2 | `A2` |
| 4 | 3 | `A3` |
| 5 | 4 | `A4` |
| 6 | 5 | `A5` |

The pins are configured `INPUT_PULLUP`; an unconnected receiver reads as a
constant high and reports `0` ticks, which the control software's sanity filter
then drops. Fewer than six receivers works; more than six needs firmware
changes.
