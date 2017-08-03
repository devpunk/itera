import UIKit
import ImageIO

extension MHome
{
    func loadImage(path:URL) -> UIImage?
    {
        guard
            
            let source:CGImageSource = CGImageSource.factorySource(url:path),
            let image:UIImage = loadImage(source:source)
            
        else
        {
            return nil
        }
        
        return image
    }
    
    //MARK: private
    
    private func loadImage(source:CGImageSource) -> UIImage?
    {
        let count:Int = CGImageSourceGetCount(source)
        
        if count > 0
        {
            let options:CFDictionary = CGImageSource.optionsNoCache()
            
            guard
            
                let cgImage:CGImage = source.frameImageAt(
                    index:0,
                    options:options),
                let scaledImage:CGImage = scaleImage(
                    cgImage:cgImage)
            
            else
            {
                return nil
            }
            
            let image:UIImage = UIImage(cgImage:scaledImage)
            
            return image
        }
        
        return nil
    }
    
    private func scaleImage(cgImage:CGImage) -> CGImage?
    {
        let size:CGFloat = VHomeProjectsCell.kImageSize
        let canvasSize:CGSize = CGSize(width:size, height:size)
        let contentMode:UIViewContentMode = UIViewContentMode.scaleAspectFill
        
        let scaledImage:CGImage? = cgImage.resizeToFit(
            targetSize:canvasSize,
            contentMode:contentMode)
        
        return scaledImage
    }
}
