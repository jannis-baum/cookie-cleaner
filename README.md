# cookie-cleaner for Safari

Harness the benefits of "Private Browsing" without losing out on features like
browsing history, an undo button, trusted log-ins and so much more!

`cookie-cleaner` erases any non-whitelisted cookies and local storage.

## Usage

Clone this repository and

```shell
make all
```

To run ensure Safari isn't running and then execute
`.build/release/cookie-cleaner WHITELIST` where `WHITELIST` is a text file.
Cookies and local data whose identifiers match the RegEx on any line of this
file will be ignored, while all others will be deleted.

As an example, to keep log-in data for `github.com`, simply add the line

```markdown
github
```

to your whitelist file. Note that the application you are launching
`cookie-cleaner` from needs to have *Full Disk Access* enabled in the system
*Security & Privacy* settings. Read below for an explanation why.

## Running `cookie-cleaner` automatically

You can run `cookie-cleaner` automatically when you close Safari or when your
Mac goes to sleep with trigger-based automation tools such as
[BetterTouchTool](https://folivora.ai). For this to work, the automation tool
needs to have *Full Disk Access* enabled.

## Note on Full Disk Access

macOS sandboxes files downloaded from the internet for security reasons and does
the same to the main cookie file that this tool modifies (by deleting
non-whitelisted cookies). Files sandboxed in this way can only be accessed and
modified through direct user action, which in this case means you can only call
the script "manually" from your shell and not, for example, have it run every
time you quit Safari.
