//
//  SearchMusicViewModel.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import Foundation
import Combine
import CoreData

class SearchMusicViewModel: ObservableObject {
    @Published var queryTextSearch: String = ""
    @Published var isLoading: Bool = false
    @Published var arrMusicList: Array<MusicModels> = Array<MusicModels>()
    @Published var recentSearches: Array<MusicModels> = Array<MusicModels>()
    @Published var oldKeyword: String = ""

    var playlistNow: PlaylistModels = PlaylistModels()
    var searchTimer: Timer?
    private var cancellables = Set<AnyCancellable>()
    private let viewContext = PersistenceController.shared.container.viewContext

    private let musicSearchDataProvider : MusicSearchDataProvider
    
    init(dataProvider: MusicSearchDataProvider) {
        self.musicSearchDataProvider = dataProvider
    }

    func getMusicList(_ showLoading: Bool) {
        if showLoading {
            isLoading = true
        }

        musicSearchDataProvider.getMusicList(queryTextSearch)
        musicSearchDataProvider.arrMusicSearchData
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                    // Handle API call failure.
                case .failure(let err):
                    print(err.localizedDescription)
                    //Stop loader as API provided error
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] data in
                if let weakSelf = self {
                    var tempArrMusic: [MusicModels] = []
                    for datum in data {
                        tempArrMusic.append(MusicModels.createObject(datum))
                    }
                    weakSelf.arrMusicList.append(contentsOf: tempArrMusic)
                    weakSelf.isLoading = false
                }
            })
            .store(in: &cancellables)
    }

    func getResetPage() {
        arrMusicList.removeAll()
    }

    func getSearchedMovieFromCoreData() {
        viewContext.perform {
            let fetchRequest: NSFetchRequest<RecentSearch> = RecentSearch.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \RecentSearch.timestamp, ascending: false)]
            do {
                let allRecentSearches = try! self.viewContext.fetch(fetchRequest)
                for data in allRecentSearches {
                    if let music = data.data?.convertToDictionary() as? [String: Any]  {
                        self.recentSearches.append(MusicModels.createObject(music))
                    }
                }
            }
        }
    }

    func updatePlaylist(data: MusicModels) {
        viewContext.perform {
            let fetchRequest: NSFetchRequest<SavedPlaylist> = SavedPlaylist.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SavedPlaylist.timestamp, ascending: false)]
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format:"playlistId == %@", self.playlistNow.id)
            let result = try? self.viewContext.fetch(fetchRequest)
            if result?.count == 1 {
                let dic = result![0]
                if let dict = dic.list, let list = dict.convertToDictionary() as? [String: Any], var listMusic = list["list"] as? [[String: Any]] {
                    listMusic.append(data.decodeObject())
                    let listPlaylist: [String: Any] = ["list": listMusic]
                    dic.setValue(listPlaylist.jsonStringRepresentation ?? "", forKey: "list")
                } else {
                    let temp: [String: Any] = ["list": [
                        data.decodeObject()
                    ]]
                    dic.setValue(temp.jsonStringRepresentation ?? "", forKey: "list")
                }
                dic.setValue(self.playlistNow.listMusic.count + 1, forKey: "total")
                do {
                    try self.viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func saveMusicData(_ data: MusicModels) {
        viewContext.perform {
            let recentSearch = RecentSearch(context: self.viewContext)
            recentSearch.data = data.decodeObject().jsonStringRepresentation ?? ""
            recentSearch.timestamp = Date()
            try! self.viewContext.fetch(RecentSearch.fetchRequest())
        }
    }
}
