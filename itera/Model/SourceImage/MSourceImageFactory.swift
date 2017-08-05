import Foundation
import Photos

extension MSourceImage
{
    static let kCreationDate:String = "creationDate"
    static let kMediaType:String = "mediaType = %d"
    
    class func factoryFetch() -> PHFetchResult<PHAsset>?
    {
        guard
            
            let cameraRoll:PHAssetCollection = factoryCameraRoll()
            
        else
        {
            return nil
        }
        
        let fetchOptions:PHFetchOptions = factoryFetchOptions()
        let assetsResult:PHFetchResult<PHAsset> = PHAsset.fetchAssets(
            in:cameraRoll,
            options:fetchOptions)
        
        return assetsResult
    }
    
    class func factoryRequestOptions() -> PHImageRequestOptions
    {
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        
        return requestOptions
    }
    
    class func factoryVideoOptions() -> PHVideoRequestOptions
    {
        let options:PHVideoRequestOptions = PHVideoRequestOptions()
        options.deliveryMode = PHVideoRequestOptionsDeliveryMode.highQualityFormat
        
        return options
    }
    
    func factorySelectedIndexesOrdered() -> [MSourceImageItem]
    {
        var selected:[MSourceImageItem] = []
        
        for item:MSourceImageItem in items
        {
            guard
            
                let _:TimeInterval = item.selectedTimestamp
            
            else
            {
                continue
            }
            
            selected.append(item)
        }
        
        selected.sort
        { (itemA:MSourceImageItem, itemB:MSourceImageItem) -> Bool in
            
            return itemA.selectedTimestamp! < itemB.selectedTimestamp!
        }
        
        return selected
    }
    
    //MARK: private
    
    private class func factoryCameraRoll() -> PHAssetCollection?
    {
        let collectionResult:PHFetchResult = PHAssetCollection.fetchAssetCollections(
            with:PHAssetCollectionType.smartAlbum,
            subtype:PHAssetCollectionSubtype.smartAlbumUserLibrary,
            options:nil)
        let cameraRoll:PHAssetCollection? = collectionResult.firstObject
        
        return cameraRoll
    }
    
    private class func factoryFetchOptions() -> PHFetchOptions
    {
        let fetchOptions:PHFetchOptions = PHFetchOptions()
        let sortNewest:NSSortDescriptor = NSSortDescriptor(
            key:kCreationDate,
            ascending:false)
        let predicateImages:NSPredicate = NSPredicate(
            format:kMediaType,
            PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [sortNewest]
        fetchOptions.predicate = predicateImages
        
        return fetchOptions
    }
}
