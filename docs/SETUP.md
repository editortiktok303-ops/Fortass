# Blockass - Setup Guide

## Prerequisites

- **Godot 4.1+** - Download from [godotengine.org](https://godotengine.org)
- **Git** - For version control
- **VoxelTools Plugin** - For voxel terrain (optional but recommended)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/editortiktok303-ops/Fortass.git
cd Fortass
```

### 2. Open in Godot

1. Launch Godot 4.1+
2. Click "Open" project
3. Navigate to `Fortass/` directory
4. Select `project.godot`
5. Click "Open"

### 3. Install VoxelTools (Optional but Recommended)

1. In Godot, go to **Asset Library**
2. Search for "VoxelTools"
3. Click "Download"
4. Extract to `res://addons/voxel_tools/`
5. Enable in **Project → Project Settings → Plugins**

### 4. Configure Input Map

Go to **Project → Project Settings → Input Map** and add:

```
move_forward: W
move_backward: S
move_left: A
move_right: D
jump: SPACE
sprint: SHIFT
shoot: MOUSE_BUTTON_LEFT
place_block: MOUSE_BUTTON_LEFT
destroy_block: MOUSE_BUTTON_RIGHT
```

### 5. Run the Game

- Press **F5** to run
- Or click **▶ Run** button

## Troubleshooting

### Game won't start
- Check Godot version (4.1+ required)
- Verify all script paths in scenes exist
- Check console (View → Output) for errors

### No terrain visible
- Verify WorldManager script is attached to scene
- Check that chunk generation is called in `_ready()`
- Ensure CollisionShape3D is added to player

### Player falls through blocks
- Add PhysicsBody3D to terrain chunks
- Enable colliders on block mesh instances

### Mouse not captured
- CameraController should call `Input.set_mouse_mode(MOUSE_MODE_CAPTURED)` in `_ready()`

## Project Structure

```
Blockass/
├── project.godot              # Godot project config
├── scenes/
│   └── main.tscn             # Main game scene
├── scripts/
│   ├── player/
│   │   ├── player.gd         # Player controller
│   │   └── camera_controller.gd
│   ├── world/
│   │   └── world_manager.gd  # Terrain & chunks
│   ├── combat/
│   │   ├── weapon.gd         # Weapon system
│   │   └── damage_system.gd
│   ├── inventory/
│   │   └── inventory.gd      # Item management
│   ├── battle_royale/
│   │   ├── zone_manager.gd   # Safe zone logic
│   │   └── match_manager.gd
│   ├── network/
│   │   └── network_manager.gd # Multiplayer
│   └── ui/
│       └── hud.gd            # HUD display
├── assets/                    # Art, audio, textures
│   ├── textures/
│   ├── models/
│   └── sounds/
└── docs/
    ├── DESIGN.md             # Design document
    └── SETUP.md              # This file
```

## Next Steps

1. **Test basic terrain** - Run and verify blocks render
2. **Implement building** - Complete `place_block()` and `destroy_block()`
3. **Add weapons** - Create weapon pickups and firing
4. **Test combat** - Verify damage system works
5. **Implement zone** - Add shrinking safe zone
6. **Add networking** - Enable multiplayer (optional)

## Performance Tips

- Keep chunk size at 16x16 for optimal performance
- Limit view distance to 8-10 chunks
- Use LOD (Level of Detail) for distant terrain
- Cache block meshes to reduce draw calls
- Consider occlusion culling for indoor areas

## Resources

- [Godot Docs](https://docs.godotengine.org/)
- [VoxelTools Docs](https://voxel-tools.readthedocs.io/)
- [Godot Multiplayer](https://docs.godotengine.org/en/stable/tutorials/networking/index.html)
