import UIKit

class VCameraFilterBlenderOverlay:VView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var viewBase:VCameraFilterBlenderOverlayBase!
    private weak var viewList:VCameraFilterBlenderOverlayList!
    private weak var layoutBaseLeft:NSLayoutConstraint!
    private let kContentTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 44
    private let kTitleHeight:CGFloat = 60
    private let kBaseTop:CGFloat = 100
    private let kBaseSize:CGFloat = 280
    private let kListHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterBlenderOverlay
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let nextButton:UIButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        nextButton.imageView!.contentMode = UIViewContentMode.center
        nextButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        nextButton.imageView!.clipsToBounds = true
        nextButton.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.bold(size:16)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.black
        title.numberOfLines = 2
        title.text = NSLocalizedString("VCameraFilterBlenderOverlay_title", comment:"")
        
        let viewBase:VCameraFilterBlenderOverlayBase = VCameraFilterBlenderOverlayBase(
            model:self.controller.baseRecord)
        self.viewBase = viewBase
        
        let viewList:VCameraFilterBlenderOverlayList = VCameraFilterBlenderOverlayList(
            controller:self.controller)
        
        addSubview(title)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(viewBase)
        addSubview(viewList)
        
        let layoutBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        let layoutBackHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:backButton,
            constant:kButtonsHeight)
        let layoutBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        let layoutBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonsWidth)
        
        let layoutNextTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:nextButton,
            toView:self,
            constant:kContentTop)
        let layoutNextHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:nextButton,
            constant:kButtonsHeight)
        let layoutNextRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:nextButton,
            toView:self)
        let layoutNextWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:nextButton,
            constant:kButtonsWidth)
        
        let layoutTitleTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:title,
            toView:self,
            constant:kContentTop)
        let layoutTitleHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:title,
            constant:kTitleHeight)
        let layoutTitleLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:title,
            toView:self)
        let layoutTitleRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:title,
            toView:self)
        
        let layoutBaseTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self,
            constant:kBaseTop)
        layoutBaseLeft = NSLayoutConstraint.leftToLeft(
            view:viewBase,
            toView:self)
        let layoutBaseWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:viewBase,
            constant:kBaseSize)
        let layoutBaseHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBase,
            constant:kBaseSize)
        
        let layoutListBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewList,
            toView:self)
        let layoutListHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewList,
            constant:kListHeight)
        let layoutListLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewList,
            toView:self)
        let layoutListRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewList,
            toView:self)
        
        addConstraints([
            layoutBackTop,
            layoutBackHeight,
            layoutBackLeft,
            layoutBackWidth,
            layoutNextTop,
            layoutNextHeight,
            layoutNextRight,
            layoutNextWidth,
            layoutTitleTop,
            layoutTitleHeight,
            layoutTitleLeft,
            layoutTitleRight,
            layoutBaseTop,
            layoutBaseHeight,
            layoutBaseLeft,
            layoutBaseWidth,
            layoutListBottom,
            layoutListHeight,
            layoutListLeft,
            layoutListRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainBase:CGFloat = width - kBaseSize
        let marginBase:CGFloat = remainBase / 2.0
        layoutBaseLeft.constant = marginBase
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionNext(sender button:UIButton)
    {
        
    }
}