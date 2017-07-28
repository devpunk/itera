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
        let duration:TimeInterval = sequence.duration
        let totalImages:Int = items.count
        let totalImagesInterval:TimeInterval = TimeInterval(totalImages)
        let imageDuration:TimeInterval = duration / totalImagesInterval
        
        guard
            
            let destination:CGImageDestination = CGImageDestinationCreateWithURL(
                path as CFURL,
                kUTTypeGIF,
                totalImages,
                nil)
            
        else
        {
            return
        }
        
        let destinationPropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFLoopCount as String:0]]
        let destinationProperties:CFDictionary = destinationPropertiesRaw as CFDictionary
        
        CGImageDestinationSetProperties(
            destination,
            destinationProperties)
        
        scheduleGeneration(
            destination:destination,
            index:0,
            items:items,
            duration:imageDuration)
        
        CGImageDestinationFinalize(destination)
    }
    
    //MARK: private
    
    private func scheduleGeneration(
        destination:CGImageDestination,
        index:Int,
        items:[MEditSequenceItem],
        duration:TimeInterval)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kDelayGeneration)
        { [weak self] in
            
            self?.generate(
                destination:destination,
                index:index,
                items:items,
                duration:duration)
        }
    }
    
    private func generate(
        destination:CGImageDestination,
        index:Int,
        items:[MEditSequenceItem],
        duration:TimeInterval)
    {
        let count:Int = items.count
        
        if index < count
        {
            updateProgress(index:index, count:count)
            
            let newIndex:Int = index + 1
            let item:MEditSequenceItem = items[index]
            let cgImage:CGImage = item.image
            let gifPropertiesRaw:[String:Any] = [
                kCGImagePropertyGIFDictionary as String:[
                    kCGImagePropertyGIFDelayTime as String:duration]]
            let gifProperties:CFDictionary = gifPropertiesRaw as CFDictionary
            
            CGImageDestinationAddImage(
                destination,
                cgImage,
                gifProperties)
            
            scheduleGeneration(
                destination:destination,
                index:newIndex,
                items:items,
                duration:duration)
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
        controller?.done()
    }
}
