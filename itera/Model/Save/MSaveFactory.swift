import Foundation

extension MSave
{
    func filePath() -> URL?
    {
        guard
            
            let directory:URL = createDirectory()
        
        else
        {
            return nil
        }
        
        let file:String = fileName()
        let path:URL = directory.appendingPathComponent(file)
        
        return path
    }
    
    //MARK: private
    
    private func createDirectory() -> URL?
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
                withIntermediateDirectories:true,
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
    
    private func fileName() -> String
    {
        let randomName:String = UUID().uuidString
        let nameExtension:String = randomName.appending(kGifExtension)
        
        return nameExtension
    }
    
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
