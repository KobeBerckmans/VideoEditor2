import SwiftUI
import AVKit

struct VideoEditorView: View {
    @State private var asset: AVAsset?
    @State private var showPicker = false

    var body: some View {
        VStack {
            Text("Video Editor")
                .font(.largeTitle)
                .padding()

            // Video Preview
            if let asset = asset {
                VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: asset)))
                    .frame(height: 300)
                    .onAppear {
                        // Start de video automatisch af te spelen
                        let player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
                        player.play()
                    }
            } else {
                Text("No video selected")
                    .foregroundColor(.gray)
                    .padding()
            }

            // Buttons for various actions
            HStack {
                Button(action: {
                    print("Import Video button clicked") // Debugging statement
                    loadSampleVideo() // Laad de video bij klikken op de knop
                }) {
                    Text("Import Video")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    if let asset = asset {
                        applyFilter(to: asset)
                    }
                }) {
                    Text("Apply Filter")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    if let asset = asset {
                        trimVideo(asset: asset)
                    }
                }) {
                    Text("Trim Video")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 20)
        }
        .navigationTitle("Video Editor")
    }
    
    // Functie om de voorbeeldvideo te laden
    private func loadSampleVideo() {
        // Vervang dit pad door het juiste pad naar je video in het project
        if let videoURL = Bundle.main.url(forResource: "kobe_berckmans_", withExtension: "mp4") {
            asset = AVAsset(url: videoURL)
            print("Loaded video: \(videoURL)") // Debugging statement
        } else {
            print("Video not found") // Foutmelding als de video niet kan worden gevonden
        }
    }

    // Functie om een filter toe te passen (placeholder)
    func applyFilter(to asset: AVAsset) {
        print("Applying filter to video...")
    }

    // Functie om video te trimmen (placeholder)
    func trimVideo(asset: AVAsset) {
        let trimmer = VideoTrimmer()
        let startTime = CMTime(seconds: 0, preferredTimescale: 600) // Starttijd
        let endTime = CMTime(seconds: 10, preferredTimescale: 600) // Eindtijd
        trimmer.trimVideo(asset: asset, startTime: startTime, endTime: endTime) { url in
            if let trimmedURL = url {
                print("Trimmed video saved at: \(trimmedURL)")
            } else {
                print("Failed to trim video.")
            }
        }
    }
}

#Preview {
    VideoEditorView()
}
