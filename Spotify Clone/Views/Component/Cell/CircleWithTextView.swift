//
//  CircleWithTextView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI

struct CircleWithTextView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(AppFont.regular.with(size: 12))
            .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(UIColor(hex: SpotifyColorTheme.borderGray.rawValue)), lineWidth: 1)
            )
    }
}
