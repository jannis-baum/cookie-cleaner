import Foundation

func printUsage() {
    print("""
          cookie-cleaner: removes all safari cookies whose url doesn't match whitelist

          usage:
          cookie-cleaner WHITELIST_FILE
          """)
}

guard let whitelistPath = CommandLine.arguments[safe: 1] else { printUsage(); exit(EXIT_FAILURE) }

let cookieCleaner = CookieCleaner(whitelistPath: whitelistPath)
cookieCleaner.run()

