import Foundation
import CoreData

extension MHome
{
    private static let kAssetTutorialImages:String = "assetGifTutorial0.gif"
    
    class func factoryMenu() -> [MHomeMenuProtocol]
    {
        let itemShare:MHomeMenuShare = MHomeMenuShare()
        let itemFullScreen:MHomeMenuFullScreen = MHomeMenuFullScreen()
        let itemDelete:MHomeMenuDelete = MHomeMenuDelete()
        
        let items:[MHomeMenuProtocol] = [
            itemShare,
            itemFullScreen,
            itemDelete]
        
        return items
    }
    
    class func factoryTutorials(
        completion:@escaping(() -> ()))
    {
        factoryTutorialImages(completion:completion)
    }
    
    //MARK: private
    
    private class func factoryTutorialImages(
        completion:@escaping(() -> ()))
    {
        DManager.sharedInstance?.create(
            entity:DProjectTutorial.self)
        { (data:NSManagedObject?) in
            
            guard
                
                let project:DProjectTutorial = data as? DProjectTutorial
                
            else
            {
                return
            }
            
            project.name = kAssetTutorialImages
            
            factoryTutorialsFinished(completion:completion)
        }
    }
    
    private class func factoryTutorialsFinished(
        completion:@escaping(() -> ()))
    {
        DManager.sharedInstance?.save
        {
            completion()
        }
    }
}
