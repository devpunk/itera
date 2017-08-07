import UIKit
import Photos

extension MSourceImageImportFactory
{
    func factoryMaxSize()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.dispatchFactoryMaxSize()
        }
    }
    
    func adjustImage(image:CGImage)
    {
        guard
        
            let resizedImage:CGImage = resizeToMax(image:image)
        
        else
        {
            return
        }
        
        images.append(resizedImage)
    }
    
    //MARK: private
    
    private func dispatchFactoryMaxSize()
    {
        var maxWidth:CGFloat = maxImageSize.width
        var maxHeight:CGFloat = maxImageSize.height
        
        for item:MSourceImageItem in items
        {
            let asset:PHAsset = item.asset
            let width:CGFloat = CGFloat(asset.pixelWidth)
            let height:CGFloat = CGFloat(asset.pixelHeight)
            
            if width > maxWidth
            {
                maxWidth = width
            }
            
            if height > maxHeight
            {
                maxHeight = height
            }
        }
        
        maxImageSize = CGSize(
            width:maxWidth,
            height:maxHeight)
        
        maxSizeFactored()
    }
    
    private func maxSizeFactored()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.recursiveCheck()
        }
    }
    
    private func resizeToMax(image:CGImage) -> CGImage?
    {
        guard
        
            let resizedImage:CGImage = image.resizeToFit(
                targetSize:maxImageSize,
                contentMode:
                UIViewContentMode.scaleAspectFill)
        
        else
        {
            return nil
        }
        
        return resizedImage
    }
}
