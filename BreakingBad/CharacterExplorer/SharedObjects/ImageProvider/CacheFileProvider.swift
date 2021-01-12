//
//  CacheFileProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol CacheFileProvider {
    func fileUrl(forName: String) -> URL?
    func save(_ image: UIImage, withName name: String)
}

extension FileManager: CacheFileProvider {

    func fileUrl(forName fileName: String) -> URL? {
        guard let cacheURL = urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return cacheURL.appendingPathComponent(fileName)
    }

    func save(_ image: UIImage, withName name: String) {
        guard let fileURL = fileUrl(forName: name) else {
            return
        }
        try? image.pngData()?.write(to: fileURL)
    }
}
