import UIKit
import ImageIO
import MobileCoreServices

extension MSave
{
    func factoryGif(
        sequence:MEditSequence,
        path:URL)
    {
        let items:[MEditSequenceItem] = sequence.items
        let totalImages:Int = items.count
        
        guard
            
            let destination:CGImageDestination = CGImageDestinationCreateWithURL(
                path as CFURL,
                kUTTypeGIF,
                totalImages,
                nil)
            
        else
        {
            savingError()
            
            return
        }
        
        let destinationProperties:CFDictionary = factoryDestinationProperties()
        let imageProperties:CFDictionary = factoryImageProperties(sequence:sequence)
        
        CGImageDestinationSetProperties(
            destination,
            destinationProperties)
        
        scheduleGeneration(
            destination:destination,
            properties:imageProperties,
            index:0,
            items:items)
    }
    
    //MARK: private
    
    private func durationPerImage(sequence:MEditSequence) -> TimeInterval
    {
        let duration:TimeInterval = sequence.duration
        let totalImages:Int = sequence.items.count
        let totalImagesInterval:TimeInterval = TimeInterval(totalImages)
        let imageDuration:TimeInterval = duration / totalImagesInterval
        
        return imageDuration
    }
    
    private func factoryDestinationProperties() -> CFDictionary
    {
        let destinationPropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFLoopCount as String:0]]
        let destinationProperties:CFDictionary = destinationPropertiesRaw as CFDictionary
        
        return destinationProperties
    }
    
    private func factoryImageProperties(sequence:MEditSequence) -> CFDictionary
    {
        let duration:TimeInterval = durationPerImage(sequence:sequence)
        let imagePropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFDelayTime as String:duration]]
        let imageProperties:CFDictionary = imagePropertiesRaw as CFDictionary
        
        return imageProperties
    }
    
    private func scheduleGeneration(
        destination:CGImageDestination,
        properties:CFDictionary,
        index:Int,
        items:[MEditSequenceItem])
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kDelayGeneration)
        { [weak self] in
            
            self?.generate(
                destination:destination,
                properties:properties,
                index:index,
                items:items)
        }
    }
    
    private func generate(
        destination:CGImageDestination,
        properties:CFDictionary,
        index:Int,
        items:[MEditSequenceItem])
    {
        let count:Int = items.count
        
        if index < count
        {
            updateProgress(index:index, count:count)
            
            let newIndex:Int = index + 1
            let item:MEditSequenceItem = items[index]
            let cgImage:CGImage = item.image
            
            CGImageDestinationAddImage(
                destination,
                cgImage,
                properties)
            
            scheduleGeneration(
                destination:destination,
                properties:properties,
                index:newIndex,
                items:items)
        }
        else
        {
            finishGeneration(destination:destination)
        }
    }
    
    private func updateProgress(index:Int, count:Int)
    {
        let indexFloat:CGFloat = CGFloat(index)
        let countFloat:CGFloat = CGFloat(count)
        let percent:CGFloat = indexFloat / countFloat
        controller?.updateProgress(percent:percent)
    }
    
    private func finishGeneration(destination:CGImageDestination)
    {
        CGImageDestinationFinalize(destination)
        
        savingSuccess()
    }
}
