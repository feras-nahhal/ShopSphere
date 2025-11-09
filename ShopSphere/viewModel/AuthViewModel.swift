//
//  AuthViewModel.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 26/01/2024.
//
import FirebaseAuth
import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
      }
    
      func signIn(withEmail email: String, password: String) async throws {
          do {
              let result = try await Auth.auth().signIn(withEmail: email, password: password)
              self.userSession = result.user
              await fetchUser()
                 } catch {
                     // Handle user creation error
                     print("DEBUG :User signIn error: \(error.localizedDescription)")
                 }
      }
    
    func createUser(withEmail email: String, password: String, fullname: String, phoneNumber: String) async throws {
          do {
              let result = try await Auth.auth().createUser(withEmail: email, password: password)
              self.userSession = result.user

              let user = User(id: result.user.uid, fullName: fullname, email: email, phoneNumber: phoneNumber)
              let encoderUser = try Firestore.Encoder().encode(user)
              try await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)

              await fetchUser()
          } catch {
              // Handle user creation error
              print("DEBUG: User creation error: \(error.localizedDescription)")
              throw error
          }
      }
    
    func addLocationForUser(street: String, building: String, floor: String, governorate: String, apartment: String, city: String, latitude: Double, longitude: Double) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            // Create a reference to the user's document in the 'users' collection
            let userRef = Firestore.firestore().collection("users").document(uid)
            
            // Create a reference to the 'locations' collection under the user's document
            let locationsRef = userRef.collection("locations")
            
            // Add a new document with the provided street and building information
            let location = Location(id: uid, street: street, building: building, floor: floor, governorate: governorate, apartment: apartment, city: city, latitude: latitude, longitude: longitude)
            let newLocationDocument = locationsRef.document()
            let encoderLocation = try Firestore.Encoder().encode(location)
                   try await newLocationDocument.setData(encoderLocation)
            
            print("Location added successfully.")
            
            await fetchUser()
        } catch {
            print("Error adding location:", error.localizedDescription)
            throw error
        }
    }
    
    func addCardorUser(cardNumber: String,date: String,cardName: String,cvv: String) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            // Create a reference to the user's document in the 'users' collection
            let userRef = Firestore.firestore().collection("users").document(uid)
            
            // Create a reference to the 'locations' collection under the user's document
            let locationsRef = userRef.collection("cards")
            
            // Add a new document with the provided street and building information
            let card = Card(id: uid, cardNumber: cardNumber, date: date, cardName: cardName, cvv: cvv)
            let newLocationDocument = locationsRef.document()
            let encoderCard = try Firestore.Encoder().encode(card)
                   try await newLocationDocument.setData(encoderCard)
            
            print("card added successfully.")
            
            await fetchUser()
        } catch {
            print("Error adding cards:", error.localizedDescription)
            throw error
        }
    }
    
   
      func signOut() {
          do {
              try Auth.auth().signOut() //sinout in back end
              self.userSession = nil // remove the user from the app
              self.currentUser = nil
        
                 } catch {
                     // Handle user creation error
                     print("DEBUG : User signOut error  \(error.localizedDescription)")
                 }
      }
    
      func deleteAccount() {
          if let user = Auth.auth().currentUser {
                  user.delete { error in
                      if let error = error {
                          // Handle the error
                          print("DEBUG: User deletion error - \(error.localizedDescription)")
                      } else {
                          // User deleted successfully
                          self.userSession = nil // Remove the user from the app
                          self.currentUser = nil
                      }
                  }
              }
      }
    
      func fetchUser() async{
          do {
              guard let uid = Auth.auth().currentUser?.uid else {return}
              guard let snapshot = try? await  Firestore.firestore().collection("users").document(uid).getDocument() else {return}
              self.currentUser = try? snapshot.data(as: User.self)
              print("DEBUG: CURRUNT USER is:\(self.currentUser)")
                 } catch {
                     print("DEBUG :User fetch error: \(error.localizedDescription)")
                 }
          
      }
    
    func updateUserName(newName: String) async throws {
           do {
               guard let uid = Auth.auth().currentUser?.uid else {
                   return
               }

               // Create a reference to the user's document in the Firestore 'users' collection
               let userRef = Firestore.firestore().collection("users").document(uid)

               // Update only the 'fullName' field with the new name
               try await userRef.updateData([
                   "fullName": newName
               ])

               await fetchUser()
           } catch {
               print("DEBUG: User name update error: \(error.localizedDescription)")
               throw error
           }
       }
  
   
    
    func resetPassword(forEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Password reset error: \(error.localizedDescription)")
            throw error
        }
    }
    
    // AuthViewModel.swift

    func updatePassword() async throws {
        guard let userEmail = Auth.auth().currentUser?.email else {
            throw AuthError.noCurrentUser
        }

        do {
            try await Auth.auth().sendPasswordReset(withEmail: userEmail)
        } catch {
            print("DEBUG: Password reset error - \(error.localizedDescription)")
            throw error
        }
    }

   
 

    func updatePhoneNumber(phoneNumber: String) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                // Handle the case where the user is not signed in
                return
            }

            // Create a reference to the user's document in the Firestore 'users' collection
            let userRef = Firestore.firestore().collection("users").document(uid)

            // Update the 'phoneNumber' field with the new phone number
            try await userRef.updateData([
                
                "phoneNumber": phoneNumber
                
            ])

            // Update the local currentUser object if needed
            await fetchUser()
        } catch {
            print("DEBUG: Phone number update error: \(error.localizedDescription)")
            throw error
        }
    }

    
    
    
    
    
          
    
    
    
    
    
    
    
    
    //add latter for sign in using phone number 
    func signInWithEmailOrPhone(emailOrPhone: String, password: String) async throws {
           if emailOrPhone.contains("@") {
               // Login with email
               try await signIn(withEmail: emailOrPhone, password: password)
           } else {
               // Login with phone number
               try await signInWithPhone(phoneNumber: emailOrPhone, password: password)
           }
       }

       func signInWithPhone(phoneNumber: String, password: String) async throws {
           // Perform phone authentication
           let credential = PhoneAuthProvider.provider().credential(withVerificationID: "verificationID", verificationCode: password)

           do {
               try await Auth.auth().signIn(with: credential)
               // Successfully signed in with phone number
           } catch {
               print("DEBUG: Phone authentication error - \(error.localizedDescription)")
               throw error
           }
       }

}
enum AuthError: Error {
    case noCurrentUser
}
