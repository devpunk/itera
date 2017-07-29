import Foundation

class MEditRotate:Model
{
    private(set) weak var edit:MEdit!
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
    }
}
