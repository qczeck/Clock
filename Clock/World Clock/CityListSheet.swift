//
//  CityListSheet.swift
//  Clock
//
//  Created by Maciej Kuczek on 21/12/2021.
//

import SwiftUI

struct CityListSheet: View {
    @State private var searchText = ""
    @EnvironmentObject var store: WorldClockStore
    
    @Environment(\.dismiss) var dismiss
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var searchResults: [String] {
        if searchText == "" {
            return TimeZone.knownTimeZoneIdentifiers
                .sorted {
                    WorldClockStore.displayableTimeZoneIdentifier($0) < WorldClockStore.displayableTimeZoneIdentifier($1)
                }
        } else {
            return TimeZone.knownTimeZoneIdentifiers
                .filter { WorldClockStore.displayableTimeZoneIdentifier($0).contains(searchText) }
                .sorted {
                    WorldClockStore.displayableTimeZoneIdentifier($0) < WorldClockStore.displayableTimeZoneIdentifier($1)
                }
        }
    }
    
    var body: some View {
        VStack {
            Text("Choose a City")
                .font(.footnote)
                .padding(5)
            HStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            List {
                if searchText == "" {
                    ForEach(alphabet, id: \.self) { letter in
                        Section {
                            ForEach(searchResults.filter { searchResult in
                                WorldClockStore.displayableTimeZoneIdentifier(searchResult).prefix(1) == letter
                            }, id: \.self) { timeZoneIdentifier in
                                Text(WorldClockStore.displayableTimeZoneIdentifier(timeZoneIdentifier))
                                    .onTapGesture {
                                        store.add(timeZoneIdentifier)
                                        dismiss()
                                    }
                            }
                        } header: {
                            Text(letter)
                        }
                    }
                } else {
                    ForEach(searchResults, id: \.self) { timeZoneIdentifier in
                        Text(WorldClockStore.displayableTimeZoneIdentifier(timeZoneIdentifier))
                            .onTapGesture {
                                store.add(timeZoneIdentifier)
                                dismiss()
                            }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct CityListSheet_Previews: PreviewProvider {
    static var previews: some View {
        CityListSheet()
            .preferredColorScheme(.dark)
            .environmentObject(WorldClockStore())
    }
}
