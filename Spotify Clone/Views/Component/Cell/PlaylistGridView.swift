//
//  PlaylistGridView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI
import Kingfisher

struct PlaylistGridView: View {
    var playlistModel: PlaylistModels

    var body: some View {
        VStack {
            ImageGridView(data: playlistModel)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(playlistModel.playlistName)
                .font(AppFont.bold.with(size: 11))
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
            HStack(spacing: 6) {
                Text("Playlist")
                    .font(AppFont.regular.with(size: 11))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                Image("ic-dot-eclipse")
                    .frame(width: 3, height: 3)
                Text("\(playlistModel.listMusic.count) songs")
                    .font(AppFont.regular.with(size: 11))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                Spacer()
            }
        }
    }
}

struct PlaylistListView: View {
    var playlistModel: PlaylistModels

    var body: some View {
        HStack {
            ImageGridView(data: playlistModel)
                .frame(width: 60, height: 60, alignment: .leading)
            VStack(spacing: 4) {
                Text(playlistModel.playlistName)
                    .font(AppFont.bold.with(size: 11))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                HStack {
                    Text("Playlist")
                        .font(AppFont.regular.with(size: 11))
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                    Image("ic-dot-eclipse")
                        .frame(width: 3, height: 3)
                    Text("\(playlistModel.listMusic.count) songs")
                        .font(AppFont.regular.with(size: 11))
                        .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                    Spacer()
                }
            }
        }
    }
}

struct ImageGridView: View {
    var data: PlaylistModels

    var body: some View {
        VStack(spacing: 0) {
            if data.listMusic.count == 0 {
                Image("placeholder")
                    .resizable()
                    .scaledToFill()
            } else if data.listMusic.count < 4 {
                KFImage(URL(string: data.listMusic[0].artworkUrl100 ?? ""))
                    .resizable()
                    .scaledToFill()
            } else if data.listMusic.count >= 4 {
                HStack(spacing: 0) {
                    KFImage(URL(string: data.listMusic[0].artworkUrl100 ?? ""))
                        .resizable()
                        .scaledToFill()
                    KFImage(URL(string: data.listMusic[1].artworkUrl100 ?? ""))
                        .resizable()
                        .scaledToFill()
                }
                HStack(spacing: 0) {
                    KFImage(URL(string: data.listMusic[2].artworkUrl100 ?? ""))
                        .resizable()
                        .scaledToFill()
                    KFImage(URL(string: data.listMusic[3].artworkUrl100 ?? ""))
                        .resizable()
                        .scaledToFill()
                }
            }
        }
    }
}
