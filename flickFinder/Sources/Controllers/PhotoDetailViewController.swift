//
//  PhotoDetailViewController.swift
//  FlickFinder
//
//  Created by Artem Shyianov on 2/17/17.
//  Copyright © 2017 Artem Shyianov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!

    // MARK: Properties
    private let disposeBag = DisposeBag()
    var flickrPhoto: FlickrPhoto!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        imageView.af_setImage(withURL: URL(string: flickrPhoto.imageUrl)!)
        self.closeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { (result) in
            self.dismiss(animated: true, completion: nil)
        }, onError: { (error) in
            
        }).addDisposableTo(disposeBag)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return imageView
    }
}
 
