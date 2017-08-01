import Foundation

extension MHome
{
    class func factoryMenu() -> [MHomeMenuProtocol]
    {
        let itemShare:MHomeMenuShare = MHomeMenuShare()
        let itemFullScreen:MHomeMenuFullScreen = MHomeMenuFullScreen()
        
        let items:[MHomeMenuProtocol] = [
            itemShare,
            itemFullScreen]
        
        return items
    }
}
