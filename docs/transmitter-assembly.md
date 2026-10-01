# Transmitter Assembly

The transmitter tower carries the ultrasonic transducer that gets tracked. It
is a stack of printed sections with a two-part holder on top that clamps the
transducer.

## Parts

STL exports are in `Transmitter-Models/STL/`; SolidWorks sources, the full
assembly (`Transmitter Assembly.SLDASM`) and its drawing
(`Transmitter Assembly.SLDDRW`) in `Transmitter-Models/Solidwork/`. Sizes are
the STL bounding box in millimetres (X × Y × Z as exported).

### Tower

Bottom to top:

| STL | Size (mm) | Role |
|---|---|---|
| `Transmitter-tower-base-flared` | 84.7 × 38.4 × 44.6 | Flared foot that mounts the tower to whatever is being tracked |
| `Transmitter-tower-middle` | 44.6 × 60 × 44.6 | 60 mm riser section |
| `Transmitter-tower-middle-2` | 44.6 × 35 × 44.6 | 35 mm riser section — combine with the 60 mm one to set the height |
| `Transmitter-tower-top-attachment` | 68 × 40 × 68 | Top of the tower; the transducer holder mounts on this |

### Transducer holders

Two variants, each printed as a top and bottom half that close around the
transducer:

| STL | Size (mm) | Role |
|---|---|---|
| `Transmitter-holder-multi-top` | 68 × 20.6 × 68 | Top half of the 68 mm ring holder for a multi-transducer head |
| `Transmitter-holder-multi-bottom` | 68 × 10.5 × 68 | Bottom half of the same ring |
| `Transmitter-holder-single-top` | 10.5 × 9 × 28.9 | Top half of the clip for a single transducer |
| `Transmitter-holder-single-bottom` | 20 × 19 × 28.9 | Bottom half of the single-transducer clip |

The **multi** holder's 68 mm footprint matches the top attachment; the
**single** holder is a small clip for one transducer. Print the pair for
whichever head you are building. `Transmitter Assembly.SLDASM` shows the
default build.

## Printing

Print the four tower sections (or only the risers you need) and one holder
pair. All are exported in their intended orientation.

## Building the tower

1. Stack **base-flared → middle and/or middle-2 → top-attachment**. Use the
   60 mm riser, the 35 mm riser, or both to bring the transducer to the same
   height as the receivers.
2. Clamp the transducer between the two halves of the holder.
3. Seat the loaded holder on the top attachment.
4. Fix the flared base to the platform being tracked, with the transducer
   facing outwards so it has a clear line to the receivers around the arena.
