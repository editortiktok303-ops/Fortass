# Blockass - Game Design Document

## Overview

**Blockass** is a voxel-based battle royale game that combines:
- Minecraft's block placement/destruction mechanics
- Fortnite's building, shooting, and survival elements
- 100-player battle royale gameplay
- Procedurally generated terrain

## Core Systems

### 1. Voxel World System
- Chunk-based terrain rendering (16x16 blocks)
- Destructible blocks (wood, stone, metal, dirt, grass)
- Terrain height variation with Perlin noise
- Day/night cycle (future)

### 2. Building System
- Real-time block placement/destruction
- Block rotation (4 directions)
- Building cooldown to prevent spam
- Different block properties (health, cost)

### 3. Combat System
- Weapon types: Rifle, Shotgun, Sniper, SMG, Explosives
- Headshot damage multiplier (2x)
- Ammo system with rarity tiers
- Shield/Health separation

### 4. Player Progression
- Health: 100 HP
- Shield: 0-50 (regenerates after 3 sec of no damage)
- Inventory: 40 slots
- Loadout system (future)

### 5. Battle Royale Zone
- Circular safe zone that shrinks over time
- 8 zone shrinks (10 mins between each)
- Damage outside zone increases with each shrink
- Safe zone indicators on map

### 6. Loot System
- Weapon spawns at named locations
- Ammo, healing items in containers
- Random item distribution
- Rarity system: Common → Rare → Epic → Legendary

### 7. Multiplayer
- 100 players per match
- Real-time player position sync
- Damage network validation
- Kill feed

## Game Loop

1. **Lobby Phase** - Players join and prepare
2. **Dropship Phase** - Players choose landing spot
3. **Early Game** - Looting and early combat
4. **Mid Game** - Zone shrinks, players pushed together
5. **Late Game** - Final zone, intense combat
6. **End Game** - Last player/team standing wins

## Control Scheme

- **WASD** - Movement
- **SPACE** - Jump
- **SHIFT** - Sprint
- **MOUSE** - Look around / Aim
- **LMB** - Fire weapon / Place block
- **RMB** - Destroy block
- **1-9** - Select inventory slot
- **E** - Pick up item
- **ESC** - Menu

## Planned Features (Roadmap)

### Phase 1 (MVP)
- [x] Voxel terrain
- [x] Basic player movement
- [ ] Building system
- [ ] Combat system
- [ ] Basic weapons
- [ ] Inventory

### Phase 2
- [ ] Battle royale zone
- [ ] Match manager
- [ ] Loot system
- [ ] Multiple weapon types
- [ ] HUD/UI

### Phase 3
- [ ] Multiplayer networking
- [ ] 100-player matches
- [ ] Map improvements
- [ ] Cosmetics system

### Phase 4
- [ ] Ranked system
- [ ] Seasons & Battle pass
- [ ] Emotes
- [ ] Custom skins

## Technical Architecture

```
┌─────────────────────────────────────────────────────┐
│         Main Scene                  │
├─────────────────────────────────────────────────────┤
│  ├─ WorldManager                   │
│  │  ├─ Chunk Generation           │
│  │  ├─ Block System               │
│  │  └─ Physics                    │
│  │                                 │
│  ├─ Player                         │
│  │  ├─ PlayerController           │
│  │  ├─ CameraController           │
│  │  ├─ Inventory                  │
│  │  └─ Health/Shield              │
│  │                                 │
│  ├─ ZoneManager                    │
│  │  ├─ Zone Shrinking             │
│  │  └─ Damage Over Time           │
│  │                                 │
│  ├─ MatchManager                   │
│  │  ├─ Player Registry            │
│  │  └─ Victory Conditions         │
│  │                                 │
│  ├─ NetworkManager                 │
│  │  ├─ Server/Client              │
│  │  └─ Position Sync              │
│  │                                 │
│  └─ HUD                            │
│     ├─ Health Display              │
│     ├─ Ammo Counter               │
│     └─ Minimap                    │
└─────────────────────────────────────────────────────┘
```

## Block Types

| Type | Health | Cost | Properties |
|------|--------|------|------------|
| Wood | 50 | 10 | Common, renewable |
| Stone | 100 | 15 | Strong |
| Metal | 200 | 30 | Very strong |
| Ice | 50 | 5 | Slippery |
| Lava | N/A | N/A | Damaging |

## Weapon Balancing

| Weapon | Damage | Fire Rate | Ammo Cap | Rarity |
|--------|--------|-----------|----------|--------|
| Rifle | 25 | 0.1s | 300 | Common |
| Shotgun | 60 | 0.7s | 30 | Uncommon |
| Sniper | 75 | 2.0s | 12 | Rare |
| SMG | 18 | 0.05s | 150 | Common |
| Explosive | 100 | 1.5s | 10 | Epic |

## Future Enhancements

- Vehicles (ATVs, helicopters)
- Consumables (potions, food)
- Environmental effects (weather, time of day)
- Daily/Weekly challenges
- Friend system
- Clans/Guilds
