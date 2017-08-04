import UIKit

class MHomeItem
{
    let project:DProject
    let path:URL
    let image:UIImage
    var selected:Bool
    
    init(project:DProject, path:URL, image:UIImage)
    {
        self.project = project
        self.path = path
        self.image = image
        selected = false
    }
    
    //MARK: private
    
    private func dispatchDelete(completion:@escaping(() -> ()))
    {
        do
        {
            try FileManager.default.removeItem(at:path)
        }
        catch
        {
        }
        
        DManager.sharedInstance?.delete(data:project)
        {
            DManager.sharedInstance?.save
            {
                completion()
            }
        }
    }
    
    //MARK: public
    
    func delete(completion:@escaping(() -> ()))
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.dispatchDelete(completion:completion)
        }
    }
}
