//
//  PlaylistView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI
import Kingfisher

struct PlaylistView: View {
    var data: MusicModels
    var isShouldRounded: Bool

    var body: some View {
        HStack(spacing: 8) {
            KFImage(URL(string: data.artworkUrl100 ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 56, height: 56)
                .cornerRadius(isShouldRounded ? 28 : 0)
            VStack(spacing: 8) {
                Text(data.trackName ?? "")
                    .font(AppFont.bold.with(size: 14))
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(data.artistName ?? "")
                    .font(AppFont.regular.with(size: 11))
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button(action: {
                // do actions
            }) {
                Image("ic-more")
                    .resizable()
                    .frame(width: 3, height: 18)
            }
            .onAppear {
                
            }
            .isHidden(remove: isShouldRounded)
        }
        .background(Color(UIColor(hex: SpotifyColorTheme.primaryColor.rawValue)))
    }
}
