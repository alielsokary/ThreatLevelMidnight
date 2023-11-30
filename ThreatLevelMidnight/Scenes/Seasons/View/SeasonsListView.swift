//
//  SeasonsListView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct SeasonsListView: View {

    @ObservedObject private var viewModel: SeasonsListViewModel

    init(viewModel: SeasonsListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            ForEach( viewModel.seasonsViewModel, id: \.self) { viewModel in
                SeasonView(viewModel: viewModel)
            }.onAppear {
                viewModel.start()
            }
        }

    }
}
