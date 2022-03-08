//
//  ToastViewModel.swift
//  weather
//
//  Created by Angad Singh Virk on 09/12/21.
//

import Foundation

@MainActor
class ToastViewModel: ObservableObject {
    // Properties
    @Published var toastCity: String? = ""
    @Published var showToast_a: Bool = false
    static let shared = ToastViewModel()
    
    init() {
    }
    
    func showToast(toastCity: String) {
        self.toastCity = toastCity
        if (self.showToast_a == false) {
            self.showToast_a = true
        }
        else if (self.showToast_a == true) {
            self.showToast_a = false
        }
    }
    
    //func clearToast() {
    //    self.toastCity = ""
    //}
}
