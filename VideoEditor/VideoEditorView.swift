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
                        // Play video when it appears
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
                    showPicker = true
                }) {
                    Text("Import Video")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // Logic to apply a filter
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
                    // Logic to trim video
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
        .sheet(isPresented: $showPicker) {
            VideoPicker(asset: $asset)
        }
        .navigationTitle("Video Editor")
    }
    
    // Function to apply a filter (placeholder)
    func applyFilter(to asset: AVAsset) {
        // Add your filter application logic here
        print("Applying filter to video...")
    }
    
    // Function to trim video (placeholder)
    func trimVideo(asset: AVAsset) {
        let trimmer = VideoTrimmer()
        let startTime = CMTime(seconds: 0, preferredTimescale: 600) // Start time
        let endTime = CMTime(seconds: 10, preferredTimescale: 600) // End time
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
