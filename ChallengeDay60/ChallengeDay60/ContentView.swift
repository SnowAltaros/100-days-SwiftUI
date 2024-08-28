//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Stanislav Popovici on 08/07/2024.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(users) { user in
                        NavigationLink {
                            UserView(user: user)
                        } label: {
                            VStack {
                                Text(user.name)
                                
                                HStack {
                                    Text("\(user.age) age")
                                    Spacer()
                                    Text(user.isActive ? "Online" : "Offline")
                                        .font(.headline.bold())
                                }
                                .padding(5)
                            }
                            .padding(5)
                            .foregroundStyle(Color.black)
                            .background(user.isActive ? .green.opacity(0.5) : .red.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(user.isActive ? .green : .red, lineWidth: 3)
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.orange.opacity(0.7))
            .toolbarBackground(Color.orange.opacity(0.8))
        }
        .task {
            if users.isEmpty {
                await loadFile()
            }
        }
    }

    func loadFile() async {
        
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                for user in decodedResponse {
                    modelContext.insert(user)
                }
            }
            
        } catch {
            print("Invalid data")
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
