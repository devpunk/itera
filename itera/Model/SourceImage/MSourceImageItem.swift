import UIKit
import Photos

class MSourceImageItem
{
    var image:UIImage?
    var selectedIndex:Int?
    var selectedTimestamp:Int?
    let asset:PHAsset
    private weak var cachingManager:PHCachingImageManager?
    private weak var requestOptions:PHImageRequestOptions?
    private var requestId:PHImageRequestID?
    private let previewSize:CGSize
    
    init(
        asset:PHAsset,
        cachingManager:PHCachingImageManager,
        requestOptions:PHImageRequestOptions?,
        previewSize:CGSize)
    {
        self.asset = asset
        self.cachingManager = cachingManager
        self.requestOptions = requestOptions
        self.previewSize = previewSize
    }
    
    deinit
    {
        guard
            
            let requestId:PHImageRequestID = requestId
            
        else
        {
            return
        }
        
        cachingManager?.cancelImageRequest(requestId)
    }
    
    //MARK: internal
    
    func requestImage(completion:@escaping(() -> ()))
    {
        if let requestId:PHImageRequestID = requestId
        {
            cachingManager?.cancelImageRequest(requestId)
        }
        
        requestId = cachingManager?.requestImage(
            for:asset,
            targetSize:previewSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        { [weak self] (
            image:UIImage?,
            info:[AnyHashable:Any]?) in
            
            self?.image = image
            self?.requestId = nil
            
            completion()
        }
    }
}
