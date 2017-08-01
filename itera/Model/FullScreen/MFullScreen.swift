import Foundation

class MFullScreen:Model
{
    private(set) weak var item:MHomeItem!
    
    //MARK: public
    
    func config(item:MHomeItem)
    {
        self.item = item
    }
}
