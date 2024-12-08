//
//  CreatePlaylistNameView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI

struct CreatePlaylistNameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CreatePlaylistNameViewModel

    init(viewModel: CreatePlaylistNameViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color(UIColor(hex: SpotifyColorTheme.grayBackground.rawValue))
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Spacer()
                Text("Name your playlist.")
                    .font(AppFont.extraBold.with(size: 18))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                TextfieldComponent(valueFill: $viewModel.playlistName, placeholder: "Insert your Playlist Name")
                    .padding(.all, 16)
                Text(viewModel.alertTitle)
                    .font(AppFont.extraBold.with(size: 18))
                    .foregroundColor(Color(UIColor.red))
                    .isHidden(remove: !viewModel.showAlert)
                PrimaryButtonComponent(
                    title: "Confirm",
                    onClickButton: {
                        viewModel.onSuccessSubmit = {
                            dismiss()
                        }
                        viewModel.savePlaylistData()
                    }
                )
                Spacer()
            }
        }
        .onTapGesture {
            endEditing()
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }
}

#Preview {
    CreatePlaylistNameView(viewModel: CreatePlaylistNameViewModel())
}
