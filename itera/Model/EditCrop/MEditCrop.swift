import UIKit

class MEditCrop:Model
{
    private(set) weak var edit:MEdit!
    var scaledWidth:CGFloat
    var scaledHeight:CGFloat
    
    required init()
    {
        scaledWidth = 0
        scaledHeight = 0
    
        super.init()
    }
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
    }
    
    func layoutModel() -> MEditCropLayout?
    {
        guard
        
            let percent:MEditSequenceCrop = edit.sequence?.crop
        
        else
        {
            return nil
        }
        
        let top:CGFloat = percent.top * scaledHeight
        let bottom:CGFloat = percent.bottom * scaledHeight
        let left:CGFloat = percent.left * scaledWidth
        let right:CGFloat = percent.right * scaledWidth
        
        let model:MEditCropLayout = MEditCropLayout(
            top:top,
            bottom:bottom,
            left:left,
            right:right)
        
        return model
    }
    
    func exportCrop(viewImage:VEditCropImage)
    {
        let deltaTop:CGFloat = viewImage.cornerTopLeft.deltaTop()
        let deltaBottom:CGFloat = viewImage.cornerBottomLeft.deltaTop()
        let deltaLeft:CGFloat = viewImage.cornerTopLeft.deltaLeft()
        let deltaRight:CGFloat = viewImage.cornerTopRight.deltaLeft()

        let top:CGFloat = deltaTop / scaledHeight
        let bottom:CGFloat = deltaBottom / scaledHeight
        let left:CGFloat = deltaLeft / scaledWidth
        let right:CGFloat = deltaRight / scaledWidth
        
        let model:MEditSequenceCrop = MEditSequenceCrop(
            top:top,
            bottom:bottom,
            left:left,
            right:right)
        
        edit.sequence?.crop = model
    }
}
