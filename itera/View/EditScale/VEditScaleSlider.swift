import UIKit

class VEditScaleSlider:View<VEditScale, MEditScale, CEditScale>
{
    private weak var slider:UISlider!
    private weak var labelPercent:UILabel!
    private weak var labelSize:UILabel!
    private let attributesPercentNumber:[String:AnyObject]
    private let stringSing:NSAttributedString
    private let kSign:String = "%"
    private let kSliderHeight:CGFloat = 60
    private let kSliderMarginHorizontal:CGFloat = 30
    private let kLabelPercentHeight:CGFloat = 50
    private let kLabelSizeHeight:CGFloat = 30
    private let kMinValue:Float = 0.1
    private let kMaxValue:Float = 1
    
    required init(controller:CEditScale)
    {
        let attributesPercentSign:[String:AnyObject] = [
            NSFontAttributeName:UIFont.light(size:16)]
        stringSing = NSAttributedString(
            string:kSign,
            attributes:attributesPercentSign)
        
        attributesPercentNumber = [
            NSFontAttributeName:UIFont.light(size:40)]
        
        super.init(controller:controller)
        
        let slider:UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = kMinValue
        slider.maximumValue = kMaxValue
        slider.minimumTrackTintColor = UIColor.colourSuccess
        slider.maximumTrackTintColor = UIColor.colourBackgroundGray
        slider.addTarget(
            self,
            action:#selector(actionSlider(sender:)),
            for:UIControlEvents.valueChanged)
        self.slider = slider
        
        let labelPercent:UILabel = UILabel()
        labelPercent.isUserInteractionEnabled = false
        labelPercent.translatesAutoresizingMaskIntoConstraints = false
        labelPercent.backgroundColor = UIColor.clear
        labelPercent.textAlignment = NSTextAlignment.center
        labelPercent.textColor = UIColor.colourBackgroundDark
        self.labelPercent = labelPercent
        
        let labelSize:UILabel = UILabel()
        labelSize.isUserInteractionEnabled = false
        labelSize.translatesAutoresizingMaskIntoConstraints = false
        labelSize.backgroundColor = UIColor.clear
        labelSize.textAlignment = NSTextAlignment.center
        labelSize.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.6)
        labelSize.font = UIFont.regular(size:14)
        self.labelSize = labelSize
        
        addSubview(labelSize)
        addSubview(labelPercent)
        addSubview(slider)
        
        NSLayoutConstraint.bottomToBottom(
            view:slider,
            toView:self)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self,
            margin:kSliderMarginHorizontal)
        
        NSLayoutConstraint.bottomToTop(
            view:labelPercent,
            toView:labelSize)
        NSLayoutConstraint.height(
            view:labelPercent,
            constant:kLabelPercentHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelPercent,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:labelSize,
            toView:slider)
        NSLayoutConstraint.height(
            view:labelSize,
            constant:kLabelSizeHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSize,
            toView:self)
        
        guard
            
            let sliderValue:CGFloat = controller.model.edit.sequence?.scale
        
        else
        {
            return
        }
        
        slider.value = Float(sliderValue)
        
        print()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionSlider(sender slider:UISlider)
    {
        print()
        
        let value:CGFloat = CGFloat(slider.value)
        controller.model.edit.sequence?.scale = value
        
        guard
        
            let view:VEditScale = controller.view as? VEditScale
        
        else
        {
            return
        }
        
        view.viewImage.updateScale()
    }
    
    //MARK: private
    
    private func print()
    {
        let value:CGFloat = CGFloat(slider.value)
        let valueInt:Int = Int(value)
        let stringValue:String = "\(value)"
        let stringNumber:NSAttributedString = NSAttributedString(
            string:stringValue,
            attributes:attributesPercentNumber)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringNumber)
        mutableString.append(stringSing)
        
        labelPercent.attributedText = mutableString
    }
}
