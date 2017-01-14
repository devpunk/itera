import UIKit

class VCameraRotateHandler:UIView
{
    private var radius:CGFloat
    private var centerArc:CGPoint
    private let kMargin:CGFloat = 20
    private let kZeroRad:CGFloat = 0
    private let k360Rad:CGFloat = 6.28319
    private let kDeltaRad:CGFloat = 1
    private let kRadSize:CGFloat = 0.1
    private let kRadLineWidth:CGFloat = 4
    
    init()
    {
        radius = 0
        centerArc = CGPoint.zero
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let centerX:CGFloat = bounds.midX
        let centerY:CGFloat = bounds.midY
        let minSize:CGFloat = min(centerX, centerY)
        radius = minSize - kMargin
        centerArc = CGPoint(x:centerX, y:centerY)
        
        super.layoutSubviews()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        context.setLineWidth(kRadLineWidth)
        context.setStrokeColor(UIColor.black.cgColor)
        
        var currentRad:CGFloat = kZeroRad
        
        while currentRad < k360Rad
        {
            let initial:CGFloat = currentRad
            currentRad += kRadSize
            let end:CGFloat = currentRad
            currentRad += kDeltaRad
            
            context.addArc(
                center:centerArc,
                radius:radius,
                startAngle:initial,
                endAngle:end,
                clockwise:false)
            
            context.drawPath(using:CGPathDrawingMode.stroke)
        }
    }
}