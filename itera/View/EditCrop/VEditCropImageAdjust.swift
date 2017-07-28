import UIKit

extension VEditCropImage
{
    func reset()
    {
        cornerTopLeft.reset()
        cornerTopRight.reset()
        cornerBottomLeft.reset()
        cornerBottomRight.reset()
    }
    
    private func importLayout()
    {
        guard
            
            let model:MEditCropLayout = controller.model.layoutModel()
            
        else
        {
            return
        }
        
        cornerTopLeft.layoutTop.constant += model.top
        cornerTopRight.layoutTop.constant += model.top
        cornerBottomLeft.layoutTop.constant -= model.bottom
        cornerBottomRight.layoutTop.constant -= model.bottom
        cornerTopLeft.layoutLeft.constant += model.left
        cornerBottomLeft.layoutLeft.constant += model.left
        cornerTopRight.layoutLeft.constant += model.right
        cornerBottomRight.layoutLeft.constant += model.right
    }
}
