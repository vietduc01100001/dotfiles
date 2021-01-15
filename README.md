# Duc's dotfiles

This repo stores my dotfiles setup I'm using on my Mac.

### What's included?

- `install.sh`: used to run in a fresh installation of Mac OS to install everything I need.
- `Brewfile`: contains the list of brew packages and casks I'm using.
- `.zshrc`: my ZSH configurations.
- `.tool-versions`: I use `asdf` to manage programming language installations. This file contains the list and their versions.
- And other important dotfiles.

### Installation

0. Please [install Xcode command-line tools](https://www.google.com/search?q=install+xcode+command-line+tools) first.

1. Fork this repo.

2. Copy the repo link either as HTTPS or SSH. If you choose SSH, you should [set up your SSH key](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account) first.

3. Clone the repo to your HOME directory.
    ```
    git clone <repo link> ~/
    ```

4. Run the `install.sh` file and pass the repo link you've copied in step 2 as an argument.
    ```
    ./install.sh <repo link>
    ```

5. Restart and enjoy!

### Post-installation

- If you use `itomate` like me, you need to enable Python API in iTerm 2.

- My `.gitignore` file is ambitious, it ignores everything except for some. When tracking a new file or a whole directory, remember to add it to the `.gitignore` file as well.

- If you have private scripts or something you want to keep locally, put it in a `.private.sh` file. It's automatically loaded from the `.zshrc` file.

### Managing dotfiles

If done correctly, your HOME directory is now a git repository. You'll also have some commands to help manage the dotfiles easier.

| Command  | Alias of                                      | Description                                |
| -------- | --------------------------------------------- | ------------------------------------------ |
| `config` | `git --git-dir=$HOME/.git/ --work-tree=$HOME` | Like `git`, but only for the dotfiles repo |
| `cs`     | `config status`                               | Check the status of the dotfiles repo      |
| `cadd`   | `config add`                                  | Track new dotfiles                         |
| `cdc`    | `config checkout --`                          | Discard changes to a file                  |
| `cus`    | `config reset --`                             | Unstage a file                             |
| `cdown`  |                                               | Pull changes from remote and apply them    |
| `cup`    |                                               | Commit all local changes to remote         |
| `ch`     |                                               | Show help                                  |

They can be invoked anywhere regardless of the current working directory.

### Wait, there's more!

I also have an [`ubuntu`](https://github.com/hellovietduc/dotfiles/tree/ubuntu) branch where I store my configurations on my old Ubuntu machine. It's no longer maintained, but the one-click installation capability is awesome.
