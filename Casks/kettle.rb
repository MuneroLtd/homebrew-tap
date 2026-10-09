cask "kettle" do
  version "0.1.10"
  sha256 "4e8b8b09af6b0cc9e382d84ead7a2ff4172ee3fa92fc95a7ebef71cfe6e3676b"

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
    Before uninstalling, remove them (your earlier settings are restored):
      #{appdir}/Kettle.app/Contents/MacOS/Kettle --uninstall-hooks
  EOS
end
