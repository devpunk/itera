import UIKit

class VEditScaleImageOriginal:View<VEditScale, MEditScale, CEditScale>
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    private let kCornerWidth:CGFloat = 4
    private let kCornerLength:CGFloat = 20
    
    required init(controller:CEditScale)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        let width:CGFloat = rect.width
        let height:CGFloat = rect.height
        let cornerWidth_2:CGFloat = kCornerWidth / 2.0
        let maxWidth:CGFloat = width - cornerWidth_2
        let maxHeight:CGFloat = height - cornerWidth_2
        let width_corner:CGFloat = width - kCornerLength
        let height_corner:CGFloat = height - kCornerLength
        
        context.setLineWidth(kCornerWidth)
        context.setStrokeColor(UIColor.colourBackgroundDark.cgColor)
        
        context.move(to:CGPoint(x:cornerWidth_2, y:kCornerLength))
        context.addLine(to:CGPoint(x:cornerWidth_2, y:cornerWidth_2))
        context.addLine(to:CGPoint(x:kCornerLength, y:cornerWidth_2))
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.move(to:CGPoint(x:maxWidth, y:kCornerLength))
        context.addLine(to:CGPoint(x:maxWidth, y:cornerWidth_2))
        context.addLine(to:CGPoint(x:width_corner, y:cornerWidth_2))
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.move(to:CGPoint(x:cornerWidth_2, y:height_corner))
        context.addLine(to:CGPoint(x:cornerWidth_2, y:maxHeight))
        context.addLine(to:CGPoint(x:kCornerLength, y:maxHeight))
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.move(to:CGPoint(x:maxWidth, y:height_corner))
        context.addLine(to:CGPoint(x:maxWidth, y:maxHeight))
        context.addLine(to:CGPoint(x:width_corner, y:maxHeight))
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
