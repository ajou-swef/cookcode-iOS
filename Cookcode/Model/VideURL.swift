//
//  VideURL.swift
//  Cookcode
//
//  Created by 노우영 on 2023/04/20.
//

import AVKit
import PhotosUI
import SwiftUI

struct VideoURL: Transferable, Hashable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            return SentTransferredFile(movie.url)
        } importing: { received in
            let randomString = String.createRandomString(length: 10)
            let copy = URL.documentsDirectory.appending(path: "\(randomString).movie.mp4")
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
}
