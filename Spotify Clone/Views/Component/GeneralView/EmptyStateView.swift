//
//  EmptyStateView.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import SwiftUI
import Lottie

struct EmptyStateView: View {
    var lottifFile: String = ""
    var titleStr: String = ""
    var subtitleStr: String = ""

    public init(lottifFile: String, titleStr: String, subtitleStr: String) {
        self.lottifFile = lottifFile
        self.titleStr = titleStr
        self.subtitleStr = subtitleStr
    }

    public var body: some View {
        VStack {
            VStack(spacing: 12) {
                LottieView(animation: .named(lottifFile))
                  .playing(loopMode: .loop)
                  .frame(width: 300, height: 300)
                Text(titleStr)
                    .font(AppFont.bold.with(size: 20))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 16)
                Text(subtitleStr)
                    .font(AppFont.regular.with(size: 16))
                    .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 16)
            }
            Spacer()
        }
    }
}
