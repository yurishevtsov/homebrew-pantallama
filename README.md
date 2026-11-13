# Pantallama for Homebrew

Pantallama is a macOS app for sharp one-to-one screen sharing and calls between
two Macs. This repository is a Homebrew tap: it holds the cask and, under
Releases, the app itself. The source code is kept elsewhere.

Needs an Apple silicon Mac on macOS 15 or later, and [Homebrew](https://brew.sh).

## Install

```bash
brew install --cask yurishevtsov/pantallama/pantallama
```

Then open Pantallama, choose **Pantallama > Settings**, and type the address of
your signaling service. The app does not come with one.

## Upgrade

```bash
brew upgrade --cask pantallama
```

Quit Pantallama first, or Homebrew will ask it to quit. The app has a new
signature after every upgrade, so macOS asks again for the microphone, camera,
screen recording and local network permissions.

## Remove

```bash
brew uninstall --cask pantallama
```

Add `--zap` to also delete this Mac's key, the people saved on it, its
settings and its logs.

## What the cask does to get past Gatekeeper

Pantallama is not signed with an Apple Developer ID and is not notarized.
Homebrew marks everything it downloads as quarantined, and macOS refuses to
open an app like this one while that mark is on it.

After copying the app to `/Applications`, the cask runs:

```bash
xattr -dr com.apple.quarantine /Applications/Pantallama.app
```

That removes the mark from Pantallama and from nothing else. It also means
macOS does not check the app before its first launch. What you are trusting
instead is this repository and the SHA-256 checksum in
[`Casks/pantallama.rb`](Casks/pantallama.rb), which Homebrew verifies against
the download. If you would rather not, do not install it.

The cask and this page are written by a script in the source repository;
changes made here by hand are overwritten by the next release.
