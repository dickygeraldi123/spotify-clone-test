//
//  HeaderComponent.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 06/12/24.
//

import SwiftUI

struct HeaderComponent<LeftView: View, RightView: View>: View {
    var titleText: String = ""
    var onClickLeftButton: (() -> Void)?
    var onClickRightButton: (() -> Void)?
    var leftView: LeftView
    var rightView: RightView

    init(
        titleText: String = "",
        onClickLeftButton: (() -> Void)? = nil,
        onClickRightButton: (() -> Void)? = nil,
        @ViewBuilder leftView: () -> LeftView = { EmptyView() },
        @ViewBuilder rightView: () -> RightView = { EmptyView() }
    ) {
        self.titleText = titleText
        self.onClickLeftButton = onClickLeftButton
        self.onClickRightButton = onClickRightButton
        self.leftView = leftView()
        self.rightView = rightView()
    }

    var body: some View {
        HStack(spacing: 12) {
            if onClickLeftButton != nil {
                Button(action: {
                    onClickLeftButton?()
                }) {
                    leftView
                }
            }
            Text(titleText)
                .font(AppFont.bold.with(size: 14))
                .foregroundColor(Color(UIColor(hex: SpotifyColorTheme.whiteColor.rawValue)))
            Spacer()
            if onClickRightButton != nil {
                Button(action: {
                    onClickRightButton?()
                }) {
                    rightView
                }
            }
        }
        .padding(.bottom, 16)
    }
}
