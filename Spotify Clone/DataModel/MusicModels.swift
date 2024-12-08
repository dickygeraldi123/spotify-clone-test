//
//  MusicModels.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import Foundation

class PlaylistModels: NSObject {
    var id: String = ""
    var listMusic: [MusicModels] = []
    var playlistName: String = ""

    static func createObject(_ dict: [String: Any]) -> PlaylistModels {
        let new = PlaylistModels()
        new.playlistName = dict["playlistName"] as? String ?? ""
        new.id = dict["id"] as? String ?? ""
        if let listMusic = dict["list"] as? [String: Any], let musicLists = listMusic["list"] as? [[String: Any]] {
            for music in musicLists {
                new.listMusic.append(MusicModels.createObject(music))
            }
        }

        return new
    }
}

class MusicModels: NSObject {
    var wrapperType, kind: String?
    var artistID, collectionID: Int?
    var trackID: Int = -1
    var artistName, collectionName, trackName, collectionCensoredName: String?
    var trackCensoredName: String?
    var collectionArtistID: Int?
    var collectionArtistName: String?
    var collectionArtistViewURL, artistViewURL, collectionViewURL, trackViewURL: String?
    var previewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    var collectionPrice, trackPrice: Double?
    var releaseDate: Double?
    var collectionExplicitness, trackExplicitness: String?
    var discCount, discNumber, trackCount, trackNumber: Int?
    var trackTimeMillis: Int?
    var country, currency, primaryGenreName: String?
    var isStreamable: Bool?

    static func createObject(_ dict: [String: Any]) -> MusicModels {
        let new = MusicModels()

        new.wrapperType = dict["wrapperType"] as? String ?? ""
        new.kind = dict["kind"] as? String ?? ""
        new.artistID = dict["artistId"] as? Int ?? 0
        new.collectionID = dict["collectionId"] as? Int ?? 0
        new.trackID = dict["trackId"] as? Int ?? 0
        new.artistName = dict["artistName"] as? String ?? ""
        new.collectionName = dict["collectionName"] as? String ?? ""
        new.trackName = dict["trackName"] as? String ?? ""
        new.collectionCensoredName = dict["collectionCensoredName"] as? String ?? ""
        new.trackCensoredName = dict["trackCensoredName"] as? String ?? ""
        new.collectionArtistID = dict["collectionArtistId"] as? Int ?? 0
        new.collectionArtistViewURL = dict["collectionArtistName"] as? String ?? ""
        new.artistViewURL = dict["artistViewUrl"] as? String ?? ""
        new.collectionViewURL = dict["collectionViewUrl"] as? String ?? ""
        new.trackViewURL = dict["trackViewUrl"] as? String ?? ""
        new.previewURL = dict["previewUrl"] as? String ?? ""
        new.artworkUrl30 = dict["artworkUrl30"] as? String ?? ""
        new.artworkUrl60 = dict["artworkUrl60"] as? String ?? ""
        new.artworkUrl100 = dict["artworkUrl100"] as? String ?? ""
        new.trackPrice = dict["trackPrice"] as? Double ?? 0
        new.releaseDate = dict["releaseDate"] as? Double ?? 0
        new.collectionExplicitness = dict["artworkUrl100"] as? String ?? ""
        new.trackExplicitness = dict["trackExplicitness"] as? String ?? ""
        new.discCount = dict["discCount"] as? Int ?? 0
        new.discNumber = dict["discNumber"] as? Int ?? 0
        new.trackCount = dict["trackCount"] as? Int ?? 0
        new.trackNumber = dict["trackNumber"] as? Int ?? 0
        new.trackTimeMillis = dict["trackTimeMillis"] as? Int ?? 0
        new.country = dict["country"] as? String ?? ""
        new.currency = dict["currency"] as? String ?? ""
        new.primaryGenreName = dict["primaryGenreName"] as? String ?? ""
        new.isStreamable = dict["isStreamable"] as? Bool ?? false

        return new
    }

    func decodeObject() -> [String: Any] {
        var newObj: [String: Any] = [:]
        newObj["wrapperType"] = wrapperType
        newObj["kind"] = kind
        newObj["artistId"] = artistID
        newObj["collectionId"] = collectionID
        newObj["trackId"] = trackID
        newObj["artistName"] = artistName
        newObj["collectionName"] = collectionName
        newObj["trackName"] = trackName
        newObj["collectionCensoredName"] = collectionCensoredName
        newObj["trackCensoredName"] = trackCensoredName
        newObj["collectionArtistId"] = collectionArtistID
        newObj["artistViewUrl"] = artistViewURL
        newObj["collectionViewUrl"] = collectionViewURL
        newObj["trackViewUrl"] = trackViewURL
        newObj["previewUrl"] = previewURL
        newObj["collectionViewUrl"] = collectionViewURL
        newObj["artworkUrl30"] = artworkUrl30
        newObj["artworkUrl60"] = artworkUrl60
        newObj["artworkUrl100"] = artworkUrl100
        newObj["trackPrice"] = trackPrice
        newObj["releaseDate"] = releaseDate
        newObj["artworkUrl100"] = collectionExplicitness
        newObj["trackExplicitness"] = trackExplicitness
        newObj["discCount"] = discCount
        newObj["discNumber"] = discNumber
        newObj["trackCount"] = trackCount
        newObj["trackNumber"] = trackNumber
        newObj["trackTimeMillis"] = trackTimeMillis
        newObj["country"] = country
        newObj["currency"] = currency
        newObj["primaryGenreName"] = primaryGenreName
        newObj["isStreamable"] = isStreamable

        return newObj
    }
}
