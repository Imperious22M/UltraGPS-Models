# UltraGPS Models

3D-printable hardware for the St. Mary's University **UltraGPS** indoor
positioning system, developed as part of graduate research.

This repository holds the SolidWorks sources and STL exports for every printed
part in the system: the **arena** that holds the six receivers, the **receiver
towers**, and the **transmitter** tower and holders. The parts here are the
physical counterpart to the three software repositories that make the system
run:

| Repository | What it is | Documentation |
|---|---|---|
| [UltraGPS-Arduino](https://github.com/Imperious22M/UltraGPS-Arduino) | Firmware for the base-station and transmitter-station Arduino Unos | [docs](https://imperious22m.github.io/UltraGPS-Arduino/) |
| [UltraGPS-Ground](https://github.com/Imperious22M/UltraGPS-Ground) | `UltraGpsXY` — serial ↔ network bridge on the ground-station PC | [docs](https://imperious22m.github.io/UltraGPS-Ground/) |
| [UltraGPS-Control](https://github.com/Imperious22M/UltraGPS-Control) | Operator GUI: arena setup, calibration, live position, barriers | [docs](https://imperious22m.github.io/UltraGPS-Control/) |

## How the system fits together

```
   ┌──────────────────────────────────────────────────────────────┐
   │  ARENA  (254 cm × 374 cm, receivers 1–6 on the long sides)   │
   │                                                              │
   │   3 ●────────────────────────────────────────────────● 6     │
   │     │                                                │       │
   │   2 ●                    ▲ transmitter               ● 5     │
   │     │                (moves freely)                  │       │
   │   1 ●────────────────────────────────────────────────● 4     │
   └──────────────────────────────────────────────────────────────┘
        │ six echo lines (A0–A5)                 ▲ nRF24 trigger
        ▼                                        │
   Base-station Arduino ──────── 2.4 GHz ────── Transmitter-station Arduino
        │ USB serial, 38400 bps
        ▼
   UltraGpsXY  (ground-station PC)   TCP 9000 / UDP 9001
        │
        ▼
   ultragps-control  (operator GUI)  → position, NMEA, barrier feeds
```

A measurement works like this: the base station sends a radio packet, both
Arduinos fire their trigger pins on the next Timer1 compare match (10 Hz), the
transmitter emits an ultrasonic burst, and the base station times when each of
the six receiver echo lines changes state. The six tick counts go up the chain
where `ultragps-control` converts them to centimetres with a per-receiver
linear calibration and multilaterates a 2D position.

## Documentation

- **[Arena Assembly](arena-assembly.md)** — the receiver layout and geometry,
  the PVC arena base parts, and how to enter the arena into the control
  software.
- **[Receiver Assembly](receiver-assembly.md)** — building one of the six
  receiver towers and wiring it to the base station.
- **[Transmitter Assembly](transmitter-assembly.md)** — the transmitter tower,
  the transducer holders, and the transmitter-station electronics.

## At a glance

| | |
|---|---|
| CAD tool | SolidWorks (`.SLDPRT`, `.SLDASM`, `.SLDDRW`) |
| Print files | Binary STL, millimetres |
| Receivers | 6, in two columns of 3 |
| Reference arena | 254 cm × 373.9 cm (from the calibrated `config.toml`) |
| Microcontrollers | 2 × Arduino Uno (base station, transmitter station) |
| Radio | nRF24L01+, channel 100, 1 Mbps |
| Ultrasonic | HC-SR04-style transmitter and receivers, 50 µs trigger pulse |

## Repository layout

```
Transmitter-Models/
  Solidwork/   parts, Transmitter Assembly.SLDASM and its drawing (.SLDDRW)
  STL/         tower sections and transducer holders
Receiver-Arena-Models/
  Solidwork/
    Receiver-Parts/          receiver tower parts + assemblies
    PVC-Arena-Base-Parts/    PVC-pipe arena base extenders and PCB holder
  STL/
    Receiver-Holder/         receiver tower exports
    Arena-Base/              (empty — arena base STLs not yet exported)
docs/          this site
```

Every `.SLDPRT` that has an STL export shares its basename with that STL, so
`Transmitter-tower-middle.SLDPRT` is the source of
`Transmitter-tower-middle.STL`.

## Printed-part inventory

All dimensions are the STL bounding box in millimetres (X × Y × Z as exported).

| STL | Size (mm) | Used in |
|---|---|---|
| `Receiver-tower-base` | 100 × 80 × 100 | [Receiver](receiver-assembly.md) |
| `Receiver-tower-middle-connector` | 20 × 80 × 20 | [Receiver](receiver-assembly.md) |
| `Receiver-tower-top-ultrasonic-holder` | 45 × 55.4 × 20 | [Receiver](receiver-assembly.md) |
| `Transmitter-tower-base-flared` | 84.7 × 38.4 × 44.6 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-tower-middle` | 44.6 × 60 × 44.6 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-tower-middle-2` | 44.6 × 35 × 44.6 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-tower-top-attachment` | 68 × 40 × 68 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-holder-multi-top` | 68 × 20.6 × 68 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-holder-multi-bottom` | 68 × 10.5 × 68 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-holder-single-top` | 10.5 × 9 × 28.9 | [Transmitter](transmitter-assembly.md) |
| `Transmitter-holder-single-bottom` | 20 × 19 × 28.9 | [Transmitter](transmitter-assembly.md) |
