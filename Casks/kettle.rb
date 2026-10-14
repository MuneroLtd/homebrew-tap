cask "kettle" do
  version "0.1.15"
  sha256 "73273bf5358d8af2069c674eb8e20e32a3e31994a4105c7215c9c7edd1d91410"

  url "https://github.com/MuneroLtd/kettle-releases/releases/download/v#{version}/Kettle-#{version}.zip"
  name "Kettle"
  desc "Menu bar traffic light for every Claude Code session"
  homepage "https://github.com/MuneroLtd/kettle-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Kettle updates itself with Sparkle (FR-63), so brew upgrade leaves it alone unless --greedy, and
  # brew outdated does not list a copy Sparkle has already moved past the cask's version.
  auto_updates true

  # Package.swift: platforms [.macOS(.v14)]; a bare release means "or later" (Homebrew/OSDependsOn)
  depends_on macos: :sonoma

  app "Kettle.app"

  uninstall quit: "uk.co.munero.kettle"

  zap trash: [
    "~/Library/Application Support/Kettle",
    "~/Library/Caches/uk.co.munero.kettle",
    "~/Library/Preferences/uk.co.munero.kettle.plist",
    "~/Library/Saved Application State/uk.co.munero.kettle.savedState",
  ]

  caveats <<~EOS
    Kettle registers hooks in your Claude Code settings when you set it up.
    Before uninstalling, choose Settings, General, Uninstall Kettle in the app,
    then Quit Kettle. It removes its own parts from your settings and keeps
    your later changes. Or, with Kettle quit:
      #{appdir}/Kettle.app/Contents/MacOS/Kettle --uninstall-hooks
  EOS
end
