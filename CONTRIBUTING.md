# Contributing to DropX

Thank you for your interest in contributing to DropX! 🎉

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Flutter version and platform
- Code sample if possible

### Suggesting Features

Feature requests are welcome! Please:
- Check if it's already requested
- Explain the use case
- Provide examples if possible

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow the existing code style
   - Add tests if applicable
   - Update documentation
4. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```
5. **Commit with clear messages**
   ```bash
   git commit -m "Add: feature description"
   ```
6. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

## Development Setup

```bash
# Clone the repository
git clone https://github.com/birmehto/dropx.git
cd dropx

# Get dependencies
flutter pub get

# Run tests
flutter test

# Run example
cd example
flutter run
```

## Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused
- Use `dartfmt` for formatting

## Adding Features

When adding new features:
1. Update relevant documentation
2. Add examples if applicable
3. Ensure backward compatibility
4. Update CHANGELOG.md

## Questions?

Feel free to open an issue for any questions!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
