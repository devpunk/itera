import Foundation

extension DProjectUser
{
    func save(path:URL, duration:TimeInterval)
    {
        let created:TimeInterval = Date().timeIntervalSince1970
        let lastPath:String = path.lastPathComponent
        
        self.name = lastPath
        self.duration = duration
        self.created = created
        
        DManager.sharedInstance?.save()
    }
}
