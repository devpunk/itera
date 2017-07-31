import UIKit

class MHomeItem
{
    let project:DProject
    let path:URL
    let image:UIImage
    
    init(project:DProject, path:URL, image:UIImage)
    {
        self.project = project
        self.path = path
        self.image = image
    }
}
