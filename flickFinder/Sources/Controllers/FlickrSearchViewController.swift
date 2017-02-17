//
//  FlickrSearchViewController.swift
//  FlickFinder
//
//  Created by Artem Shyianov on 2/17/17.
//  Copyright © 2017 Artem Shyianov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FlickrSearchViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Dependencies
    
    private let disposeBag = DisposeBag()
    private let flickrAPIService = FlickrAPIService()
    private var selectedPhoto: FlickrPhoto?
    private var columnsCount: Float = 3 {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        let searchResults = self.textField.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[FlickrPhoto]> in
                if query.isEmpty {
                    return .just([])
                }

                return self.flickrAPIService.getPhotos(text: query)
                    .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bindTo(collectionView.rx.items(cellIdentifier: kFlickrPhotoIdentifier)) {
                (index, flickPhoto: FlickrPhoto, cell: FlickrPhotoViewCell) in
                cell.configure(photo: flickPhoto)
            }
            .disposed(by: disposeBag)
        self.slider.rx.controlEvent(.valueChanged).subscribe(
            onNext: { sender in
            let roundCount = round(self.slider.value / 1) * 1
            self.slider.value = roundCount
            self.columnsCount = roundCount
        }, onError: { (error) in
            
        }).addDisposableTo(disposeBag)
        collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        let _ = collectionView.rx.modelSelected(FlickrPhoto.self).subscribe(
            onNext: { (photo) in
            self.selectedPhoto = photo
            self.performSegue(withIdentifier: "detail", sender: self)
        }, onError: { (error) in
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? PhotoDetailViewController
        detailVC?.flickrPhoto = selectedPhoto
    }
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(self.columnsCount - 1))
        let size = Int((collectionView.bounds.width - totalSpace)
            / CGFloat(self.columnsCount))
        return CGSize(width: size, height: size)
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

}
