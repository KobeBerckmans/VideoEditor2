import UIKit
import CoreImage
import GPUImage

class FilterManager {
    static let shared = FilterManager()
    
    func applyCoreImageFilter(to image: UIImage, filterName: String) -> UIImage? {
        let ciImage = CIImage(image: image)
        let filter = CIFilter(name: filterName)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)

        let context = CIContext()
        if let outputImage = filter?.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }

    func applyGPUImageFilter(to image: UIImage, filter: BasicOperation, completion: @escaping (UIImage?) -> Void) {
        let pictureInput = PictureInput(image: image)
        let pictureOutput = PictureOutput()

        // Stel de callback in om de verwerkte afbeelding naar de completion handler te sturen
        pictureOutput.imageAvailableCallback = { outputImage in
            // Roep de completion handler aan met de verwerkte afbeelding
            completion(outputImage)
        }
        
        // Verbind de input en output met de filter
        pictureInput --> filter --> pictureOutput
        
        // Start de verwerking
        pictureInput.processImage()
    }
}

