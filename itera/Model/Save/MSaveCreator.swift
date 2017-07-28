import Foundation

extension MSave
{
    func factoryGif(
        sequence:MEditSequence,
        path:URL)
    {
        /*
        let directoryUrl:URL = URL(fileURLWithPath:NSTemporaryDirectory())
        let fileUrl:URL = directoryUrl.appendingPathComponent(kFilenameGif)
        let totalImages:Int = images.count
        
        guard
            
            let destination:CGImageDestination = CGImageDestinationCreateWithURL(
                fileUrl as CFURL,
                kUTTypeGIF,
                totalImages,
                nil)
            
            else
        {
            let error:String = NSLocalizedString("CShare_errorGif", comment:"")
            VAlert.messageOrange(message:error)
            
            return nil
        }
        
        let destinationPropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFLoopCount as String:kLoopCount]]
        let destinationProperties:CFDictionary = destinationPropertiesRaw as CFDictionary
        
        CGImageDestinationSetProperties(
            destination,
            destinationProperties)
        
        for image:MShareImage in images
        {
            guard
                
                let cgImage:CGImage = image.image.cgImage
                
                else
            {
                continue
            }
            
            let gifPropertiesRaw:[String:Any] = [
                kCGImagePropertyGIFDictionary as String:[
                    kCGImagePropertyGIFDelayTime as String:image.duration]]
            let gifProperties:CFDictionary = gifPropertiesRaw as CFDictionary
            
            CGImageDestinationAddImage(
                destination,
                cgImage,
                gifProperties)
        }
        
        CGImageDestinationFinalize(destination)
        
        return fileUrl*/
    }
}
