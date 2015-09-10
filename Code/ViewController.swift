//
//  ViewController.swift
//  tvful
//
//  Created by Boris Bügling on 10/09/15.
//  Copyright © 2015 Boris Bügling. All rights reserved.
//

import ContentfulDeliveryAPI
import UIKit

class ViewController: UIViewController {
    static let AccessToken = "51910a9d4752a24728c44a8dc4422291305eed4c20000003b73d4a47475f1740"
    static let SpaceId = "1qptv5yuwnfh"

    let client = CDAClient(spaceKey: SpaceId, accessToken: AccessToken)
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)

        client.fetchEntriesMatching(["content_type": "1xYw5JsIecuGE68mmGMg20"], success: { (_, entries) in
            let imageUrls = entries.items.flatMap() { (entry) in
                (entry.fields["photo"] as? CDAAsset)?.URL
            }

            let session = NSURLSession.sharedSession()
            let task = session.downloadTaskWithURL(imageUrls[0], completionHandler: { (location, _, error) in
                if let location = location, data = NSData(contentsOfURL: location) {
                    self.imageView.image = UIImage(data: data)
                }

                if let error = error {
                    print(error)
                }
            })
            task.resume()
        }) { (_, error) in
            print(error)
        }
    }
}
