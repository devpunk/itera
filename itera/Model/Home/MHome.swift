import Foundation

class MHome:Model
{
    var selected:Int
    let menu:[MHomeMenuProtocol]
    private(set) var items:[MHomeItem]
    
    required init()
    {
        selected = 0
        items = []
        menu = MHome.factoryMenu()
        
        super.init()
    }
    
    //MARK: public
    
    func itemsLoaded(items:[MHomeItem])
    {
        self.items = items
        selected = 0
        delegate?.modelRefresh()
    }
    
    func currentItem() -> MHomeItem?
    {
        if selected < items.count
        {
            let item:MHomeItem = items[selected]
            
            return item
        }
        
        return nil
    }
}
