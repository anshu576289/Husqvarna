//
//  ImageLoaderService.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import UIKit
import Utilities

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage(systemName: "photo.fill") ?? UIImage()

    convenience init(url: URL?) {
        self.init()
        loadImage(for: url)
    }

    func loadImage(for url: URL?) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)?.resizeImageTo(size: CGSize(width: 200, height: 150)) ?? UIImage()
                }
            }
            task.resume()
        }
    }
}
