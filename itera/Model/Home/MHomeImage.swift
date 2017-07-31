import UIKit
import ImageIO

extension MHome
{
    func loadImage(path:URL) -> UIImage?
    {
        guard
            
            let source:CGImageSource = VGif.factorySource(url:path),
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
            let options:CFDictionary = VGif.frameOptions()
            
            guard
            
                let cgImage:CGImage = VGif.frameImage(
                    source:source,
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
        let targetRect:CGRect = CGRect(
            x:0,
            y:0,
            width:size,
            height:size)
        let contentMode:UIViewContentMode = UIViewContentMode.scaleAspectFill
        
        let scaledRect:CGRect = VGif.scaleImageRect(
            targetRect:targetRect,
            image:cgImage,
            contentMode:contentMode)
        
        guard
        
            let scaledImage:CGImage = cgImage.resize(
                canvasSize:canvasSize,
                imageRect:scaledRect)
        
        else
        {
            return nil
        }
        
        return scaledImage
    }
}
