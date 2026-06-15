# Contributing to Blockass

Since this is a solo project, contributions are not expected. However, if you're interested in the development process:

## Development Setup

1. Clone the repo
2. Open in Godot 4.1+
3. Install VoxelTools addon
4. Create a new branch: `git checkout -b feature/your-feature`
5. Make changes
6. Test thoroughly
7. Commit: `git commit -m "Add feature: description"`
8. Push: `git push origin feature/your-feature`

## Code Style

- Follow Godot/GDScript conventions
- Use descriptive variable names
- Add comments for complex logic
- Keep functions focused and small
- Use type hints: `func example(param: String) -> bool:`

## Testing

- Test player movement in terrain
- Test building/destruction mechanics
- Test combat and damage
- Test inventory management
- Check network sync (if applicable)

## Reporting Issues

If you find bugs, please report them with:
- Description of the issue
- Steps to reproduce
- Expected vs actual behavior
- System info (OS, Godot version)

## Feature Requests

Feature ideas are welcome! Please describe:
- What the feature is
- Why it's needed
- How it fits into Blockass
