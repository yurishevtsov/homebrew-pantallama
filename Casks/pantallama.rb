# Written by scripts/release.sh in the Pantallama source repository. Do not edit
# by hand: the next release overwrites this file.
cask "pantallama" do
  version "0.17.0"
  sha256 "e8b980461f2da66dcfc01f0b8a8ea03331615efe7b1c4d1e13ddec6c912c537a"

  url "https://github.com/yurishevtsov/homebrew-pantallama/releases/download/v#{version}/Pantallama-#{version}.zip"
  name "Pantallama"
  desc "Sharp one-to-one screen sharing and calls between two Macs"
  homepage "https://github.com/yurishevtsov/homebrew-pantallama"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Pantallama.app"

  # Pantallama is not signed with an Apple Developer ID and is not notarized.
  # Homebrew marks every download as quarantined, and macOS refuses to open an
  # app like this one while that mark is on it. This step takes the mark off
  # the installed app, and only that app. It means macOS does not check the app
  # before its first launch: you are trusting this tap and the checksum above.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pantallama.app"]
  end

  uninstall quit: "dev.pantallama.app"

  # Application Support holds this Mac's key and the people saved on it.
  zap trash: [
    "~/Library/Application Support/Pantallama",
    "~/Library/Caches/dev.pantallama.app",
    "~/Library/HTTPStorages/dev.pantallama.app",
    "~/Library/Logs/Pantallama",
    "~/Library/Preferences/dev.pantallama.app.plist",
  ]

  caveats <<~EOS
    Pantallama is not notarized by Apple. This cask removed the quarantine
    mark from the installed app so that macOS will open it.

    This copy does not know where your signaling service is. Open
    Pantallama > Settings and type its address once.

    After an upgrade macOS asks again for the microphone, camera, screen
    recording and local network permissions.
  EOS
end
