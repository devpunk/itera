import Foundation

extension MHome
{
    class func factoryMenu() -> [MHomeMenuProtocol]
    {
        let itemShare:MHomeMenuShare = MHomeMenuShare()
        let itemFullScreen:MHomeMenuFullScreen = MHomeMenuFullScreen()
        let itemDelete:MHomeMenuDelete = MHomeMenuDelete()
        
        let items:[MHomeMenuProtocol] = [
            itemShare,
            itemFullScreen,
            itemDelete]
        
        return items
    }
}
