//
//  UserDetail.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import SwiftUI

struct UserDetailView: View {
    
    @EnvironmentObject private var viewModel: UserViewModel
    var user: User
    
    var body: some View {
        
            ScrollView {

                VStack (alignment: .leading) {
                    
                    VStack {
                        AsyncImage(
                            url: URL(string: user.avatar_url),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 300, maxHeight: 100)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                    
                    Group {
                        HStack {
                            Text("Dane szczegółowe").font(.title)
                        }
                        Divider()
                        
                        HStack {
                            Text("Użytkownik:")
                            Spacer()
                            Text(user.login)
                        }
                        Divider()
                        
                        HStack {
                            Text("Typ konta:")
                            Spacer()
                            Text(user.type)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Poziom konta:")
                            Spacer()
                            Text(user.score)
                        }
                        
                        Divider()
                    }

                    
                    Group {
                        VStack {
                            Text("URL do Repo:")
                        }
                        
                        VStack {
                            Text(user.repos_url).font(.footnote)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("URL firmy:")
                        }
                        
                        VStack {
                            Text(user.organizations_url).font(.footnote)
                        }

                        Divider()
                        
                        VStack {
                            Text("URL konta:")
                        }
                        
                        VStack {
                            Text(user.url).font(.footnote)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(user.login)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: markAsVisited)
    }
    
    func markAsVisited() {
        viewModel.markAsVisited(self.user)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
