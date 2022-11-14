# My dotfiles

Nothing fancy, just my dotfiles. There are thousands of ways to do this, just Google it. This is my way.

## Installation

1. Clone the repository to `$HOME/dotfiles`
1. Run `install.sh`

For each file (not directory) in `dotfiles/*`, it will:

1. If the file is `README.md` or `common_profile`, ignore it
1. Get the target name of the file by prefixing a `.`,, e.g. `dotfiles/profile` becomes `.profile`
1. If the target exists in `$HOME` as a symlink, remove it
1. If the target exists in `$HOME` as a normal file, back it up to `<target>.bkup`
1. Symlink `<target> --> dotfiles/<file>`, e.g. `ln -s dotfiles/profile $HOME/.profile`

## Runtime

Each source for a shell - `profile` for bash or `zshrc` for zsh - includes the following line:

```sh
source dotfiles/common_profile
```

This `common_profile` is run with each new shell. It looks in the directory `dotfiles/rc/` and sources each file there.
This allows you to have as many files as you want there, each topical in nature. Thus, I have one for git, one for terraform, etc.

In addition, if a directory exists that matches the results of `uname -s` lower-cased, it sources files in there.

For example, `dotfiles/rc/linux/` contains files sourced only on linux, while `dotfiles/rc/darwin/` contains files sourced only on macOS.

## Local Overrides

If you have commands or aliases that only make sense in a local context, and do not want to put them in your dotfiles,
these can be in `$HOME/.profile_local`. This will be sourced if found.

## Secrets and Credentials

While we are not great fans of keeping secrets and credentials in environment variables where every process that is launched can read them,
sometimes it is necessary. If the file `$HOME/.creds` is found, it will be sourced.

