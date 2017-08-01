import Foundation

extension MHome
{
    class func factoryMenu() -> [MHomeMenuProtocol]
    {
        let itemShare:MHomeMenuShare = MHomeMenuShare()
        
        let items:[MHomeMenuProtocol] = [
            itemShare]
        
        return items
    }
}
