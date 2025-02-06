//
//  MainView.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/5/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = FlickrViewModel(apiManager: APIManager())
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search images...", text: $searchText, onEditingChanged: { _ in
                    viewModel.fetchImages(for:APIEndPoint.getAPIEndPoint(searchText: searchText))
                })
                .accessibilityLabel("Type to search for Images")
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                        ForEach(viewModel.photos) { photo in
                            NavigationLink(destination: DetailView(photo: photo)) {
                                AsyncImage(url: URL(string: photo.media.m)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .scaledToFit()
                                .frame(height: 100)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search Images")
        }
    }
}
