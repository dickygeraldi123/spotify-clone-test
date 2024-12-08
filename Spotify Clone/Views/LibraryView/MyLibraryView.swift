//
//  MyLibraryView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI

struct MyLibraryView: View {
    @StateObject private var viewModel: MyPlaylistViewModel
    init(viewModel: MyPlaylistViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    HeaderComponent(
                        titleText: "Your Library",
                        onClickLeftButton: {
                            // TODO: - User Profile Clicked
                        },
                        onClickRightButton: {},
                        leftView: setProfileUser,
                        rightView: setRightView
                    )
                    createPlaylistView()
                    createButtonChangeStyle()

                    ScrollView {
                        if viewModel.viewType == .GRID {
                            setGridView()
                        } else {
                            setListView()
                        }
                    }
                    .refreshable {
                        viewModel.arrPlaylistMusic.removeAll()
                        viewModel.getAllPlaylist()
                    }

                    Spacer()
                }
                .padding(.all, 16)
            }
        }
        .sheet(isPresented: $viewModel.presentCreatePlaylist) {
            CreatePlaylistNameView(viewModel: CreatePlaylistNameViewModel())
        }
        .onAppear {
            viewModel.arrPlaylistMusic.removeAll()
            viewModel.getAllPlaylist()
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }

    @ViewBuilder private func setProfileUser() -> some View {
        Image("photo-profile")
            .resizable()
            .scaledToFill()
            .frame(width: 34, height: 34)
            .cornerRadius(17)
    }

    @ViewBuilder private func setRightView() -> some View {
        Image("ic-add")
            .resizable()
            .scaledToFill()
            .frame(width: 26, height: 26)
            .onTapGesture {
                viewModel.present = true
            }
            .sheet(isPresented: $viewModel.present) {
                bottomView()
                    .background(Color(UIColor(hex: "333333")))
                    .readHeight()
                    .onPreferenceChange(HeightPreferenceKey.self) { height in
                        if let height {
                            viewModel.detentHeight = height
                        }
                    }
                    .presentationDetents([.height(viewModel.detentHeight)])
                    .presentationDragIndicator(.visible)
            }
    }

    @ViewBuilder private func createPlaylistView() -> some View {
        CircleWithTextView(text: "Playlist")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 6)
    }

    @ViewBuilder private func createButtonChangeStyle() -> some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.changeStyle()
            }) {
                Image(viewModel.viewType == .GRID ? "ic-grid" : "ic-list")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
            }
            .padding(.bottom, 4)
        }
    }

    @ViewBuilder private func setGridView() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(viewModel.arrPlaylistMusic, id: \.playlistName) { data in
                    NavigationLink(
                        destination: ListLibraryView(viewModel: MyPlaylistViewModel(), playlistId: data.id)
                    ) {
                        PlaylistGridView(playlistModel: data)
                    }
                }
            }
        }
    }

    @ViewBuilder private func setListView() -> some View {
        ForEach(viewModel.arrPlaylistMusic, id: \.playlistName) { data in
            NavigationLink(
                destination: ListLibraryView(viewModel: MyPlaylistViewModel(), playlistId: data.id)
            ) {
                PlaylistListView(playlistModel: data)
                    .padding(.vertical, 8)
            }
        }
    }

    @ViewBuilder private func bottomView() -> some View {
        HStack(spacing: 12) {
            VStack(spacing: 6) {
                Image("ic-music-playlist")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                Text("Playlist")
                    .font(AppFont.regular.with(size: 12))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.80)))
            }
            VStack {
                Text("Playlist")
                    .font(AppFont.extraBold.with(size: 20))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Create a playlist with a song")
                    .font(AppFont.regular.with(size: 14))
                    .foregroundColor(Color(UIColor(hex: "A9A9A9")))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .onTapGesture {
            viewModel.present = false
            viewModel.presentCreatePlaylist = true
        }
    }
}
