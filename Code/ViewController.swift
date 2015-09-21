//
//  ViewController.swift
//  tvful
//
//  Created by Boris Bügling on 10/09/15.
//  Copyright © 2015 Boris Bügling. All rights reserved.
//

import ContentfulDeliveryAPI
import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = NSStringFromClass(ImageCell.self)
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        imageView.contentMode = .ScaleAspectFit
        imageView.frame = bounds
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    func loadAsset(asset: CDAAsset) {
        let scale = UIScreen.mainScreen().scale
        imageView.cda_setImageWithAsset(asset, size: CGSize(width: frame.size.width * scale, height: frame.size.height * scale))
    }
}

class ViewController: UICollectionViewController {
    static let AccessToken = "51910a9d4752a24728c44a8dc4422291305eed4c20000003b73d4a47475f1740"
    static let SpaceId = "1qptv5yuwnfh"

    let client = CDAClient(spaceKey: SpaceId, accessToken: AccessToken)
    var assets: [CDAAsset] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 300, height: 300)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView?.collectionViewLayout = flowLayout

        collectionView?.registerClass(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)

        client.fetchEntriesMatching(["content_type": "1xYw5JsIecuGE68mmGMg20"], success: { (_, entries) in
            self.assets = entries.items.flatMap() { (entry) in
                (entry.fields["photo"] as? CDAAsset)
            }

            self.collectionView?.reloadData()
        }) { (_, error) in
            print(error)
        }
    }

    override func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCell.identifier, forIndexPath: indexPath) as! ImageCell
        cell.loadAsset(assets[indexPath.row])
        //cell.performSelector("_whyIsThisViewNotFocusable")
        return cell
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
