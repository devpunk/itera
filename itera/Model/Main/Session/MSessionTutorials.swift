import Foundation
import CoreData

extension MSession
{
    private static let kAssetTutorialImages:String = "assetGifTutorial0.gif"
    
    func factoryTutorials(settings:DSettings)
    {
        factoryTutorialImages(settings:settings)
    }
    
    //MARK: private
    
    private func factoryTutorialImages(settings:DSettings)
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
            
            project.name = MSession.kAssetTutorialImages
            
            self.factoryTutorialsFinished(settings:settings)
        }
    }
    
    private func factoryTutorialsFinished(settings:DSettings)
    {
        self.settingsLoaded(settings:settings)
    }
}
