import Foundation

class MFullScreen:Model
{
    let menu:[MFullScreenProtocol]
    private(set) weak var item:MHomeItem!
    
    required init()
    {
        menu = MFullScreen.factoryMenu()
        super.init()
    }
    
    //MARK: internal
    
    func config(item:MHomeItem)
    {
        self.item = item
    }
}
