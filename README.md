# My Dotfiles #

This repo stores my dotfiles, using a "disconnected git" technique
that makes it easy to keep all your dotfiles in a git repo, without
turning your home directory into a repo and without doing crazy things
with symlinks.

It's originally based on [a comment on a HackerNews thread][HN], which
I found through an [Atlassian Blog Entry][Atlassian] but I've added
some additional tooling to make it a little easier to manage.

The way it works is that it uses [a script](./cfg/bin/cfg) that sets
up `$GIT_DIR` and `$GIT_WORK_TREE` to manage your home directory.  The
way this works is actually pretty simple, in the end all it's really
doing is turning your home directory into a git repository, but
instead of having a `.git` directory (which is what causes problems if
you try to manage your entire home directory as a repo), it calls
it `.cfg` instead.  In addition to the `.cfg` directory, I also use
a `cfg` directory in my home directory to hold ancillary information
related to my dotfiles and configuration.

[HN]: https://news.ycombinator.com/item?id=11071754
[Atlassian]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

## Creating a new dotfiles repo for your own use ##

I set this repo up in a way that makes it pretty easy for you to use
it to create a new dotfiles repo of your own.  This repo includes a
[very short script that will do it for you](./cfg/create-new-repo.sh)

To get started, all you need to do is pick the machine that has the
"best" set of your dotfiles, the ones you want to start with to
populate your repo.  Then on that machine download and run the setup
script.

    RAW="https://raw.githubusercontent.com/jasonk/dotfiles/master/cfg"
    curl -sSL "$RAW/create-new-repo.sh" | bash

## Adding files to your repo ##

Now you can see what dotfiles you have that haven't been added to your
repo yet:

    cfg status

I **strongly** recommend reviewing each of your dotfiles before adding
it to the repo, to ensure you aren't committing any files that include
passwords, api tokens or other potentially sensitive information.

To add a file to your repo:

    cfg add .bashrc
    cfg add .bash_profile

## Ignoring files ##

To ignore a file you don't want to ever add to the repo, you can use the
`cfg ignore` command.

    cfg ignore /.secrets.txt /.passwords.txt

When you provide filenames to `cfg ignore`, remember that they are
`.gitignore` entries, so to anchor them to your home directory (the
root of the repo) you should start them with a `/`.

When you add ignore entries this way they get added to the file
`cfg/ignores/cli-added`.  If you want to add them to a different
ignores file (and perhaps include comments) then you can just edit
the appropriate file to add whatever entries you want, and then run
`cfg ignore` with no other arguments and it will just rebuild your
master ignore file.

## Committing Changes ##

Once you have all your config files in the repo, you need to commit
them to your repo just like you would with git:

    cfg commit -am 'Added all my dotfiles'

## Pushing to GitHub (or other server) ##

If you want to keep your dotfiles on GitHub (or your Git provider of
choice), then you just need to create a repo there and add it as
a remote to your config repo:

    cfg remote add origin https://github.com/<your-username>/dotfiles

Then you can push your local changes to the remote:

    cfg push

## Setting up on another machine ##

Now if you have another machine you want to have your dotfiles managed on,
the process for setting it up there is a little more complicated than a
regular git clone (because you can't clone into a non-empty directory and
your home directory is probably not empty).

Fortunately, I have [a script for that too](./cfg/checkout.sh).
To use it:

    REPO="https://github.com/<your-username>/dotfiles"
    RAW="https://raw.githubusercontent.com/jasonk/dotfiles/master/cfg"
    curl -sSL "$RAW/checkout.sh" | bash

Once it's run you should have the `cfg` command available and running
`cfg status` should show you the differences between the dotfiles on
this machine and the ones in your repo.

For files that aren't in the repo yet, you just need to review them
just like you did when first setting up the repo, and `cfg add` or
`cfg ignore` them as appropriate.

For files that have changed you can review the changes with your
favorite diff tool (or just `cfg diff`) and decide if there is
anything in the local version that you want to keep.  If you decide
you don't want to keep anything you can throw away the changes and
just get the repo version by running `cfg checkout -- <filename>`.

Alternately, you can copy the [cfg-deploy](./cfg/bin/cfg-deploy)
script from this repo into your own `~/cfg/bin` directory, then you
can setup a new machine (assuming you can ssh to it) by simply running
`cfg deploy hostname`.

## Syncing updates ##

Once you have committed updatees on the second machine, you can `cfg
push` those back to your repo host, and then on the first machine you
can `cfg pull` to get those updates back to there too.

# Some Advanced Capabilities #

## Adding your own `cfg` subcommands ##

When you run `cfg <cmd>`, it checks to see if you have a file in
`~/cfg/bin` named `cfg-<cmd>`, and if you do it runs that script
instead of what it would have normally done.  You can use this
capability to easily add commands to `cfg`.

For some examples of how this can be useful, take a look at:

* [cfg-deploy](./cfg/bin/cfg-deploy)
* [cfg-check-for-updates](./cfg/bin/cfg-check-for-updates)

## Running specific setup scripts ##

If you add scripts into `~/cfg/setup-scripts` they will all get run
each time that you run `cfg setup`.  If you ever want to run just one
or two of those scripts, you can pass script names as arguments to
`cfg setup` and it will run them for you.  This can be easier than
just running them directly if they depend on the environment setup by
the `cfg` command.
