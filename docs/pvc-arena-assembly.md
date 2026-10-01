# PVC Arena Assembly

The receiver towers stand on a frame of PVC pipe. The parts on this page are the
printed adapters that join a receiver tower to that pipe. They live in
`Receiver-Arena-Models/Solidwork/PVC-Arena-Base-Parts/`.

!!! warning "No STL exports yet"
    `Receiver-Arena-Models/STL/Arena-Base/` is empty. These parts exist only as
    SolidWorks sources.

## Parts

| Part (SolidWorks) | Role |
|---|---|
| `PVC Holder Assm.SLDASM` | Assembly showing the parts below fitted to a section of PVC pipe |
| `standExtenderPVCBase.SLDPRT` | Adapter that clamps to the pipe and presents a receiver-tower mount on top |
| `standExtenderPVCBaseWithPCBHolder.SLDPRT` | The same adapter with a circuit-board holder built in, for when the receiver's board sits at the pipe rather than up the tower |
| `circuitBoardHolder.SLDPRT` | Stand-alone board holder, for use with the plain adapter |
| `standExtender.SLDPRT` | Plain riser — the same part as the receiver tower's `Receiver-tower-middle-connector` |

Open `PVC Holder Assm.SLDASM` to see how the pieces sit on the pipe; the
assembly is the reference for orientation.

## Choosing an adapter

Each receiver tower needs one adapter. Pick per mounting point:

| If… | Print |
|---|---|
| The receiver board mounts on the tower, away from the pipe | `standExtenderPVCBase` |
| The receiver board should sit at the pipe, under the tower | `standExtenderPVCBaseWithPCBHolder` |
| The board needs its own mount somewhere else on the frame | `standExtenderPVCBase` + `circuitBoardHolder` |

## Fitting

1. **Export and print** the chosen adapter for each mounting point (see the
   warning above).
2. **Seat the adapter on the pipe** at the mounting point, matching the
   orientation in `PVC Holder Assm.SLDASM`, with the tower mount facing up.
3. If using the PCB-holder variant or a separate `circuitBoardHolder`, fit the
   board holder so the board is clear of the tower's footprint.
4. **Seat a receiver tower** on the adapter — see
   [Receiver Assembly](receiver-assembly.md). The tower's base sits on the
   adapter; use one or more `standExtender` / `Receiver-tower-middle-connector`
   risers between them if the receiver needs to sit higher.

Repeat for all six mounting points.
