//
//  CreatePlaylistNameViewModel.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 08/12/24.
//

import Foundation
import Combine
import CoreData
import UIKit

class CreatePlaylistNameViewModel: ObservableObject {
    @Published var playlistName: String = ""
    @Published var showAlert = false

    var alertTitle = ""
    var onSuccessSubmit: (() -> Void)?
    private let viewContext = PersistenceController.shared.container.viewContext

    func savePlaylistData() {
        if !playlistName.isEmpty {
            if isPlaylistExist(playlistName) {
                do {
                    let newSearch = SavedPlaylist(context: viewContext)
                    newSearch.timestamp = Date()
                    newSearch.playlistName = playlistName
                    newSearch.list = ""
                    newSearch.total = 0
                    newSearch.playlistId = randomString(length: 6)

                    try viewContext.save()
                    onSuccessSubmit?()
                } catch {
                    // Handle the error
                    print("Error saving search: \(error)")
                }
            } else {
                alertTitle = "Opps, \(playlistName) has been created"

                showAlert = true
            }
        } else {
            alertTitle = "You must insert playlist name first"

            showAlert = true
        }
    }

    func isPlaylistExist(_ playlistName: String) -> Bool {
        let fetchRequest: NSFetchRequest<SavedPlaylist> = SavedPlaylist.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"playlistName == %@", playlistName)
        let result = try? self.viewContext.fetch(fetchRequest)
        if result?.count == 1 {
            return false
        } else {
            return true
        }
    }
}
