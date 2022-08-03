//
//  UserRowView.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import SwiftUI

struct UserRowView: View {
    
    let user: User
    
    var body: some View {
    
        HStack(spacing: 8) {
            VStack (alignment: .leading) {
                Text(user.login)
                Spacer()
                if user.visited {
                    Text("odwiedzono").font(.footnote).foregroundColor(Color.orange)
                }
            }

            Spacer()
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User())
    }
}
