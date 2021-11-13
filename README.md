# cookie-cleaner

Harness the benefits of "Private Browsing" without losing out on features like browsing history, an undo button, trusted log-ins and so much more!

`cookie-cleaner` will erase any non-whitelisted local storage with the exception of some caches that are still persistent at the moment.

## Usage

Clone this repository and

```
make all
```

To run, execute `.build/release/cookie-cleaner WHITELIST` where `WHITELIST` is a text file. Cookies and local data whose identifiers match the RegEx on any line of this file will be ignored, while all others will be deleted.

As an example, to keep log-in data for `github.com`, simply add the line
```
github
```
to your whitelist file.

