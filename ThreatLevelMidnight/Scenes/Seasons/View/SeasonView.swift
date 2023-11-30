//
//  SeasonView.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

struct SeasonView: View {

    private var viewModel: SeasonViewModel

    init(viewModel: SeasonViewModel) {
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
                HStack {
                    Text(viewModel.seasonTitle)
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0.0, y: 2.0)
                        .padding()

                    Spacer()
                }

                Spacer()
            }
        }.padding()
    }
}
