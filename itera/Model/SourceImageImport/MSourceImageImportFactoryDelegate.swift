import UIKit

protocol MSourceImageImportFactoryDelegate:class
{
    func importSequenceReady(sequence:MEditSequence)
    func importError()
    func importProgress(percent:CGFloat, image:UIImage?)
}
