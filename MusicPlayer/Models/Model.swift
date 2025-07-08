//
//  Model.swift
//  MusicPlayer
//
//  Created by Dmitrii Nazarov on 30.05.2025.
//

import Foundation
import RealmSwift

// MARK: ~ SongModel
class SongModel: Object, ObjectKeyIdentifiable {
    // MARK: ~ Properties
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var data: Data
    @Persisted var artist: String?
    @Persisted var coverImage: Data?
    @Persisted var duration: TimeInterval?
    
    // MARK: ~ Init
    convenience init(name: String, data: Data, artist: String? = nil, coverImage: Data? = nil, duration: TimeInterval? = nil) {
        self.init()
        self.name = name
        self.data = data
        self.artist = artist
        self.coverImage = coverImage
        self.duration = duration
    }
}
