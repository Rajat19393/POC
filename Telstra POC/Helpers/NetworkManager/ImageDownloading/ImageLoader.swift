//
//  ImageLoader.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 05/10/24.
//

import UIKit

class ImageLoader {
    
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
//         A UUID will be proviided for each download task
//        After Downloading, need to check if we are setting image for the same cell we started download from.
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            once the download is completed we will remove our download task from array of download tasks
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }

            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
//        Cancelling the runningRequests with sent uuid
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
