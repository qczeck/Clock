//
//  StopwatchView.swift
//  Clock
//
//  Created by Maciej Kuczek on 13/12/2021.
//

import SwiftUI

struct StopwatchView: View {
    @EnvironmentObject var manager: StopwatchManager
    
    func lapColor(_ lap: Lap) -> Color {
        if manager.laps.count < 2 {
            return .primary
        } else {
            if lap.isFastest {
                return .green
            } else if lap.isSlowest {
                return .red
            } else {
                return .primary
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            if !manager.timerIsActive {
                                CircularButton("Reset", color: .gray) {
                                    manager.reset()
                                }
                                .padding()
                            } else {
                                CircularButton("Lap", color: .gray) {
                                    manager.lap()
                                }
                                .padding()
                            }
                            Spacer()
                            if !manager.timerIsActive {
                                CircularButton("Start", color: .green) {
                                    manager.start()
                                }
                                .padding()
                            } else {
                                CircularButton("Stop", color: .red) {
                                    manager.pause()
                                }
                                .padding()
                            }
                        }
                    }
                    Text(manager.elapsedTime(seconds: manager.seconds))
                        .fontWeight(.thin)
                        .font(Font.monospacedDigit(Font.system(size: 90))())
                        .offset(x: 0, y: -geometry.size.height/20)
                }
                .frame(height: geometry.size.height/1.6)
                
                if manager.seconds == 0 {
                    Divider()
                }
                
                List {
                    if manager.seconds != 0 {
                        HStack {
                            Text("Lap \(manager.laps.count + 1)")
                            Spacer()
                            Text(manager.elapsedTime(seconds: manager.seconds - manager.lastTimeLapWasPressed))
                                .font(.monospacedDigit(Font.body)())
                        }
                    }
                    ForEach(manager.laps.reversed()) { lap in
                        HStack {
                            Text("Lap \(lap.id)")
                            Spacer()
                            Text(manager.elapsedTime(seconds: lap.time))
                                .font(.monospacedDigit(Font.body)())
                        }
                        .foregroundColor(lapColor(lap))
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
            .environmentObject(StopwatchManager())
            .preferredColorScheme(.dark)
    }
}
