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

    init(card: Card, shouldImageBeSaved: Bool) {
        self.card = card
        self.shouldImageBeSaved = shouldImageBeSaved
    }
    
    func startDownloading() {
        if card.cardImageURL != "" {
            //print(card.cardName + " -> " + card.cardImageURL + " -> " + card.cardOracleId + card.specificSet)
            let showFront = card.showFront
            guard let url = URL(string: card.showFront ? card.cardImageURL : card.cardBackImageURL) else { return }

            self.loadData(cardName: card.cardId + (showFront ? "" : "_back"), url: url) { (data, error) in
                // Handle the loaded file data
                if error == nil {
                    DispatchQueue.main.async {
                        if data != nil {
                            self.data = data! as Data
                            self.imageReadyToShow = true
                            if showFront {
                                self.card.cardUIImage = Image(uiImage: (UIImage(data: self.data)) ?? UIImage(named: "MTGBackground")!)
                            } else {
                                self.card.cardBackUIImage = Image(uiImage: (UIImage(data: self.data)) ?? UIImage(named: "MTGBackground")!)
                            }
                            self.card.objectWillChange.send()
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

                //try FileManager.default.moveItem(at: tempURL, to: file)
                
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
        /*
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                cardName,
                isDirectory: false
            )
         */
        let documents = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        var fileCachePath = documents.appendingPathComponent("\(cardName).png")
        if cardName.contains("https://i.imgur") || cardName.contains("D::") {
            fileCachePath = documents.appendingPathComponent("\(cardName.replacingOccurrences(of: "/", with: ""))")
            print("downloading \(url)")
        }
        // If the image exists in the cache,
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: fileCachePath!) {
            completion(data, nil)
            return
        }
        
        // If the image does not exist in the cache,
        // download the image to the cache
        download(url: url, toFile: fileCachePath!) { (error) in
            let data = try? Data(contentsOf: fileCachePath!)
            completion(data, error)
            // If temporary image, we delete it after retrieveing it
            
            if !self.shouldImageBeSaved {
                do {
                    try FileManager.default.removeItem(at: fileCachePath!)
                } catch _ {
                    print("Temporary image supression failed")
                }
            }
        }
    }
    
    static func removeAllSavedImages() {
        let fileManager = FileManager.default
        do {
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in fileURLs {
               try fileManager.removeItem(at: url)
            }
        } catch {
            print(error)
        }
    }
}

class DownloadQueue: NSObject {
    
    @objc static let queue = DownloadQueue()
    private override init(){
        self.timeToStartDownload = Date()
    }
    private var timeToStartDownload: Date
    private var delayBetweenDownloads: CGFloat = 0.1
    
    func getDelayBeforeDownload(card: Card) -> TimeInterval {
        if imageAlreadyDownloaded(card: card) { return 0 }
        let timeInterval = timeToStartDownload.timeIntervalSinceNow
        
        // Last download is old -> the queue is empty -> start downloading now
        if timeInterval < 0 {
            timeToStartDownload = Date() + delayBetweenDownloads
            return 0
        }
        
        // If the queue is not empty
        timeToStartDownload += delayBetweenDownloads
        return timeInterval
    }
    
    private func imageAlreadyDownloaded(card: Card) -> Bool {
        // If the image exists in the cache,
        // load the image from the cache and exit
        let documents = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let cardFileCachePath = documents.appendingPathComponent("\(card.cardId).png")
        //if (try? Data(contentsOf: cardFileCachePath)) != nil {
        if FileManager.default.fileExists(atPath: cardFileCachePath!.path) {
            return true
        }
        return false
    }
    
    func resetQueue() {
        self.timeToStartDownload = Date()
    }
}
