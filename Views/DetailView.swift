//
//  DetailView.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/5/25.
//
import SwiftUI

struct DetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.media.m)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .scaledToFit()
            .frame(height: 300)
            .accessibilityLabel("Image of \(photo.title)")

            Text(photo.title)
                .font(.headline)
                .padding(.top, 5)
                .accessibilityLabel("Image Title is \(photo.title)")

            Text(photo.author)
                .font(.subheadline)
                .foregroundColor(.gray)
                .accessibilityLabel("Image author is \(photo.author)")

            Text(photo.description)
                .font(.body)
                .padding()

            Text("Published: \(formattedDate(from: photo.published))")
                .font(.footnote)
                .foregroundColor(.gray)
                .accessibilityLabel("This images was published on \(formattedDate(from: photo.published))")
        }
        .padding()
        .navigationTitle("Image Details")
    }

    private func formattedDate(from dateString: String) -> String {
        let format = ISO8601DateFormatter()
        if let date = format.date(from: dateString) {
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = .medium
            return dateFormater.string(from: date)
        }
        return dateString
    }
}
