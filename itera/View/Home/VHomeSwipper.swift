import UIKit

class VHomeSwipper:View<VHome, MHome, CHome>
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
        print("layout")
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
        
        if locationX >= centerX
        {
            print("move right")
        }
        else
        {
            print("move left")
        }
    }
}
