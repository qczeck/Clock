//
//  WhenTimerEndsSheet.swift
//  Clock
//
//  Created by Maciej Kuczek on 17/12/2021.
//

import SwiftUI

struct WhenTimerEndsSheet: View {
    @Binding var tone: String
    @Environment(\.dismiss) var dismiss
    
    let names = ["Radar", "Apex", "Beacon", "Alarm"]
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(names, id: \.self) { name in
                    Button {
                        tone = name
                    } label: {
                        ToneCell(name: name) {
                            if name == tone {
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                }
            }
                .navigationTitle("When Timer Ends")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.orange)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Set")
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        }
                    }
                }
        }
    }
    
    init(_ tone: Binding<String>) {
        self._tone = tone
    }
}

struct ToneCell: View {
    var name: String
    var condition: () -> Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "checkmark")
                .foregroundColor(.orange)
                .opacity(condition() ? 1 : 0)
            Text(name)
                .foregroundColor(.primary)
        }
    }
}

struct WhenTimerEndsSheet_Previews: PreviewProvider {
    static var previews: some View {
        WhenTimerEndsSheet(.constant("Alarm"))
            .preferredColorScheme(.dark)
    }
}
