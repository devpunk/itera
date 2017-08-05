import UIKit
import Photos

class MSourceImage:Model
{
    private(set) var items:[MSourceImageItem]
    private var cachingManager:PHCachingImageManager?
    private var requestOptions:PHImageRequestOptions?
    private let previewSize:CGSize
    private let kPreviewSize:CGFloat = 100
    
    required init()
    {
        items = []
        previewSize = CGSize(width:kPreviewSize, height:kPreviewSize)
        
        super.init()
    }
    
    deinit
    {
        cachingManager?.stopCachingImagesForAllAssets()
    }
    
    //MARK: private
    
    private func libraryError()
    {
        let message:String = String.localizedModel(
            key:"MSourceImage_libraryError")
        VAlert.messageFail(message:message)
    }
    
    private func loadImages(fetchResults:PHFetchResult<PHAsset>)
    {
        requestOptions = MSourceImage.factoryRequestOptions()
        let cachingManager:PHCachingImageManager = PHCachingImageManager()
        self.cachingManager = cachingManager
        
        let countResults:Int = fetchResults.count
        var assets:[PHAsset] = []
        
        for indexResult:Int in 0 ..< countResults
        {
            let asset:PHAsset = fetchResults[indexResult]
            let item:MSourceImageItem = MSourceImageItem(
                asset:asset,
                cachingManager:cachingManager,
                requestOptions:requestOptions,
                previewSize:previewSize)
            
            items.append(item)
            assets.append(asset)
        }
        
        cacheAssets(assets:assets)
    }
    
    private func cacheAssets(assets:[PHAsset])
    {
        cachingManager?.startCachingImages(
            for:assets,
            targetSize:previewSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        
        delegate?.modelRefresh()
    }
    
    //MARK: internal
    
    func loadImages()
    {
        guard
            
            let fetchResults:PHFetchResult<PHAsset> = MSourceImage.factoryFetch()
            
        else
        {
            libraryError()
            
            return
        }
        
        loadImages(fetchResults:fetchResults)
    }
}
