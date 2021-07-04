import Foundation
import BinaryCodable
import BinaryCookies

class CookieCleaner {
    
    private static func pathFor(_ path: String) -> String {
        return String(NSString(string: path).expandingTildeInPath)
    }
    
    static private let cookiesURL: URL = URL(fileURLWithPath: CookieCleaner.pathFor("~/Library/Cookies/Cookies.binarycookies"))
    // contents of these directories will be erased
    static private let dirsToErase: [String] = [
        "~/Library/Containers/com.apple.Safari/Data/Library/Caches/com.apple.Safari/",
        "~/Library/Containers/com.apple.Safari/Data/Library/Caches/WebKit/",
        "~/Library/Containers/com.apple.Safari/Data/Library/WebKit/WebsiteData/ResourceLoadStatistics/",
    ].map({ CookieCleaner.pathFor($0) + "/" })
    // contents of these directories will be erased if names don't match whitelist
    static private let dirsToScan: [String] = [
        "~/Library/Safari/LocalStorage/",
        "~/Library/Safari/Databases/___IndexedDB/v1/",
        "~/Library/WebKit/MediaKeys/",
        "~/Library/Containers/com.apple.Safari/Data/Library/WebKit/MediaKeys/",
    ].map({ CookieCleaner.pathFor($0) + "/" })
    
    private var cookies: BinaryCookies
    private let whitelist: [NSRegularExpression]
    
    init(whitelistPath: String) {
        do {
            let whitelistString = try NSString(contentsOfFile: whitelistPath, encoding: String.Encoding.utf8.rawValue)
            self.whitelist = try String(whitelistString).split(separator: "\n").compactMap({
                $0 == ""
                    ? nil
                    : try NSRegularExpression(pattern: String($0))
            })
            let cookiesData = try Data(contentsOf: CookieCleaner.cookiesURL)
            self.cookies = try BinaryDataDecoder().decode(BinaryCookies.self, from: cookiesData)
        }
        catch {
            print(String(describing: error))
            exit(EXIT_FAILURE)
        }
    }
    
    func run() {
        for page in self.cookies.pages {
            page.cookies = page.cookies.filter({
                self.inWhitelist(test: $0.url!)
            })
        }
        
        do {
            let encoder = BinaryDataEncoder()
            let data = try encoder.encode(self.cookies)
            try data.write(to: CookieCleaner.cookiesURL)
        } catch {
            print(String(describing: error))
            exit(EXIT_FAILURE)
        }
        self.clearFiles()
    }
    
    private func inWhitelist(test: String) -> Bool {
        for item in self.whitelist {
            if item.firstMatch(in: test, options: [], range: NSRange(location: 0, length: test.utf16.count)) != nil {
                return true
            }
        }
        return false
    }
    
    private func clearFiles() {
        let filemanager = FileManager.default
        for path in CookieCleaner.dirsToErase {
            filemanager.executeOnContentsOf(path: path, action: { (item: String) in
                do { try filemanager.removeItem(atPath: path + item) }
                catch { print(String(describing: error)) }
            })
        }
        for path in CookieCleaner.dirsToScan {
            filemanager.executeOnContentsOf(path: path, action: { (item: String) in
                if !self.inWhitelist(test: item) {
                    do { try filemanager.removeItem(atPath: path + item) }
                    catch { print(String(describing: error)) }
                }
            })
        }
    }
}

