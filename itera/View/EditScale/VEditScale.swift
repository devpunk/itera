import UIKit

class VEditScale:ViewMain
{
    private(set) weak var viewImage:VEditCropImage!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private weak var layoutResetLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kResetHeight:CGFloat = 34
    private let kResetWidth:CGFloat = 120
    private let kImageBottom:CGFloat = -30
    private let kAnimationDuration:TimeInterval = 0.3
    
    //MARK: public
    
    func viewDidAppear()
    {
        
    }
}
