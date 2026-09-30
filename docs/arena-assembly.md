# Arena Assembly

The arena is the rectangle of six receiver towers inside which the transmitter
is tracked. Its geometry is what the control software multilaterates against,
so the physical layout and the numbers entered in `ultragps-control` have to
agree.

## Layout

Six receivers stand in two columns of three, one column on each long side of
the rectangle. The origin of the coordinate system is the **centre** of the
arena; X runs across the short side, Y along the long side. All units are
centimetres.

```
            Y
            ▲
   3 ●      │      ● 6      y = +186.9
     │      │      │
   2 ●──────┼──────● 5  ──► X   y = 0
     │      │      │
   1 ●      │      ● 4      y = −186.9
            │
   x = −127        x = +127
```

| Label | Config id | Position (cm) |
|------:|----------:|---------------|
| 1 | 0 | (−127.0, −186.94) |
| 2 | 1 | (−127.0, 0.0) |
| 3 | 2 | (−127.0, +186.94) |
| 4 | 3 | (+127.0, −186.9) |
| 5 | 4 | (+127.0, 0.0) |
| 6 | 5 | (+127.0, +186.9) |

These are the positions in the calibrated `config/config.toml` shipped with
UltraGPS-Control, giving a **254 cm × 373.9 cm** arena. The GUI labels receivers
`1`–`6` to match the numbers written on the hardware; the config file and the
firmware use ids `0`–`5`. Receiver *n* is wired to base-station pin `A(n−1)`.

!!! note "The layout is a convention, not a constraint"
    The solver only needs the receiver coordinates, so any placement works as
    long as the config matches it. The two-column layout is what the Setup
    panel's distance entry (R1–R10 below) and the on-screen arena outline
    assume, and it is what the towers and base parts were designed for.

## Arena base parts

The receivers sit on a **PVC-pipe frame**. The printed parts for it are under
`Receiver-Arena-Models/Solidwork/PVC-Arena-Base-Parts/`:

| Part (SolidWorks) | Role |
|---|---|
| `PVC Holder Assm.SLDASM` | Assembly of the parts below on a PVC section |
| `standExtenderPVCBase.SLDPRT` | Extender that mounts a receiver tower onto the PVC pipe |
| `standExtenderPVCBaseWithPCBHolder.SLDPRT` | Same extender with an integrated circuit-board holder |
| `circuitBoardHolder.SLDPRT` | Stand-alone holder for a receiver's PCB |
| `standExtender.SLDPRT` | Plain extender (same part as the receiver tower's middle connector) |

!!! warning "No STL exports yet"
    `Receiver-Arena-Models/STL/Arena-Base/` is empty. These parts exist only as
    SolidWorks sources; export them to STL from SolidWorks before printing.

## Building the arena

1. **Cut and lay out the PVC frame** so the six receiver mounting points land
   on the coordinates above — two straight runs of ~374 cm, 254 cm apart, with
   a mounting point at each end and one in the middle of each run.
2. **Fit an extender at each mounting point.** Use
   `standExtenderPVCBaseWithPCBHolder` where the receiver's board will sit on
   the frame, or `standExtenderPVCBase` plus a `circuitBoardHolder` where the
   board is mounted separately.
3. **Build and seat the six receiver towers** — see
   [Receiver Assembly](receiver-assembly.md) — numbering them 1–6 as in the
   diagram.
4. **Route the six echo lines** back to the base-station Arduino. The base
   station reads all six on `A0`–`A5` in one register read, so every receiver
   must land on an analog pin; see the wiring table in
   [Receiver Assembly](receiver-assembly.md#wiring-to-the-base-station).
5. **Measure the as-built distances** between towers with a tape measure. The
   Setup panel takes distances *between* receivers rather than absolute
   coordinates because they are far easier to measure accurately.

## Entering the arena in the control software

Open **Setup** in `ultragps-control`. It builds the receiver coordinates from
ten measured distances:

| Field | Meaning | Reference value (cm) |
|---|---|---|
| R1 | Receiver 3 → 2 (along Y) | 186.9 |
| R2 | Receiver 2 → 1 (along Y) | 186.9 |
| R3 | Receiver 1 → 4 (along X) | 254.0 |
| R4 | Receiver 4 → 5 (along Y) | 186.9 |
| R5 | Receiver 5 → 6 (along Y) | 186.9 |
| R6 | Receiver 6 → 3 (along X) | 254.0 |
| R7 | Origin → receiver 2 (along X) | 127.0 |
| R8 | Origin → receiver 5 (along X) | 127.0 |
| R9 | Y offset of receiver 2 from the origin | 0.0 |
| R10 | Y offset of receiver 5 from the origin | 0.0 |

Alternatively press **Re-dimension** and give the overall width and height to
generate a symmetric rectangle. Then:

1. Place the two **calibration points**. The reference config uses
   `cal_point_1 = (0, 76)` and `cal_point_2 = (−76, 0)`; Re-dimension defaults
   them to `(0, ±height/4)`. Mark these spots on the floor — the transmitter is
   put there during calibration.
2. Press **Verify & Save**. This sets `valid_settings = true` in `config.toml`
   and stores each receiver's distance to both calibration points.
3. Run **Calibration** with the transmitter at each point in turn. Calibration
   has to be redone whenever a receiver moves.

See the [UltraGPS-Control usage guide](https://imperious22m.github.io/UltraGPS-Control/usage/)
for the panels in detail.
