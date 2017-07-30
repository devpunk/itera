import Foundation

extension MSave
{
    private static let kResourceName:String = "ResourceURL"
    private static let kResourceExtension:String = "plist"
    private static let kDirectoryKey:String = "directory"
    
    class func projectsDirectory() -> URL?
    {
        guard
            
            let directory:String = directoryName()
            
        else
        {
            return nil
        }
        
        let appDirectory:URL = FileManager.appDirectory
        let projects:URL = appDirectory.appendingPathComponent(
            directory)
        
        return projects
    }
    
    //MAKR: private
    
    private class func directoryName() -> String?
    {
        guard
            
            let resourceUrl:URL = Bundle.main.url(
                forResource:kResourceName,
                withExtension:kResourceExtension),
            let urlDictionary:NSDictionary = NSDictionary(
                contentsOf:resourceUrl),
            let urlMap:[String:String] = urlDictionary as? [String:String],
            let directory:String = urlMap[kDirectoryKey]
            
        else
        {
            return nil
        }
        
        return directory
    }
}
