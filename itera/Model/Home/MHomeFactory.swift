import Foundation

extension MHome
{
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
    
    class func factoryPath(
        project:DProject,
        directory:URL) -> URL?
    {
        let path:URL?
        
        if let project:DProjectUser = project as? DProjectUser
        {
            path = factoryPathUser(
                project:project,
                directory:directory)
        }
        else if let project:DProjectTutorial = project as? DProjectTutorial
        {
            path = factoryPathTutorial(
                project:project)
        }
        else
        {
            path = nil
        }
        
        return path
    }
    
    //MARK: private
    
    private class func factoryPathUser(
        project:DProjectUser,
        directory:URL) -> URL?
    {
        guard
            
            let name:String = project.name
            
        else
        {
            return nil
        }
        
        let path:URL = directory.appendingPathComponent(name)
        
        return path
    }
    
    private class func factoryPathTutorial(
        project:DProjectTutorial) -> URL?
    {
        guard
            
            let name:String = project.name
            
        else
        {
            return nil
        }
        
        let path:URL? = Bundle.main.url(
            forResource:name,
            withExtension:nil)
        
        return path
    }
}
