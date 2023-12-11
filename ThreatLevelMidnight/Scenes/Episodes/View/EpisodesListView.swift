//
//  EpisodesListView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 11/12/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct EpisodesListView: View {

    private let coordinator: EpisodesCoordinator!
    @ObservedObject private var viewModel: EpisodesListViewModel

    init(coordinator: EpisodesCoordinator, viewModel: EpisodesListViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        }

        NavigationView {
        ScrollView {
            ForEach( viewModel.episodesViewModel, id: \.self) { viewModel in
                EpisodeView(viewModel: viewModel).onTapGesture {
                    coordinator.coordinateToEpisodeDetails(with: viewModel)
                }
            }
        }.alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.alertMessage))
        }
        }.navigationTitle(Text("\(viewModel.seasonTitle)"))
    }
}
