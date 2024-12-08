//
//  MusicSearchView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI

struct MusicSearchView: View {
    @StateObject private var viewModel: SearchMusicViewModel
    init(viewModel: SearchMusicViewModel, playlistNow: PlaylistModels) {
        viewModel.playlistNow = playlistNow
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(UIColor(hex: SpotifyColorTheme.primaryColor.rawValue))
                .edgesIgnoringSafeArea(.all)
            VStack {
                setTextfieldArea()

                ScrollView {
                    VStack {
                        //For displaying data from API call
                        if viewModel.arrMusicList.count > 0 {
                            ScrollView(.vertical, showsIndicators: false) {
                                if viewModel.isLoading {
                                    showLoadingState()
                                } else {
                                    ForEach(viewModel.arrMusicList, id: \.self) { music in
                                        PlaylistView(data: music, isShouldRounded: true)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 6)
                                            .onTapGesture {
                                                viewModel.updatePlaylist(data: music)
                                                viewModel.saveMusicData(music)
                                                dismiss()
                                            }
                                    }
                                }
                            }
                        } else {
                            //For displaying Recently Searched movies from coredata
                            if viewModel.recentSearches.count > 0 {
                                Text("Recent searches")
                                    .font(AppFont.extraBold.with(size: 17))
                                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 16)
                                ForEach(viewModel.recentSearches, id: \.self) { data in
                                    PlaylistView(data: data, isShouldRounded: true)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                }
                            } else {
                                setEmptyView(
                                    lottieName: "noData",
                                    titleStr: "Opps, you don't have any recent data",
                                    subtitleStr: "You can type your search and click any music you want"
                                )
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .searchable(text: $viewModel.queryTextSearch)
        .onSubmit(of: .search, {
            viewModel.getMusicList(true)
        })
        .onChange(of: viewModel.queryTextSearch, perform: { newValue in
            if newValue.isEmpty {
                self.viewModel.arrMusicList = []
            } else {
                self.viewModel.arrMusicList = []
                self.viewModel.getMusicList(true)
            }
        })
        .onAppear {
            viewModel.getSearchedMovieFromCoreData()
        }
    }

    @ViewBuilder func setTextfieldArea() -> some View {
        HStack {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(UIColor(hex: "282828")), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color.black))

                HStack(spacing: 8) {
                    Image("ic-search-textfield")
                        .resizable()
                        .frame(width: 16, height: 16)
                    TextField("",
                              text: $viewModel.queryTextSearch,
                              prompt: Text("Search Any music or Artiest").foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue).withAlphaComponent(0.70)))
                    )
                    .onChange(of: viewModel.queryTextSearch) { newValue in
                        if newValue.count > 2 {
                            if viewModel.oldKeyword == newValue {
                                viewModel.searchTimer?.invalidate()
                                viewModel.searchTimer = nil
    
                                return
                            }
                            viewModel.searchTimer?.invalidate()
                            viewModel.searchTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
                                viewModel.getMusicList(true)
                            })
    
                            viewModel.oldKeyword = newValue
                        } else if newValue.count == 0 {
                            viewModel.oldKeyword = newValue
                        }
                    }
                    .font(AppFont.regular.with(size: 14))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .scrollDismissesKeyboard(.automatic)
                }
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            }
            .padding(.all, 12)
            .frame(height: 48)
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
                    .font(AppFont.regular.with(size: 14))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
            })
        }
    }

    @ViewBuilder private func setEmptyView(lottieName: String, titleStr: String, subtitleStr: String) -> some View {
        EmptyStateView(
            lottifFile: lottieName,
            titleStr: titleStr,
            subtitleStr: subtitleStr
        )
    }

    @ViewBuilder private func showLoadingState() -> some View {
        ForEach(1..<15) { _ in
            HStack(spacing: 16) {
                ShimmerBox()
                    .frame(width: 48, height: 48)
                    .cornerRadius(24)
                VStack(alignment: .leading, spacing: 2) {
                    ShimmerBox()
                        .frame(width: 200, height: 17)
                        .cornerRadius(12)
                    ShimmerBox()
                        .frame(width: 100, height: 15)
                        .cornerRadius(12)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
        }
    }
}
