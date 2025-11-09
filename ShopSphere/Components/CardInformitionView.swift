//
//  CardInformitionView.swift
//  ShopSphere
//
//  Created by Feras Hani on 29/03/2024.
//


import SwiftUI
import Firebase

struct CardInformitionView: View {
    @State var cards: [Card] = []
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(cards, id: \.id) { card in
                ZStack {
                    VStack {
                        HStack {
                            Text("cardName:")
                            Spacer()
                            Text("\(card.cardName)")
                        }.padding()
                        
                        HStack {
                            Text("cardNumber:")
                            Spacer()
                            Text("\(card.cardNumber)")
                        }.padding()
                        
                        HStack {
                            Text("date:")
                            Spacer()
                            Text("\(card.date)")
                        }.padding()
                    }
                    .padding()
                }
                .background(Color("Second"))
                .foregroundColor(Color("Prime"))
                .bold()
                .cornerRadius(10)
                .padding(.vertical, 10)
            }
        }
        .onAppear {
            fetchCards()
        }
    }
    
    func fetchCards() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).collection("cards").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.cards = querySnapshot!.documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    let cardNumber = data["cardNumber"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let cardName = data["cardName"] as? String ?? ""
                    let cvv = data["cvv"] as? String ?? ""
                    
                    return Card(id: id, cardNumber: cardNumber, date: date, cardName: cardName, cvv: cvv)
                }
            }
        }
    }
}

struct CardInformition_View: PreviewProvider {
    static var previews: some View {
        CardInformitionView().environmentObject(AuthViewModel())
    }
}
