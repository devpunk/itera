import Foundation

class CSourceImage:Controller<VSourceImage, MSourceImage>
{
    func back()
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.pop(horizontal:ControllerParent.Horizontal.right)
    }
}
