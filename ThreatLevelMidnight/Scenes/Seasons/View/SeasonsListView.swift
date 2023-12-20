//
//  SeasonsListView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct SeasonsListView: View {

    private let coordinator: SeasonsCoordinator!
    @ObservedObject private var viewModel: SeasonsListViewModel

    init(coordinator: SeasonsCoordinator, viewModel: SeasonsListViewModel) {
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
                ForEach( viewModel.seasonsViewModel, id: \.self) { viewModel in
                    SeasonView(viewModel: viewModel).onTapGesture {
                        coordinator.coordinateToEpisodesList(with: viewModel)
                    }
                }.onAppear {
                    viewModel.start()
                }
            }.alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(viewModel.alertMessage))
            }
        }.navigationTitle(viewModel.title)
    }
}
