//
//  MusicSearchDataProvider.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import Foundation
import Combine

class MusicSearchDataProvider {
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()

    var arrMusicSearchData = PassthroughSubject<[[String: Any]], Never>()
    
    func getMusicList(_ searchText: String) {
        guard let encodedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let url = NetworkURL.getMusicSearch(query: encodedString).url
        let model = NetworkManager.NetworkModel(url: url, method: .get)
        networkManager.callAPI(with: model)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] musicList in
                if let weakSelf = self, let list = musicList["results"] as? [[String: Any]] {
                    weakSelf.arrMusicSearchData.send(list)
                }
            }).store(in: &self.cancellables)
    }
    
    
}
