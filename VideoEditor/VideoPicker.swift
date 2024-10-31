import SwiftUI
import AVKit

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var asset: AVAsset?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.mediaTypes = ["public.movie"] // Zorg ervoor dat alleen video's worden weergegeven
        picker.sourceType = .photoLibrary // Gebruik de fotobibliotheek als bron
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.asset = AVAsset(url: url) // Sla de geselecteerde video op als AVAsset
            }
            picker.dismiss(animated: true) // Sluit de picker
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) // Sluit de picker bij annulering
        }
    }
}
