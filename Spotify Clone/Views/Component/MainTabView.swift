//
//  MainTabView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI

struct MainTabView: View {
    let persistenceController = PersistenceController.shared

    var body: some View {
        NavigationStack {
            TabView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    Text("Home")
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                }
                .tabItem {
                    Label("Home", image: "ic-home")
                        .font(AppFont.regular.with(size: 11))
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                }
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    Text("Search")
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                }
                .tabItem {
                    Label("Search", image: "ic-search")
                        .font(AppFont.regular.with(size: 11))
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                }
                MyLibraryView(viewModel: MyPlaylistViewModel())
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Your Library", image: "ic-playlist")
                            .font(AppFont.regular.with(size: 11))
                            .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    }
            }
        }
    }
}

#Preview {
    MainTabView()
}
