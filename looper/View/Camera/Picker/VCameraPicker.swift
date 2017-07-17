import UIKit

class VCameraPicker:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraPicker!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private var imageSize:CGSize!
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraPicker
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeUploadCellActive.self,
            forCellWithReuseIdentifier:
            VHomeUploadCellActive.reusableIdentifier)
        collectionView.register(
            VHomeUploadCellClouded.self,
            forCellWithReuseIdentifier:
            VHomeUploadCellClouded.reusableIdentifier)
        
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kInterLine,
            left:kInterLine,
            bottom:kCollectionBottom,
            right:kInterLine)
        
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        computeImageSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func computeImageSize()
    {
        let width:CGFloat = bounds.maxX - kInterLine
        let proximate:CGFloat = floor(width / controller.kThumbnailSize)
        let size:CGFloat = (width / proximate) - kInterLine
        imageSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MHomeUploadItem
    {
        let item:MHomeUploadItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return imageSize
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        header = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VHomeUploadHeader.reusableIdentifier,
            for:indexPath) as? VHomeUploadHeader
        header!.config(controller:controller)
        
        return header!
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        let cell:VHomeUploadCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.status.reusableIdentifier,
            for:indexPath) as! VHomeUploadCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldDeselectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        return item.status.selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        item.statusWaiting()
        
        updateBar()
    }
    
    func collectionView(_ collectionView:UICollectionView, didDeselectItemAt indexPath:IndexPath)
    {
        let item:MHomeUploadItem = modelAtIndex(index:indexPath)
        
        if !item.status.finished
        {
            item.statusClear()
        }
        
        updateBar()
    }
}
