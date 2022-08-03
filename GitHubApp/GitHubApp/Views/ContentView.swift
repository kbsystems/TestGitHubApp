//
//  ContentView.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: UserViewModel
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertSheet = false
    
    var filteredUsers: [User] {
        viewModel.users.filter { user in
            (user.toShow == true)
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Text("Wyszukaj użytkownika")
                    .navigationTitle("GitHub")
                
                TextField("Wybierz użytkownika", text: Binding<String>(
                    get: {self.viewModel.user},
                    set: {self.viewModel.user = $0})
                )
                .padding(10)
                .border(.gray, width: 1)
                    
                VStack(alignment: .center) {
                    Button(action: getUsers) {
                        Text("Szukaj")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                ForEach(filteredUsers) { user in

                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        UserRowView(user: user)
                    }
                }
            }
        }
        .alert(ErrorMessages.shared.alertTitle, isPresented: $showAlertSheet, actions: {
            Button("OK") {
                self.showAlertSheet = false
            }
        }, message: {
            Text(ErrorMessages.shared.alertBody)
        })
    }
    
    private func getUsers() {
        
        if monitor.isConnected {
            self.viewModel.getUsers() { success in
                self.showAlertSheet = false
            } onFailure: { failure in
                ErrorMessages.shared.checkErrorCode(.paramNotFound)
                self.showAlertSheet = true
            }
        } else {
            ErrorMessages.shared.checkErrorCode(.connectionError)
            self.showAlertSheet = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserViewModel())
    }
}
