#!/usr/bin/env just --justfile

alias p := push
alias pt := pusht

default: push


# Push the code to all remotes
push FLAGS="-u" BRANSH="aurora":
    git push {{FLAGS}} github {{BRANSH}}
    git push {{FLAGS}} gitlab {{BRANSH}}
    git push {{FLAGS}} codeberg {{BRANSH}}
    git push {{FLAGS}} disroot {{BRANSH}}
    git push {{FLAGS}} tangled {{BRANSH}}
    git push {{FLAGS}} codefloe {{BRANSH}}

# Push the git tags to all remotes
pusht: push
    git push --tags github
    git push --tags gitlab
    git push --tags codeberg
    git push --tags disroot
    git push --tags tangled
    git push --tags codefloe
    
# Remove the untraked garage
clean:
    git clean -fdx

# Update the local gruvbox theme from upstream
update-gruvbox:
    tmpdir=$(mktemp -d) && \
    git clone --depth=1 https://github.com/ellisonleao/gruvbox.nvim "$tmpdir" && \
    cp "$tmpdir/lua/gruvbox.lua" lua/gruvbox.lua && \
    rm -rf "$tmpdir"
