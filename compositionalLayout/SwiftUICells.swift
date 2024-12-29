//
//  SwiftUICells.swift
//  compositionalLayout
//
//  Created by Yunus Emre Coşkun on 29.12.2024.
//

import UIKit
import SwiftUI

class HostingCollectionViewCell<Content: View>: UICollectionViewCell {
    private var hostingController: UIHostingController<Content>?
    func set(content: Content) {
        if let hostingController = hostingController {
            hostingController.rootView = content
        } else {
            let hostingController = UIHostingController(rootView: content)
            self.hostingController = hostingController
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingController.view)
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
}

struct RegularNewsCellSwiftUI: View {
    var title: String
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
}

struct PopularNewsCellSwiftUI: View {
    var title: String
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 8)
    }
}

struct FeaturedNewsCellSwiftUI: View {
    var title: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(height: 200)
                .cornerRadius(10)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
    }
}
