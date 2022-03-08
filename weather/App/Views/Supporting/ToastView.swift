//
//  ToastView.swift
//  weather
//
//  Created by Angad Singh Virk on 07/12/21.
//

import Highcharts
import SwiftUI
import UIKit

struct ToastIntegratedController: UIViewControllerRepresentable {
    // variables
    var cityName: String
    var removed: Bool
    // makeUIViewController function
    func makeUIViewController(context: Context) -> ToastViewController {
        let tvc = ToastViewController()
        tvc.cityName = cityName
        tvc.removed = removed
        return tvc
    }
    func updateUIViewController(_ uiViewController: ToastViewController, context: Context) {}
}

struct ToastView: View {
    var body: some View {
        EmptyView()
    }
}

class ToastViewController: UIViewController {
    // variables
    var cityName: String = ""
    var removed: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
      }
    override func viewDidAppear(_ animated: Bool) {
        if (removed) {
            removedToast()
        }
        else {
            addedToast()
        }
    }
    private func addedToast() {
        self.view.makeToast("Added " + cityName + " to the Favorites List.")
    }
    private func removedToast() {
        self.view.makeToast("Removed " + cityName + " from the Favorites List.")
    }
}
