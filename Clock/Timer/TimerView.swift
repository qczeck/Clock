//
//  TimerView.swift
//  Clock
//
//  Created by Maciej Kuczek on 17/12/2021.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var manager: TimerManager
    
    @State private var tone = "Alarm"
    @State private var showingSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    if manager.hasStarted {
                        ZStack {
                            CountdownCircle(degrees: manager.degrees ?? 0)
                                .frame(width: geometry.size.width/1.25, height: geometry.size.width/1.25)
                            VStack {
                                Text(manager.displayTime())
                                    .font(Font.monospacedDigit(Font.system(size: 70))())
                                    .fontWeight(.thin)
                                if let endTime = manager.endDate {
                                    HStack {
                                        Image(systemName: "bell.fill")
                                        Text(endTime)
                                    }
                                    .foregroundColor(.gray)
                                    .opacity(manager.isPaused ? 0.5 : 1)
                                }
                            }
                        }
                        .offset(y: geometry.size.height/20)
                    } else {
                        PickerView(data: manager.pickerData, selections: $manager.time)
                            .offset(y: geometry.size.height/20)
//                            .frame(width: geometry.size.width/1.2, height: geometry.size.width/1.2)
                    }
                    Spacer()
                    HStack {
                        CircularButton("Cancel", color: .gray) {
                            manager.cancel()
                        }
                        .padding()
                        Spacer()
                        if !manager.hasStarted {
                            CircularButton("Start", color: .green) {
                                manager.start()
                            }
                            .padding()
                        } else if !manager.isPaused {
                            CircularButton("Pause", color: .orange) {
                                manager.pause()
                            }
                            .padding()
                        } else {
                            CircularButton("Resume", color: .green) {
                                manager.resume()
                            }
                            .padding()
                        }
                    }
                }
                .frame(height: geometry.size.height/1.6)

                Button {
                    showingSheet = true
                } label: {
                    HStack {
                        Text("When Timer Ends")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(tone)
                            .foregroundColor(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                            .opacity(0.7)
                            .font(.caption)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                    .foregroundColor(.secondary)
                                    .opacity(0.2))
                }
                .sheet(isPresented: $showingSheet) {
                    WhenTimerEndsSheet($tone)
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimerManager())
            .preferredColorScheme(.dark)
    }
}
