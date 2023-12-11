//
//  EpisodeView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 11/12/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct EpisodeView: View {

    private var viewModel: EpisodeViewModel

    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: viewModel.image!), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
            }, placeholder: {
                Image("cover-logo")
                    .resizable()
                    .scaledToFit()
            })

            VStack {
                Spacer()

                HStack {
                    Text(viewModel.episodeTitle)
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0.0, y: 2.0)
                        .padding()

                    Spacer()
                }

            }
        }.padding()
    }
}
