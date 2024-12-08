//
//  MyPlaylistViewModel.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 08/12/24.
//

import Foundation
import CoreData

enum ViewType {
    case GRID
    case LIST
}

class MyPlaylistViewModel: ObservableObject {
    @Published var arrPlaylistMusic: Array<PlaylistModels> = Array<PlaylistModels>()
    @Published var viewType: ViewType = .GRID
    @Published var playlistModel = PlaylistModels()
    @Published var present = false
    @Published var presentCreatePlaylist: Bool = false
    @Published var detentHeight: CGFloat = 0

    private let viewContext = PersistenceController.shared.container.viewContext

    func getAllPlaylist() {
        let viewContext = PersistenceController.shared.container.viewContext

        viewContext.perform {
            let fetchRequest: NSFetchRequest<SavedPlaylist> = SavedPlaylist.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SavedPlaylist.timestamp, ascending: false)]
            do {
                let allPlaylist = try! self.viewContext.fetch(fetchRequest)
                for playlist in allPlaylist {
                    self.arrPlaylistMusic.append(PlaylistModels.createObject([
                        "playlistName": playlist.playlistName ?? "",
                        "list": playlist.list?.convertToDictionary() as? [String: Any] ?? [:],
                        "id": playlist.playlistId ?? ""
                    ]))
                }
            } catch {
                print("Error deleting existing movies: \(error)")
            }
        }
    }

    func getPlaylistByID(_ playlistId: String) {
        viewContext.perform {
            let fetchRequest: NSFetchRequest<SavedPlaylist> = SavedPlaylist.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format:"playlistId == %@", playlistId)
            let result = try? self.viewContext.fetch(fetchRequest)
            if result?.count == 1 {
                if let object = result?.first {
                    self.playlistModel = PlaylistModels.createObject([
                        "playlistName": object.playlistName ?? "",
                        "list": object.list?.convertToDictionary() as? [String: Any] ?? [:],
                        "id": object.playlistId ?? ""
                    ])
                }
            }
        }
    }

    func changeStyle() {
        if viewType == .GRID {
            viewType = .LIST
        } else {
            viewType = .GRID
        }
    }
}
