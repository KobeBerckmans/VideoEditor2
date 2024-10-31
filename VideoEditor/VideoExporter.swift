import AVFoundation

class VideoExporter {
    func exportVideo(asset: AVAsset, completion: @escaping (URL?) -> Void) {
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exportSession?.outputFileType = .mov
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("finalVideo.mov")
        exportSession?.outputURL = outputURL
        exportSession?.exportAsynchronously {
            completion(exportSession?.status == .completed ? outputURL : nil)
        }
    }
}
