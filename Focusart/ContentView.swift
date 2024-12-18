//
//  ContentView.swift
//  timer 23
//
//  Created by Rita Guerriero on 10/12/24.
//

import SwiftUI

struct TestView: View {
    let completeInterval: TimeInterval = 30*60
    @State private var currentInterval: TimeInterval = 30*60
    
    @State private var running = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var text: String {
        let minutes = floor(currentInterval / 60)
        let seconds = floor(currentInterval - minutes*60)
        
        let minutesText = minutes < 10 ? "0"+minutes.formatted() : minutes.formatted()
        let secondsText = seconds < 10 ? "0"+seconds.formatted() : seconds.formatted()
        
        return "\(minutesText):\(secondsText)"
    }
    
    var body: some View {
        VStack {
            ZStack {
                Arc(filled: 1, radius: 150)
                    .stroke(.mint.opacity(0.2), lineWidth: 50)
                
                Arc(filled: currentInterval / completeInterval, radius: 150)
                    .stroke(Color("lightviola"), style: .init(lineWidth: 30, lineCap: .round))
            }
            .overlay {
                
                if(text == "30:00") {
                    Text("Start!")
                        .font(.system(size: 30, design: .rounded))
                        .bold()
                    
                } else {
                    Text(text)
                        .contentTransition(.numericText(countsDown: true))
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }
            
            HStack {
                Button {
                    withAnimation {
                        running.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color("lightviola"))
                            .frame(width: 80   , height: 80)
                        Image(systemName: running ? "pause.fill" : "play.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                            
                    }
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        running = false
                        currentInterval = completeInterval
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color("lightviola"))
                            .frame(width: 80   , height: 80)
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .accessibilityLabel("rewind")
                    }
                }
            }
            
            Spacer()
            
            
                
                switch text {
                
                    
                case "00:00":
                    Text("finished!")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, design: .rounded))
                        
                    
                    
                default:
                    GifImage(name: "pigeonstudy")
                        .frame(width: 500, height: 300)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("animated pigeon")
                    //Text("🐦✏️")
                        //.foregroundStyle(.white)
                        //.font(.system(size: 40, design: .rounded))
                        
                        
                }
        
            
            Spacer()
        }
        .padding(26)
        .onReceive(timer) { _ in
            guard running else { return }
            guard currentInterval > 0 else {
                running = false
                return
            }
            
            withAnimation {
                currentInterval -= 1
            }
        }
        
        
    }
    
}



#Preview {
    TestView()
}

