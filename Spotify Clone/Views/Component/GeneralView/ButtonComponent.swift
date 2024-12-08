//
//  ButtonComponent.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI

struct PrimaryButtonComponent: View {
    var title: String = ""
    var onClickButton: (() -> Void)?

    var body: some View {
        Button {
            onClickButton?()
        } label: {
            Text(title)
                .font(AppFont.extraBold.with(size: 20))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.primaryColor.rawValue)))
                .background(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                    .fill(Color(UIColor(hex: SpotifyColorTheme.primaryGreen.rawValue)))
                )
        }
    }
}
