import Foundation
import CoreData

extension MSession
{
    private static let kAssetTutorialImages:String = "assetGifTutorial0.gif"
    
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
