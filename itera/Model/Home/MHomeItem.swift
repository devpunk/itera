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
}
