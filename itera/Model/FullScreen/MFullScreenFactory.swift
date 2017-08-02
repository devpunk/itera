import Foundation

extension MFullScreen
{
    class func factoryMenu() -> [MFullScreenProtocol]
    {
        let itemExitFullScreen:MFullScreenExitFullScreen = MFullScreenExitFullScreen()
        
        let items:[MFullScreenProtocol] = [
            itemExitFullScreen]
        
        return items
    }
}
