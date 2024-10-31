import UIKit
import AVFoundation
import GPUImage

class VideoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Properties
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var asset: AVAsset?
    
    // UI Outlets
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView! // Zorg ervoor dat je deze outlet ook instelt in je storyboard

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Video Import
    @IBAction func importVideo(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = ["public.movie"] // Zorg ervoor dat je alleen video kunt selecteren
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL {
            asset = AVAsset(url: url)
            setupVideoPlayer() // Setup player met de geselecteerde video
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func setupVideoPlayer() {
        // Stop de huidige video als die aan het spelen is
        player?.pause()
        
        // Verwijder de bestaande playerLayer als deze bestaat
        playerLayer?.removeFromSuperlayer()
        
        // Zorg ervoor dat er een asset is
        guard let asset = asset else { return }
        
        // Maak een nieuwe AVPlayerItem en AVPlayer
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        // Maak een nieuwe playerLayer en voeg deze toe aan de videoPreview
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoPreview.bounds
        playerLayer?.videoGravity = .resizeAspect // Zorg ervoor dat de video goed wordt weergegeven
        videoPreview.layer.addSublayer(playerLayer!)
        
        // Begin met afspelen
        player?.play()
    }
    
    // MARK: - Optional Functions for Filters and Trimming
    func applyFilter() {
        // Logica voor het toepassen van filters
        print("Filter toepassen...")
    }

    func trimVideo() {
        // Logica voor het trimmen van video's
        print("Video trimmen...")
    }
}
