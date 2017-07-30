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
        
            let projectsPath:URL = MSave.projectsDirectory()
        
        else
        {
            return nil
        }
        
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
}
