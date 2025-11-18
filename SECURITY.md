# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in DropX, please report it by:

1. **DO NOT** open a public issue
2. Email the maintainer directly (check pubspec.yaml for contact)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We will respond within 48 hours and work with you to address the issue.

## Security Best Practices

When using DropX:

- Always validate user input from dropdown selections
- Sanitize data before displaying in custom item builders
- Be cautious with custom filter functions that execute user-provided code
- Keep Flutter and dependencies up to date
- Review custom widgets passed as header/footer for XSS vulnerabilities

## Disclosure Policy

- Security issues will be patched as soon as possible
- A new version will be released with the fix
- Credit will be given to the reporter (unless they prefer to remain anonymous)
- Details will be disclosed after users have had time to update
