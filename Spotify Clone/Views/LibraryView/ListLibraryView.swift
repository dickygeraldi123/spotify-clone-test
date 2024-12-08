//
//  ListLibraryView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI

struct ListLibraryView: View {
    @StateObject private var viewModel: MyPlaylistViewModel
    @Environment(\.dismiss) var dismiss
    @State private var headerOpacity: Double = 1.0
    var playlistId: String = ""

    init(viewModel: MyPlaylistViewModel, playlistId: String) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.playlistId = playlistId
    }

    var body: some View {
        ZStack {
            Color(UIColor(hex: SpotifyColorTheme.primaryColor.rawValue))
                .edgesIgnoringSafeArea(.all)

            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .opacity(headerOpacity)
                .edgesIgnoringSafeArea(.top)

                VStack {
                    HeaderComponent(
                        titleText: headerOpacity < 0.45 ? viewModel.playlistModel.playlistName : "",
                        onClickLeftButton: {
                            dismiss()
                        },
                        onClickRightButton: { print("Right button clicked") },
                        leftView: setLeftView,
                        rightView: setRightView
                    )

                    ScrollView {
                        VStack {
                            setHeaderInformation()
                                .padding(.top, 75)
                            setListPlaylist()
                                .padding(.vertical, 16)
                            Spacer()
                        }
                        .background(GeometryReader { proxy in
                            Color.clear
                                .onChange(of: proxy.frame(in: .global).minY) { newOffset in
                                    updateHeaderOpacity(scrollOffset: newOffset)
                                }
                        })
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getPlaylistByID(playlistId)
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }

    private func updateHeaderOpacity(scrollOffset: CGFloat) {
        withAnimation(.easeInOut) {
            if scrollOffset > 0 {
                headerOpacity = 1.0
            } else {
                headerOpacity = max(0.0, 1.0 + (scrollOffset / 150))
            }
        }
    }

    @ViewBuilder private func setLeftView() -> some View {
        Image("ic-back")
            .resizable()
            .scaledToFill()
            .frame(width: 20, height: 14)
    }

    @ViewBuilder private func setRightView() -> some View {
        NavigationLink(
            destination: MusicSearchView(viewModel: SearchMusicViewModel(dataProvider: MusicSearchDataProvider()), playlistNow: viewModel.playlistModel)
        ) {
            Image("ic-add")
                .resizable()
                .scaledToFill()
                .frame(width: 26, height: 26)
        }
    }

    @ViewBuilder private func setHeaderInformation() -> some View {
        VStack(spacing: 12) {
            Text(viewModel.playlistModel.playlistName)
                .font(AppFont.bold.with(size: 19))
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.playlistModel.listMusic.count) songs")
                .font(AppFont.regular.with(size: 12))
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder private func setListPlaylist() -> some View {
        ForEach(viewModel.playlistModel.listMusic, id: \.trackID) { music in
            PlaylistView(data: music, isShouldRounded: false)
        }
    }
}
