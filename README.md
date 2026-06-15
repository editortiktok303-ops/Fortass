# Nitro Racer - Complete Godot Car Racing Game

## Features

✅ **Full Car Physics**
- Smooth acceleration and deceleration
- Realistic car rotation
- Speed limits and friction

✅ **Nitro Boost System**
- Press SPACE to activate nitro
- Temporary speed boost
- Recharges automatically when not in use
- Visual nitro meter

✅ **Drifting Mechanics**
- Automatic drift detection when turning at high speeds
- Earn money while drifting
- Drift multiplier for nitro boost

✅ **Money & Economy**
- Earn money by driving
- Earn bonus money while drifting
- Track total money earned
- Persistent save system

✅ **Vehicle Upgrades**
- Max Speed Upgrade: Increase your top speed
- Acceleration Upgrade: Faster acceleration
- Nitro Capacity Upgrade: Larger nitro tank
- Upgrades scale in cost with each level purchased
- Persistent progress saving

✅ **Complete UI**
- Main menu with play/upgrades/quit options
- In-game HUD with money, speed, and nitro display
- Upgrades shop
- Visual progress bars and indicators

## How to Play

### Controls
- **W/Up Arrow** - Accelerate forward
- **S/Down Arrow** - Reverse
- **A/D / Left/Right Arrows** - Steer
- **SPACE** - Activate Nitro Boost
- **Escape** - Back to menu

### Gameplay
1. Start a race and drive around the track
2. Earn money by driving fast
3. Earn bonus money by drifting (turning at high speed)
4. Use nitro boost (SPACE) for speed bursts
5. Return to the menu to spend money on upgrades
6. Upgrade your car's max speed, acceleration, and nitro capacity
7. Progress through levels and earn more money!

## Game Files

- **scenes/MainMenu.tscn** - Main menu scene
- **scenes/Game.tscn** - Main racing scene with car and track
- **scenes/UpgradesShop.tscn** - Upgrades and shop UI
- **scripts/MainMenu.gd** - Menu logic
- **scripts/Game.gd** - Game scene manager
- **scripts/Car.gd** - Car physics, controls, and progression
- **scripts/UpgradesShop.gd** - Upgrade purchasing logic
- **project.godot** - Project configuration

## Save System

Your progress is automatically saved to `user://car_data.cfg`:
- Current money
- Speed upgrade level
- Acceleration upgrade level
- Nitro capacity level

Progress persists between sessions!

## Installation

1. Open Godot 4.1+
2. Import this project
3. Click "Play" or press F5 to start
4. Enjoy!

No additional setup required - everything is pre-configured and ready to play!
