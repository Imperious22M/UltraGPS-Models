# Receiver Assembly

A receiver tower raises one receiver off the arena frame and holds it pointed
into the arena. This page covers one tower; the system uses six in it's default configuration.

## Parts

STL exports are in `Receiver-Arena-Models/STL/Receiver-Holder/`; SolidWorks
sources in `Receiver-Arena-Models/Solidwork/Receiver-Parts/`. Sizes are the
STL bounding box in millimetres (X × Y × Z as exported).

| STL | Size (mm) | Role |
|---|---|---|
| `Receiver-tower-base` | 100 × 80 × 100 | Foot of the tower. Seats on the arena frame or a [PVC adapter](pvc-arena-assembly.md). |
| `Receiver-tower-middle-connector` | 20 × 80 × 20 | 80 mm riser between base and top. Stack more than one to raise the receiver. |
| `Receiver-tower-top-ultrasonic-holder` | 45 × 55.4 × 20 | Cradle for the receiver module and its board. |

The SolidWorks assemblies are the reference for how the parts fit:

| Assembly | Contents |
|---|---|
| `ReceiverAssem.SLDASM` | The full tower |
| `receiverwithboardholder.SLDASM` | The receiver and its board (`ReceiverWboard.SLDPRT`) seated in `Receiver-tower-top-ultrasonic-holder` |

## Printing

Print one of each part per tower. They are exported in their intended print
orientation; the base is the tallest at 100 mm. No supports should be needed
for the connector or holder.

## Building a tower

1. Press the **middle connector** into the socket on top of the **base**. Add
   a second connector (or a `standExtender` from the PVC parts — it is the
   same part) if the receiver needs to sit higher.
2. Seat the receiver and its board into the **top holder**, as shown in
   `receiverwithboardholder.SLDASM`.
3. Seat the loaded holder on the top of the connector.
4. Stand the tower on the arena frame — directly, or on a
   [PVC adapter](pvc-arena-assembly.md) — and turn it so the receiver faces the
   centre of the arena.
5. Label the tower with its receiver number (1–6) so it can be matched to its
   position later.

All six towers should end up with the receiver at the same height.
