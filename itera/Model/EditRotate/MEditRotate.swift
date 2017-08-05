import UIKit

class MEditRotate:Model
{
    private(set) weak var edit:MEdit!
    private let pi_2:CGFloat
    private let rotateMax:CGFloat
    private let rotateMin:CGFloat
    
    required init()
    {
        pi_2 = CGFloat.pi / 2
        rotateMax = CGFloat.pi + pi_2
        rotateMin = -rotateMax
        
        super.init()
    }
    
    //MARK: internal
    
    func config(edit:MEdit)
    {
        self.edit = edit
    }
    
    func rotateRight()
    {
        guard
        
            let sequence:MEditSequence = edit.sequence
        
        else
        {
            return
        }
        
        sequence.rotate += pi_2
        
        if sequence.rotate > rotateMax
        {
            sequence.rotate = 0
        }
    }
    
    func rotateLeft()
    {
        guard
            
            let sequence:MEditSequence = edit.sequence
            
        else
        {
            return
        }
        
        sequence.rotate -= pi_2
        
        if sequence.rotate < rotateMin
        {
            sequence.rotate = 0
        }
    }
}
