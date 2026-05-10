# Lacrosse Arena — 3D Edition

Two playable versions live side-by-side:

- `index.html` — original 2D top-down (zero deps, opens directly).
- `index3d.html` — Three.js + Rapier 3D port with PBR field, HDRI sky, rigged characters, full ball physics, post-FX bloom, and synthesized audio.

## Run locally

The 3D build loads glTF / HDRI / WASM, which requires a real HTTP origin (not `file://`). From this folder:

```sh
python3 -m http.server 8765
```

Then open:

- 2D: <http://localhost:8765/index.html>
- 3D: <http://localhost:8765/index3d.html>

## Controls

Same as 2D:

- **WASD** — move
- **Space** — shoot / check
- **Shift** (or **J**) — pass
- **P** — pause
- **Esc** — back to menu
- Touch devices: virtual joystick on the left half + Shoot / Pass buttons.

## What's in the 3D build

| Layer | Tech |
|---|---|
| Renderer | Three.js r160 (importmap CDN, no bundler) |
| Physics | Rapier 3D (compat, WASM-bundled via esm.sh) |
| Player models | Three.js Soldier glTF (rigged, with idle/walk/run animations), cloned via `SkeletonUtils.clone`, jersey tinted per team |
| Field | PBR grass — ambientCG **Grass004** (CC0): albedo + normal + roughness + AO, tiled 28×16 |
| Sky / lighting | Polyhaven **Kloofendal 1k** HDRI (CC0) used as `scene.environment` and `scene.background` |
| Tone mapping | ACES Filmic, sRGB output |
| Shadows | Single directional sun, 2k shadow map (1k on touch), tight frustum |
| Post-FX | UnrealBloomPass with high threshold so only the emissive ball glows |
| Audio | Synthesized via Web Audio API — whistle on faceoff, air horn on goal, noise+tone on shoot/pass/check |
| Camera | Hybrid — broadcast 3/4 view for menu / faceoff / goal / end, follow-cam behind controlled player during play |

## Asset folder

```
assets/
  character.glb        # Three.js Soldier (MIT-licensed example)
  sky.hdr              # Polyhaven Kloofendal HDRI (CC0)
  grass/
    albedo.jpg         # ambientCG Grass004 Color (CC0)
    normal.jpg         # Grass004 Normal-GL (CC0)
    roughness.jpg      # Grass004 Roughness (CC0)
    ao.jpg             # Grass004 Ambient Occlusion (CC0)
```

All assets are CC0 or MIT-licensed and redistributable.

## Performance

Targets 60 fps on M1-class laptops. On touch devices, automatic fallback:

- DPR clamped to 1
- Shadow map dropped to 1024
- Bloom pass disabled

If the game is unstable on a particular device, the 2D version (`index.html`) remains a working fallback with no asset loading.
