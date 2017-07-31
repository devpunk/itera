import UIKit
import ImageIO

extension VGif
{
    private static let kQueueLabel:String = "iturbide.itera.gif"
    private static let kDefaultDuration:TimeInterval = 1
    
    class func withURL(url:URL) -> VGif
    {
        let view:VGif = VGif()
        let queue:DispatchQueue = factoryQueue()
        
        queue.async
        { [weak view] in
            
            view?.loadWithURL(url:url)
        }
        
        return view
    }
    
    class func factorySource(url:URL) -> CGImageSource?
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
    
    class func frameOptions() -> CFDictionary
    {
        let dictionary:[String:Any] = [
            kCGImageSourceShouldCache as String:kCFBooleanFalse]
        let cfDictionary:CFDictionary = dictionary as CFDictionary
        
        return cfDictionary
    }
    
    class func frameImage(
        source:CGImageSource,
        index:Int,
        options:CFDictionary) -> CGImage?
    {
        guard
            
            let image:CGImage = CGImageSourceCreateImageAtIndex(
                source,
                index,
                options)
            
        else
        {
            return nil
        }
        
        return image
    }
    
    //MARK: private
    
    private class func factoryQueue() -> DispatchQueue
    {
        let queue = DispatchQueue(
            label:kQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        return queue
    }
    
    private class func loadData(url:URL) -> CFData?
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
    
    private class func sourceOptions() -> CFDictionary
    {
        let dictionary:[String:Any] = [
            kCGImageSourceShouldCache as String:kCFBooleanFalse]
        let cfDictionary:CFDictionary = dictionary as CFDictionary
        
        return cfDictionary
    }
    
    private func loadWithURL(url:URL)
    {
        guard
        
            let source:CGImageSource = VGif.factorySource(url:url)
        
        else
        {
            return
        }
        
        loadFrames(source:source)
    }
    
    private func loadFrames(source:CGImageSource)
    {
        let count:Int = CGImageSourceGetCount(source)
        let options:CFDictionary = VGif.frameOptions()
        var frames:[VGifFrame] = []
        
        for index:Int in 0 ..< count
        {
            guard
                
                let image:CGImage = VGif.frameImage(
                    source:source,
                    index:index,
                    options:options)
            
            else
            {
                continue
            }
            
            let itemDuration:TimeInterval =  frameDuration(
                source:source,
                index:index)
            
            let frame:VGifFrame = VGifFrame(
                image:image,
                duration:itemDuration)
            frames.append(frame)
        }
        
        framesLoaded(frames:frames)
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
