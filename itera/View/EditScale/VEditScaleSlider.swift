import UIKit

class VEditScaleSlider:View<VEditScale, MEditScale, CEditScale>
{
    private weak var slider:UISlider!
    private weak var labelPercent:UILabel!
    private weak var labelSize:UILabel!
    private let numberFormatter:NumberFormatter
    private let attributesPercentNumber:[String:AnyObject]
    private let stringSing:NSAttributedString
    private let kSign:String = "%"
    private let kSliderHeight:CGFloat = 58
    private let kSliderMarginHorizontal:CGFloat = 30
    private let kLabelPercentHeight:CGFloat = 54
    private let kLabelSizeHeight:CGFloat = 18
    private let kAnimationDuration:TimeInterval = 0.3
    private let kMinValue:Float = 0.1
    private let kMaxValue:Float = 1
    private let kHalf:Float = 0.5
    private let kQuarter:Float = 0.25
    private let kThreeQuarters:Float = 0.75
    private let kMaxDecimals:Int = 1
    private let kMinDecimals:Int = 1
    private let kMinIntegers:Int = 1
    
    required init(controller:CEditScale)
    {
        let attributesPercentSign:[String:AnyObject] = [
            NSFontAttributeName:UIFont.light(size:22)]
        stringSing = NSAttributedString(
            string:kSign,
            attributes:attributesPercentSign)
        
        attributesPercentNumber = [
            NSFontAttributeName:UIFont.light(size:50)]
        
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinIntegers
        numberFormatter.maximumFractionDigits = kMaxDecimals
        numberFormatter.minimumFractionDigits = kMinDecimals
        
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
        labelSize.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.82)
        labelSize.font = UIFont.light(size:14)
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
    
    //MARK: selectors
    
    func actionSlider(sender slider:UISlider)
    {
        updateValue()
    }
    
    //MARK: private
    
    private func updateValue()
    {
        updateModel()
        print()
        
        guard
            
            let view:VEditScale = controller.view as? VEditScale
            
        else
        {
            return
        }
        
        view.viewImage.updateScale()
    }
    
    private func updateModel()
    {
        let value:CGFloat = CGFloat(slider.value)
        controller.model.edit.sequence?.scale = value
    }
    
    private func print()
    {
        let value:CGFloat = CGFloat(slider.value)
        let width:CGFloat = controller.model.originalWidth
        let height:CGFloat = controller.model.originalHeight
        let scaledWidth:Int = Int(width * value)
        let scaledHeight:Int = Int(height * value)
        let valueNumber:NSNumber = (value * 100) as NSNumber
        let stringSize:String = "\(scaledWidth) × \(scaledHeight)"
        
        guard
            
            let stringValue:String = numberFormatter.string(from:valueNumber)
        
        else
        {
            return
        }
        
        let stringNumber:NSAttributedString = NSAttributedString(
            string:stringValue,
            attributes:attributesPercentNumber)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(stringNumber)
        mutableString.append(stringSing)
        
        labelPercent.attributedText = mutableString
        labelSize.text = stringSize
    }
    
    private func animateTo(value:Float)
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak self] in
                
                self?.slider.setValue(value, animated:true)
            })
        { [weak self] (done:Bool) in
            
            self?.updateValue()
        }
    }
    
    //MARK: public
    
    func half()
    {
        animateTo(value:kHalf)
    }
    
    func quarter()
    {
        animateTo(value:kQuarter)
    }
    
    func threeQuarters()
    {
        animateTo(value:kThreeQuarters)
    }
}
