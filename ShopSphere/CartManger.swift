//
//  CartManger.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/01/2024.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    @Published var cartCount: Int = 0

    func addToCart(product: Product) {
        DispatchQueue.main.async {
            self.products.append(product)
            self.total += product.price
            self.cartCount += 1
        }
    }

    func removeFromCart(product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            guard let index = self.products.firstIndex(where: { $0.id == product.id }) else {
                completion(.failure(CartError.productNotFound))
                return
            }

            self.products.remove(at: index)
            self.total -= product.price
            self.cartCount = max(0, self.cartCount - 1)
            completion(.success(()))
        }
    }

    enum CartError: Error {
        case productNotFound
    }
}
