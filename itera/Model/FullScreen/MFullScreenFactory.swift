import Foundation

extension MFullScreen
{
    class func factoryMenu() -> [MFullScreenProtocol]
    {
        let itemShare:MFullScreenShare = MFullScreenShare()
        let itemExitFullScreen:MFullScreenExitFullScreen = MFullScreenExitFullScreen()
        
        let items:[MFullScreenProtocol] = [
            itemShare,
            itemExitFullScreen]
        
        return items
    }
}
