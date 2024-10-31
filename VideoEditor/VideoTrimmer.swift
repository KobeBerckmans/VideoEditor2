import AVFoundation

class VideoTrimmer {
    func trimVideo(asset: AVAsset, startTime: CMTime, endTime: CMTime, completion: @escaping (URL?) -> Void) {
        let composition = AVMutableComposition()
        guard let videoTrack = asset.tracks(withMediaType: .video).first else { return }
        let timeRange = CMTimeRange(start: startTime, end: endTime)

        do {
            let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
            try compositionVideoTrack?.insertTimeRange(timeRange, of: videoTrack, at: .zero)
            
            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("trimmedVideo.mov")
            let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
            exportSession?.outputURL = outputURL
            exportSession?.outputFileType = .mov
            exportSession?.exportAsynchronously {
                completion(exportSession?.status == .completed ? outputURL : nil)
            }
        } catch {
            print("Error trimming video: \(error)")
            completion(nil)
        }
    }
}
