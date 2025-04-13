//
//  Caching.swift
//  MazaadyIOSTask
//
//  Created by Mac on 13/04/2025.
//
import Foundation


class CacheService {
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Cache Keys
    private enum Keys {
        static let products = "cachedProducts"
        static let productsTime = "productsFetchTime"
        
        static let userInfo = "cachedUserInfo"
        static let userInfoTime = "userInfoFetchTime"
        
        static let ads = "cachedAds"
        static let adsTime = "adsFetchTime"
        
        static let tags = "cachedTags"
        static let tagsTime = "tagsFetchTime"
    }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Generic Save / Load Helpers
    
    private func save<T: Encodable>(_ object: T, forKey key: String) {
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print(" Failed to save cache for key \(key): \(error)")
        }
    }
    
    private func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to load cache for key \(key): \(error)")
            return nil
        }
    }

    // MARK: - Cache Time
    
    func saveCacheFetchTime(forDataType dataType: String, time: Date) {
        let key = "\(dataType)FetchTime"
        userDefaults.set(time, forKey: key)
    }
    
    func loadCacheFetchTime(forDataType dataType: String) -> Date? {
        let key = "\(dataType)FetchTime"
        return userDefaults.object(forKey: key) as? Date
    }

    // MARK: - Products
    func saveProductsToCache(_ products: [Product]) {
        save(products, forKey: Keys.products)
    }
    
    func loadCachedProducts() -> [Product]? {
        return load([Product].self, forKey: Keys.products)
    }
    
    func saveProductsFetchTime(_ date: Date) {
        userDefaults.set(date, forKey: Keys.productsTime)
    }
    
    func loadProductsFetchTime() -> Date? {
        return userDefaults.object(forKey: Keys.productsTime) as? Date
    }

    // MARK: - User Info
    func saveUserInfoToCache(_ userInfo: UserInfoModel) {
        save(userInfo, forKey: Keys.userInfo)
    }
    
    func loadCachedUserInfo() -> UserInfoModel? {
        return load(UserInfoModel.self, forKey: Keys.userInfo)
    }
    
    func saveUserInfoFetchTime(_ date: Date) {
        userDefaults.set(date, forKey: Keys.userInfoTime)
    }
    
    func loadUserInfoFetchTime() -> Date? {
        return userDefaults.object(forKey: Keys.userInfoTime) as? Date
    }

    // MARK: - Ads
    func saveAdsToCache(_ ads: AdvertisementsResponse) {
        save(ads, forKey: Keys.ads)
    }
    
    func loadCachedAds() -> AdvertisementsResponse? {
        return load(AdvertisementsResponse.self, forKey: Keys.ads)
    }
    
    func saveAdsFetchTime(_ date: Date) {
        userDefaults.set(date, forKey: Keys.adsTime)
    }
    
    func loadAdsFetchTime() -> Date? {
        return userDefaults.object(forKey: Keys.adsTime) as? Date
    }

    // MARK: - Tags
    func saveTagsToCache(_ tags: TagsResponse) {
        save(tags, forKey: Keys.tags)
    }
    
    func loadCachedTags() -> TagsResponse? {
        return load(TagsResponse.self, forKey: Keys.tags)
    }
    
    func saveTagsFetchTime(_ date: Date) {
        userDefaults.set(date, forKey: Keys.tagsTime)
    }
    
    func loadTagsFetchTime() -> Date? {
        return userDefaults.object(forKey: Keys.tagsTime) as? Date
    }
}
