# camotics-nix
Nix expressions for CAMotics

## Current status

**I can no longer get this to work.** I've spent days trying to debug it, now I've given up and run a Debian VM for Camotics. I think it's some kind of graphics driver problem, because I can get an old NixOS generation to work, but not a current generation. ie. binaries compiled in a current generation do not work in that environment, but the same binaries work in an older generation. But the generations have the same Mesa versions, same Wayland versions, and I swear the `strace -f` output from working/not working is identical apart from printed error messages.

---

This whole process probably could have been simplified by checking out an old nixpkgs, so that all the packages are in a similar shape to the Debian that CAMotics expects to be built on. But of course I didn't notice that before I started this, so I've done it the hard way.

This needs a recent nixpkgs, after [this commit](https://github.com/NixOS/nixpkgs/commit/f79fd2e826dd95b3b64839d3e0bec8ae1dfab17e) was merged, in order for `wrapQtAppsHook` to be available. Release 19.09 and later should do.

## Use

Simply clone and run nix-build. It will pick up the default.nix and build CAMotics. Binaries will be placed in `./result/bin/`

Nix expression, overlay and derivations loosely based on [this](https://www.reddit.com/r/NixOS/comments/8tkllx/standard_project_structure/).

## Merge to nixpkgs?

I don't think this is suitable for nixpkgs. `c!` in particular requires the whole build directory to be copied to the store, and it contains the complete libyaml package and two copies of it's headers plus a few other non-standard things. I also needed to build `c!` with GCC5 and CAMotics with GCC6 to avoid build errors. Gyp has been removed from nixpkgs and would have to be re-added I think. CAMotics requires an older version of v8 than current nixpkgs. But if someone from NixOS with merge permission says this could be acceptable, I'm happy to work on a PR for it.
