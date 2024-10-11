//
//  WorldClockView.swift
//  Clock
//
//  Created by Maciej Kuczek on 20/12/2021.
//

import SwiftUI

struct WorldClockView: View {
    @EnvironmentObject var store: WorldClockStore
    
    @State private var showingSheet = false
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.timeZoneIdentifiers, id: \.self) { timeZoneIdentifier in
                    WorldClockCellView(timeZoneIdentifier) {
                        editMode == .active
                    }
                }
                .onMove(perform: store.move)
                .onDelete { offsets in
                    store.delete(at: offsets)
                }
                .animation(nil, value: editMode)
            }
            .listStyle(.plain)
            .navigationTitle("World Clock")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .foregroundColor(.orange)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $showingSheet) {
                CityListSheet()
            }
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
            .environmentObject(WorldClockStore())
            .preferredColorScheme(.dark)
    }
}
