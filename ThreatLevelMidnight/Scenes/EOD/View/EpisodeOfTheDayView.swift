//
//  EpisodeOfTheDayView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 21/12/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct EpisodeOfTheDayView: View {

    private let coordinator: EpisodeOfTheDayCoordinator!
    @ObservedObject private var viewModel: EpisodeOfTheDayViewModel

    init(coordinator: EpisodeOfTheDayCoordinator, viewModel: EpisodeOfTheDayViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            ZStack {
                AsyncImage(url: URL(string: viewModel.episodeImage), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                }, placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
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
        }.onTapGesture {
            coordinator.navigateToEpisodeDetails(episodeViewModel: viewModel.episodeViewModel)
        }
    }
}
