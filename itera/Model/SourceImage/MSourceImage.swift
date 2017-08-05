import UIKit
import Photos

class MSourceImage:Model
{
    var selectedCount:Int
    private(set) var items:[MSourceImageItem]
    private var cachingManager:PHCachingImageManager?
    private var requestOptions:PHImageRequestOptions?
    private let previewSize:CGSize
    private let kPreviewSize:CGFloat = 100
    
    required init()
    {
        items = []
        selectedCount = 0
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
    
    private func dispatchUpdateSelected()
    {
        let selected:[MSourceImageItem] = factorySelectedIndexesOrdered()
        selectedCount = selected.count
        
        for indexSelected:Int in 0 ..< selectedCount
        {
            let itemIndex:Int = indexSelected + 1
            
            let item:MSourceImageItem = selected[indexSelected]
            item.updateSelected(selectedIndex:itemIndex)
        }
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
    
    func updateSelected()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.dispatchUpdateSelected()
        }
    }
}
