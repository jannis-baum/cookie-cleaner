# cookie-cleaner for Safari

Harness the benefits of "Private Browsing" without losing out on features like browsing history, an undo button, trusted log-ins and so much more!

`cookie-cleaner` erases any non-whitelisted cookies and local storage.

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

## Limitations & Recommendations

### Running `cookie-cleaner` automatically

macOS sandboxes files downloaded from the internet for security reasons and does the same to the main cookie file that this tool modifies (by deleting non-whitelisted cookies). Files sandboxed in this way can only be accessed and modified through direct user action, which in this case means you can only call the script "manually" from your shell and not, for example, have it run every time you quit Safari.

The way I get myself to use it regularly anyways is by incorporating it in another script in my `PATH` that I run every time I get off my MacBook: besides deleting cookies and unwanted browsing data it also cleans up some other things and quits apps.

Maybe something similar works for yourself or maybe you'll figure out how to have it auto-run - if so, be sure to let me know! :)

### Caches

My intention with this tool is to clear all non-whitelisted caches as well. At the moment most caches are cleared, however some sites seem to save them in a way the tool doesn't touch yet. It is possible to erase all caches by hitting the `Empty Caches` button in Safari through AppleScript, however this would significantly slow execution time. Feel free to contribute if you find out how to clear caches in a more sophisticated way.
