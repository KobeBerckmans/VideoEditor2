import UIKit
import AVFoundation
import GPUImage

class VideoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Properties
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var asset: AVAsset?
    var filteredImage: UIImage?

    // UI Outlets
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()
    }

    // MARK: - Video Import
    @IBAction func importVideo(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = ["public.movie"]
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL {
            asset = AVAsset(url: url)
            setupVideoPlayer()
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func setupVideoPlayer() {
        guard let asset = asset else { return }
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoPreview.bounds
        videoPreview.layer.addSublayer(playerLayer!)
        player?.play()
    }
}
