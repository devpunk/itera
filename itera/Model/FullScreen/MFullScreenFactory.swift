import Foundation

extension MFullScreen
{
    class func factoryMenu() -> [MFullScreenProtocol]
    {
        let itemShare:MFullScreenShare = MFullScreenShare()
        let itemExitFullScreen:MFullScreenExitFullScreen = MFullScreenExitFullScreen()
        let itemDelete:MFullScreenDelete = MFullScreenDelete()
        
        let items:[MFullScreenProtocol] = [
            itemShare,
            itemExitFullScreen,
            itemDelete]
        
        return items
    }
}
