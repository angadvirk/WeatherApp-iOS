//
//  SearchBar.swift
//  weather
//
//  Created by Angad Singh Virk on 04/12/21.
//

import SwiftUI

struct SearchBar: View {
    // Variables
    @State var searchVal: String
    @ObservedObject var autocompleteViewModel = AutocompleteViewModel.shared
    // Body
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color.gray)
                TextField("Enter City Name", text: $searchVal)
                    .onChange(of: searchVal) { val in
                        autocompleteViewModel.fetchAutocompleteData(input: val)
                    }
                if (searchVal != "") {
                    // Right-aligned 'X' button to clear SearchBar
                    Button {
                        self.searchVal = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color.gray)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(16)
            .padding(.horizontal, 32)
            Spacer()
        }
        .background(Color(.systemGray3))
        .frame(height: 20)
        .padding(.horizontal)
        .offset(y: 16)
        .zIndex(1)
        // Search Results Box with Autocomplete
        .overlay {
            if ((searchVal != "") && (autocompleteViewModel.autocompleteData != nil)) {
                if (autocompleteViewModel.autocompleteData!.status == "OK") {
                    List {
                        ForEach((0..<4), id: \.self) { index in
                            NavigationLink(destination: ResultsView(
                                searchCity: autocompleteViewModel.autocompleteData!.predictions![index].terms![0].value!,
                                searchState: autocompleteViewModel.autocompleteData!.predictions![index].terms![1].value!
                            )) {
                                Text(autocompleteViewModel.autocompleteData!.predictions![index].terms!.first!.value!)
                            }
                        }
                    }
                    .listStyle(InsetListStyle())
                    .opacity(0.7)
                    .cornerRadius(5)
                    .frame(width: 375, height: 175)
                    .offset(y:133)
                    .padding(.horizontal, 32)
                }
            }
        }
    }
}
