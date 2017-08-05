import Foundation

class MSourceImage:Model
{
    //MARK: internal
    
    func loadImages()
    {
        guard
            
            let fetchResults:PHFetchResult<PHAsset> = MSourceVideo.factoryFetch()
            
        else
        {
            libraryError()
            
            return
        }
        
        loadVideos(fetchResults:fetchResults)
    }
}
