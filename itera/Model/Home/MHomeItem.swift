import UIKit

class MHomeItem
{
    var image:UIImage?
    let project:DProject
    let path:URL
    
    init(project:DProject, path:URL)
    {
        self.project = project
        self.path = path
    }
}
