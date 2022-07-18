//
//  DownloadManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
import SwiftUI

@MainActor class DownloadManager: ObservableObject {
    
    @Published var data = Data()
    @Published var imageReadyToShow = false
    let card: Card
    let shouldImageBeSaved: Bool

    init(card: Card, shouldImageBeSaved: Bool, downloadDelay: Int) {
        self.card = card
        self.shouldImageBeSaved = shouldImageBeSaved
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(downloadDelay)) {
            if card.cardImageURL != "" {
                print(card.cardImageURL)
                let url = URL(string: card.cardImageURL)!

                self.loadData(cardName: card.cardOracleId + card.specificSet, url: url) { (data, error) in
                    // Handle the loaded file data
                    if error == nil {
                        DispatchQueue.main.async {
                            self.data = data! as Data
                            self.imageReadyToShow = true
                            self.card.cardUIImage = Image(uiImage: (UIImage(data: self.data)) ?? UIImage(named: "MTGBackground")!)
                        }
                    }
                }
            }
        }
    }
    
    func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            // Handle potential file system errors
            catch _ {
                completion(error)
            }
        }

        // Start the download
        task.resume()
    }
    
    func loadData(cardName: String, url: URL, completion: @escaping (Data?, Error?) -> Void) {
        // Compute a path to the URL in the cache
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                cardName,
                isDirectory: false
            )
        
        // If the image exists in the cache,
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: fileCachePath) {
            completion(data, nil)
            return
        }
        
        // If the image does not exist in the cache,
        // download the image to the cache
        download(url: url, toFile: fileCachePath) { (error) in
            let data = try? Data(contentsOf: fileCachePath)
            completion(data, error)
            // If temporary image, we delete it after retrieveing it
            if !self.shouldImageBeSaved {
                do {
                    try FileManager.default.removeItem(at: fileCachePath)
                } catch _ {
                    print("Temporary image supression failed")
                }
            }
        }
    }
}
