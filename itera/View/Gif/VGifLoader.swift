import UIKit
import ImageIO

extension VGif
{
    private static let kDefaultDuration:TimeInterval = 1
    
    class func withURL(url:URL) -> VGif
    {
        let view:VGif = VGif()
        
        view.queueGif.async
        { [weak view] in
            
            view?.loadWithURL(url:url)
        }
        
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
        
        loadFrames(source:source)
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
            kCGImageSourceShouldCache as String:kCFBooleanFalse]
        let cfDictionary:CFDictionary = dictionary as CFDictionary
        
        return cfDictionary
    }
    
    private func loadFrames(source:CGImageSource)
    {
        let count:Int = CGImageSourceGetCount(source)
        
        for index:Int in 0 ..< count
        {
            let itemDuation:TimeInterval =  frameDuration(
                source:source,
                index:index)
        }
    }
    
    private func frameDuration(
        source:CGImageSource,
        index:Int) -> TimeInterval
    {
        guard
            
            let properties:[String:AnyObject] = frameProperties(
                source:source,
                index:index),
            let gifProperties:[String:AnyObject] = properties[
                kCGImagePropertyGIFDictionary as String] as? [String:AnyObject],
            let delayTime:Double = gifProperties[
                kCGImagePropertyGIFDelayTime as String] as? Double
        
        else
        {
            return VGif.kDefaultDuration
        }
        
        let duration:TimeInterval = TimeInterval(delayTime)
        
        return duration
    }
    
    private func frameProperties(
        source:CGImageSource,
        index:Int) -> [String:AnyObject]?
    {
        guard
        
            let properties:CFDictionary = CGImageSourceCopyPropertiesAtIndex(
                source,
                0,
                nil)
        
        else
        {
            return nil
        }
        
        let dictionary:[String:AnyObject]? = properties as? [String:AnyObject]
        
        return dictionary
    }
}
