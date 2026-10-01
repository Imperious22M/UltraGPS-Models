# UltraGPS Models

3D-printable models for the St. Mary's University **UltraGPS** indoor
positioning system, developed as part of graduate research.

This repository holds the SolidWorks sources and STL exports for every printed
part in the system. In each major folder of the repository, the **Solidworks** 
folder holds all of the solidworks models and the **STL** folder holds all of the
printables STL files.

In **Receiver-Arena-Models** you can find the components that interface between PVC pipes and the receiver components as well as the components that make up the receiver tower.

In **Transmitter-Models** you can find the components that make the example transmitter tower.

## Documentation

- **[Receiver Assembly](receiver-assembly.md)** — building a receiver tower.
- **[Transmitter Assembly](transmitter-assembly.md)** — building the transmitter tower,
  and the transducer holder.
- **[PVC Arena Assembly](pvc-arena-assembly.md)** — using the printed adapters
  that join a receiver tower to the PVC pipe frame.

## Repository layout

```
Transmitter-Models/
  Solidwork/   Solidwork parts
  STL/         Tower sections and transducer holders
Receiver-Arena-Models/
  Solidwork/
    Receiver-Parts/          Receiver tower parts + assemblies
    PVC-Arena-Base-Parts/    PVC-pipe arena base extenders and PCB holder
  STL/
    Receiver-Holder/         Receiver tower exports
    Arena-Base/              (empty — arena base STLs not yet exported)
docs/          This site
```

Every `.SLDPRT` that has an STL export shares its basename with that STL, so
`Transmitter-tower-middle.SLDPRT` is the source of
`Transmitter-tower-middle.STL`.
