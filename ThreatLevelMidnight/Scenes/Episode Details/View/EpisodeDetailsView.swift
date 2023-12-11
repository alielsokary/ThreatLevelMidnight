//
//  EpisodeDetailsView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 11/12/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct EpisodeDetailsView: View {

    private let coordinator: EpisodeDetailsCoordinator!
    @ObservedObject private var viewModel: EpisodeDetailsViewModel

    init(coordinator: EpisodeDetailsCoordinator!, viewModel: EpisodeDetailsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        }

        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.episodeImage!), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }, placeholder: {
                    Image("cover-logo")
                        .resizable()
                        .scaledToFit()
                })

                VStack(alignment: .leading, spacing: 8.0) {
                    Text(viewModel.episodeTitle!)
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundStyle(.black)
                        .padding(.leading)
                        .padding(.trailing)

                    Text(viewModel.episodeOverView!)
                        .bold()
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.black)
                        .padding(.leading)
                        .padding(.trailing)
                }

            }

        }
    }
}
