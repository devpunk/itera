import UIKit

class VHomeSwiper:View<VHome, MHome, CHome>
{
    private var centerX:CGFloat
    
    required init(controller:CHome)
    {
        centerX = 0
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        centerX = width / 2.0
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        guard
            
            let touch:UITouch = touches.first
            
        else
        {
            return
        }
        
        let location:CGPoint = touch.location(in:self)
        let locationX:CGFloat = location.x
        touchedAt(locationX:locationX)
    }
    
    //MARK: private
    
    private func touchedAt(locationX:CGFloat)
    {
        let update:Bool
        
        if locationX >= centerX
        {
            update = controller.model.moveRight()
        }
        else
        {
            update = controller.model.moveLeft()
        }
        
        if update
        {
            updateSelection()
        }
    }
    
    private func updateSelection()
    {
        guard
            
            let view:VHome = controller.view as? VHome
            
        else
        {
            return
        }
        
        view.upateSelection()
    }
}
