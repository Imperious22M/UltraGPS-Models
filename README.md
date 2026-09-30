# UltraGPS Models

3D-printable hardware for the St. Mary's University **UltraGPS** indoor
positioning system, developed as part of graduate and undergraduate research.

## What is here

SolidWorks sources and STL exports for every printed part of the system:

| Directory | Contents |
|---|---|
| `Transmitter-Models/` | Transmitter tower sections and transducer holders |
| `Receiver-Arena-Models/Solidwork/Receiver-Parts/` | Receiver tower parts and arena parts |
| `Receiver-Arena-Models/Solidwork/PVC-Arena-Base-Parts/` | PVC-pipe arena base extenders and PCB holder (no STL exports yet) |
| `docs/` | The documentation site (MkDocs) |

Each subsystem is mirrored as `Solidwork/` (`.SLDPRT` / `.SLDASM` / `.SLDDRW`)
and `STL/`. Every SolidWorks part that has an STL export
shares its basename with it.

These parts are the physical side of the system whose software lives in
[UltraGPS-Arduino](https://github.com/Imperious22M/UltraGPS-Arduino) (firmware),
[UltraGPS-Ground](https://github.com/Imperious22M/UltraGPS-Ground) (ground station)
and [UltraGPS-Control](https://github.com/Imperious22M/UltraGPS-Control)
(operator GUI).

## Documentation

The MKDocs documentation can be found [here].(https://imperious22m.github.io/UltraGPS-Models)

- **Home** — how the printed parts fit into the rest of the system, and a
  full inventory of the STLs with print dimensions.
- **Arena Assembly** — receiver layout and geometry, the PVC base parts, and
  entering the arena into the control software.
- **Receiver Assembly** — building a receiver tower and wiring it to the
  base station.
- **Transmitter Assembly** — the transmitter tower, transducer holders, and
  the transmitter-station electronics.

### Previewing the docs locally

`build.sh` is the docs entry point, mirroring the software repositories.

```bash
pip install -r docs/requirements.txt
./build.sh docs         # live preview at http://127.0.0.1:8000
./build.sh docs-build   # render into ./site/
./build.sh clean        # remove ./site/
```

### Publishing Flow

Pushing a change to `docs/`, to `mkdocs.yml`, or to the `Release` branch runs 
`.github/workflows/docs.yml`, which builds the site and pushes it to the `gh-pages` 
branch that GitHub Pages serves. The workflow can also be run by hand from the Actions 
tab.

## Working with the CAD files

- SolidWorks files are binary; only SolidWorks can edit them. The STLs are what
  you print.
- SolidWorks files can be edited only in SolidWorks.
