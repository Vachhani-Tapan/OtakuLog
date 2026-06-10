# Contributors

Thank you to everyone who has contributed to OtakuLog! 🎉
Every bug fix, feature, doc improvement, and test matters — you're helping build something real.

---

## Project Admin

| Name | GitHub | Role |
|------|--------|------|
| Tanmay | [XVX-016](https://github.com/XVX-016) | Creator & Maintainer |

---

## GSSOC '26 Contributors

| Name | GitHub | Contribution |
|------|--------|--------------|
| *Your name here* | *@yourhandle* | *Brief description of what you did* |

---

## How to Contribute & Open a Pull Request

### 1. Find or create an issue

- Browse [open issues](https://github.com/XVX-016/OtakuLog/issues) and find one that isn't assigned
- Comment on it asking to be assigned before starting work
- Don't work on an issue already assigned to someone else — look for the `stale` tag if you want to take over
- If you have a new idea, open an issue first and discuss it before writing code

### 2. Fork & clone the repo

```bash
# Fork via the GitHub UI first, then:
git clone https://github.com/YOUR_USERNAME/OtakuLog.git
cd OtakuLog
```

### 3. Set up the project

```bash
# Install dependencies
flutter pub get

# Generate Isar models (required — don't skip this)
dart run build_runner build --delete-conflicting-outputs

# Create your .env file for Supabase features (copy from example)
cp .env.example .env
```

Run the app to confirm everything works before making changes:
```bash
flutter run -d windows   # or -d android / -d chrome
```

### 4. Create a branch

Name your branch after the issue you're fixing:
```bash
git checkout -b fix/adaptive-icon-centering
# or
git checkout -b feat/shimmer-library-skeleton
# or
git checkout -b test/tracker-notifier-unit-tests
```

Branch naming convention:
- `fix/` — bug fixes
- `feat/` — new features
- `docs/` — documentation only
- `test/` — adding or fixing tests
- `refactor/` — code cleanup with no behaviour change

### 5. Make your changes

A few rules while you work:

- **One issue per PR** — don't bundle multiple fixes or features into one pull request
- **Follow the existing code style** — Riverpod for state, GoRouter for navigation, `AppTheme` for all colors
- **No hardcoded colors** — use `AppTheme.primaryText`, `AppTheme.secondaryText`, `AppTheme.accent`, `AppTheme.surface`, `AppTheme.background`
- **Run dart analyze before committing** — zero new warnings allowed
```bash
  dart analyze
```
- **If you added or changed an Isar model**, regenerate:
```bash
  dart run build_runner build --delete-conflicting-outputs
```

### 6. Add yourself to this file

Add your name to the Contributors table above as part of your PR. Use your real GitHub username — this is how you get credited.

### 7. Commit your changes

Write clear, specific commit messages:
```bash
# Good
git commit -m "fix: use Image.file for downloaded chapter pages in reader"
git commit -m "feat: add shimmer skeleton to library screen loading state"
git commit -m "test: add unit tests for TrackerNotifier logging logic"

# Bad
git commit -m "fixed stuff"
git commit -m "changes"
git commit -m "update"
```

Commit message format: `type: short description in lowercase`
Types: `fix`, `feat`, `docs`, `test`, `refactor`, `chore`

### 8. Push and open the PR

```bash
git push origin your-branch-name
```

Then go to your fork on GitHub and click **"Compare & pull request"**.

**PR title format:** same as your commit — `fix: adaptive icon not centered on Android`

**PR description must include:**
- What issue this closes (write `Closes #12` and GitHub links it automatically)
- What you changed and why
- How you tested it
- Screenshots or a screen recording if it's a UI change

Template:

What does this PR do?
Brief description of the change.

Related issue
Closes #(issue number)
How I tested it

Steps you took to verify the fix works
Device / emulator used

Screenshots (if UI change)
Before | After

### 9. PR review process

- A maintainer or mentor will review your PR within a few days
- If changes are requested, push new commits to the same branch — don't open a new PR
- Once approved, your PR gets merged and your name stays in this file permanently 🎉

---

## Tech Stack Reference

| Layer | Tech | Docs |
|-------|------|------|
| Framework | Flutter (Dart) | [flutter.dev](https://flutter.dev) |
| State Management | Riverpod | [riverpod.dev](https://riverpod.dev) |
| Local Database | Isar | [isar.dev](https://isar.dev) |
| Routing | GoRouter | [pub.dev/go_router](https://pub.dev/packages/go_router) |
| Networking | Dio | [pub.dev/dio](https://pub.dev/packages/dio) |
| Anime API | AniList (GraphQL) | [anilist.gitbook.io](https://anilist.gitbook.io/anilist-apiv2-docs) |
| Manga API | MangaDex (REST) | [api.mangadex.org/docs](https://api.mangadex.org/docs) |
| Charts | fl_chart | [pub.dev/fl_chart](https://pub.dev/packages/fl_chart) |
| Optional Backend | Supabase | [supabase.com/docs](https://supabase.com/docs) |

## Project Structure

lib/
├── app/          # Routing (GoRouter), Riverpod providers, theme
├── core/         # Shared utilities and reusable widgets
├── data/         # API clients, Isar models, mappers, repositories
│   ├── local/    # Isar database service and local preferences
│   ├── mappers/  # Entity ↔ Model conversion
│   ├── models/   # Isar collection definitions
│   ├── remote/   # AniList (GraphQL) and MangaDex (REST) clients
│   └── repositories/
├── domain/       # Entities and repository interfaces
└── features/     # Screens — home, library, search, stats, reader, downloads

---

## Questions?

- Open a thread in [GitHub Discussions](https://github.com/XVX-016/OtakuLog/discussions)
- Tag **@XVX-016** if you need admin input
- Mentors are active in Discussions — reach out there first before DMing

---

*This file is maintained by the project admin. Last updated for GSSOC '26.* 