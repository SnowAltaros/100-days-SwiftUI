//
//  UserView.swift
//  ChallengeDay60
//
//  Created by Stanislav Popovici on 08/07/2024.
//

import SwiftData
import SwiftUI

struct UserView: View {
    
    var user: User
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("About") {
                    Text("Age: \(user.age)")
                    Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
                    Text(user.about)
                }
                .listRowBackground(Color.teal.opacity(0.6))
                
                Section("Contacts") {
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                }
                .listRowBackground(Color.teal.opacity(0.6))
                
                Section("\(user.tags.count) Tags") {
                    ForEach(user.tags, id: \.self) {
                        Text($0)
                    }
                }
                .listRowBackground(Color.teal.opacity(0.6))
                
                Section("\(user.friends.count) Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                .listRowBackground(Color.teal.opacity(0.6))
            }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Text(user.isActive ? "Online" : "Offline")
                    .foregroundStyle(user.isActive ? .green : .red)
            }
            .foregroundStyle(Color.purple)
            .background(Color.orange.opacity(0.7))
            .scrollContentBackground(.hidden)
            .toolbarBackground(Color.orange.opacity(0.8))
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(id: UUID(), isActive: true, name: "TestName", age: 10, company: "TestComapny", email: "TestEmail", address: "TestAddress", about: "TestAbout", registered: .now, tags: [], friends: [])
        return UserView(user: user)
    } catch {
        return Text("Failed to crreate container: \(error.localizedDescription)")
    }
}
