import Foundation

extension MSave
{
    func createDirectory() -> URL?
    {
        guard
            
            let projectsDirectory:String = directoryName()
        
        else
        {
            return nil
        }
        
        let appDirectory:URL = FileManager.appDirectory
        let projectsPath:URL = appDirectory.appendingPathComponent(
            projectsDirectory)
        
        do
        {
            try FileManager.default.createDirectory(
                at:projectsPath,
                withIntermediateDirectories:false,
                attributes:nil)
        }
        catch
        {
            return nil
        }
        
        let excludedPath:URL = URL.excludeFromBackup(
            original:projectsPath)
        
        return excludedPath
    }
    
    func fileName() -> String
    {
        let randomName:String = UUID().uuidString
        let nameExtension:String = "\(randomName)\(kGifExtension)"
        
        return nameExtension
    }
    
    //MARK: private
    
    private func directoryName() -> String?
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
