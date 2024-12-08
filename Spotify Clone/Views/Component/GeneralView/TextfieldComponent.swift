//
//  TextfieldComponent.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI

struct TextfieldComponent: View {
    @Binding var valueFill: String
    var placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(
                "",
                text: $valueFill,
                prompt: Text(placeholder).foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
            )
                .font(AppFont.regular.with(size: 12))
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .scrollDismissesKeyboard(.automatic)
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
        }
    }
}
