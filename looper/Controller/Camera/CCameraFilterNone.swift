import UIKit

class CCameraFilterNone:CController
{
    let model:MCamera
    private weak var viewNone:VCameraFilterNone!
    
    init(model:MCamera)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewNone:VCameraFilterNone = VCameraFilterNone(controller:self)
        self.viewNone = viewNone
        view = viewNone
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func selected(record:MCameraRecord)
    {
        let filteredRecord:MCameraRecord = MCameraRecord()
        
        for item:MCameraRecordItem in record.items
        {
            if item.active
            {
                filteredRecord.items.append(item)
            }
        }
        
        let controllerCompress:CCameraCompress = CCameraCompress(
            model:filteredRecord)
        parentController.push(
            controller:controllerCompress,
            horizontal:
            CParent.TransitionHorizontal.fromRight)
    }
}