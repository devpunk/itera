import UIKit

class VEditScaleSlider:View<VEditScale, MEditScale, CEditScale>
{
    private weak var slider:UISlider!
    private let kSliderBottom:CGFloat = -20
    private let kSliderHeight:CGFloat = 60
    private let kSliderMarginHorizontal:CGFloat = 30
    private let kMinValue:Float = 0.1
    private let kMaxValue:Float = 1
    
    required init(controller:CEditScale)
    {
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
        
        addSubview(slider)
        
        NSLayoutConstraint.bottomToBottom(
            view:slider,
            toView:self,
            constant:kSliderBottom)
        NSLayoutConstraint.height(
            view:slider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:slider,
            toView:self,
            margin:kSliderMarginHorizontal)
        
        guard
            
            let sliderValue:CGFloat = controller.model.edit.sequence?.scale
        
        else
        {
            return
        }
        
        slider.value = Float(sliderValue)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionSlider(sender slider:UISlider)
    {
        let value:CGFloat = CGFloat(slider.value)
        
//        print()
        controller.model.edit.sequence?.scale = value
        
        guard
        
            let view:VEditScale = controller.view as? VEditScale
        
        else
        {
            return
        }
        
        view.viewImage.updateScale()
    }
}
