import UIKit
import ImageIO

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
        
            let source:CGImageSource = factorySource(url:url)
        
        else
        {
            return
        }
        
        let count:Int = CGImageSourceGetCount(source)
        
    }
    
    private func factorySource(url:URL) -> CGImageSource?
    {
        guard
            
            let data:CFData = loadData(url:url)
            
        else
        {
            return nil
        }
        
        let options:CFDictionary = sourceOptions()
        
        guard
        
            let source:CGImageSource = CGImageSourceCreateWithData(
                data,
                options)
        
        else
        {
            return nil
        }
        
        return source
    }
    
    private func loadData(url:URL) -> CFData?
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
        
        let cfData:CFData = data as CFData
        
        return cfData
    }
    
    private func sourceOptions() -> CFDictionary
    {
        let dictionary:[String:Any] = [
            String(kCGImageSourceShouldCache):kCFBooleanFalse]
        let cfDictionary:CFDictionary = dictionary as CFDictionary
        
        return cfDictionary
    }
}
