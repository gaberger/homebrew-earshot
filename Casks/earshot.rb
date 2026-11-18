# Homebrew cask for Earshot (ADR-2611141900). The tap is github.com/gaberger/homebrew-earshot;
# scripts/update-cask fills in VERSION and SHA256 from a release DMG and CI pushes the result there.
#   brew tap gaberger/earshot && brew install --cask earshot
cask "earshot" do
  version "1.5.0"
  sha256 "b5fbece0dbc2e87f0cc6730134b193f217c949f70b36a4a780f9c448b3d949dd"

  url "https://github.com/gaberger/earshot/releases/download/v#{version}/Earshot-#{version}.dmg"
  name "Earshot"
  desc "Private, on-device meeting transcripts, speaker labels and summaries"
  homepage "https://gaberger.github.io/earshot/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Earshot.app"

  # Models in ~/Models are left alone on purpose: other whisper.cpp tools may share them.
  zap trash: [
    "~/Library/Logs/Earshot.log",
    "~/Library/Preferences/org.sticksandstrings.earshot.plist",
    "~/Library/Preferences/com.gaberger.earshot.plist",
    "~/Library/Preferences/local.whisper.transcribe.plist",
  ]

  caveats <<~EOS
    Open Earshot and click Download to fetch its speech models (1.7 GB, once).
    Earshot needs Apple Intelligence turned on for summaries.
  EOS
end
