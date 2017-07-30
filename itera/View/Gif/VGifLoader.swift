import UIKit

extension VGif
{
    class func withURL(url:URL) -> VGif
    {
        let view:VGif = VGif()
        
        return view
    }
    
    //MARK: private
    
    private func loadWithURL(url:URL)
    {
        guard
        
            let data:Data = loadData(url:url)
        
        else
        {
            return
        }
        
        
    }
    
    private func loadData(url:URL) -> Data?
    {
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:url,
                options:Data.ReadingOptions.uncached)
        }
        catch
        {
            return nil
        }
        
        return data
    }
}
