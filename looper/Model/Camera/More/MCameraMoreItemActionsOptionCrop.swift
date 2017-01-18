import UIKit

class MCameraMoreItemActionsOptionCrop:MCameraMoreItemActionsOption
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraCrop"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecordEditable = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.crop(item:record)
    }
}
