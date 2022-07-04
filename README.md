# Moral Distress App IDE Builder

Fork this repository to contribute to development of UVa's Moral Distress Monitoring and Mitigation app, a joint project between Computer Science and the School or Nursing. Follow the steps below and in a few minutes you should have a GitHub-repo-backed, VSCode-provided IDE opened to edit a fork of this repository cloned into your own local Docker container, along with a clone of <https://github.com/kevinsullivan/moralpain.git>. Both projects will reside in /workspaces in the container VM.  

## Install
> :warning: Some installation scripts have not been ported to Windows yet.
> Also, this installation guide does not describe Linux. However, the
> macOS instructions should be quite similar, and Linux support is expected.
### Prerequisites
Prior to setting up the MoralDistress development environment there are two
prerequisite tools that need to be in place. You need access to a shell and a
package manager.

#### Shell
A shell is a program with which we can, among many other things, issue
commands to invoke tools and software. On macOS and Linux we will use
the [Bash shell][10]. On Windows, we recommend [PowerShell][11]. Both
of these should be available on your system already.

#### Package Manager
A package manager is a tool that facilitates installing software packages from
the command line. If you are on a Linux machine, you will use the one
appropriate for your distro (e.g. [apt for Ubuntu][1]). On macOS, [Homebrew][2]
is a popular choice. On Windows, there is [chocolatey][3]. Follow the
your package manager's documentation to install.

---

With the prerequisites in place we can move forward with the installation
process. 

First, let us install git and git-lfs. Git will be used for cloning the code base locally
and for managing the project.

__macOS__
```bash
brew install git git-lfs
```

__Windows__
```PowerShell
choco install git git-lfs.install
```

Next, we install docker. Docker will host our development environment. We
provide an [image][12] that comes with all of the required dependencies baked
in.

__macOS__
```bash
brew install docker
```

__Windows__
```bash
choco install git-lfs.install
```

Finally, we install our IDE, [Visual Studio Code][8].

__macOS__
```bash
brew install --cask visual-studio-code
```

__Windows__
```PowerShell
choco install vscode
```

Inside VS code, we leverage the remote container extension to develop inside of
a docker container. You can read more about this pattern of development in the
[Visual Studio docs][13].

Next, let us use git to clone the repository.

__macOS__
```bash
git clone https://github.com/kevinsullivan/moralpain_dev.git
```

__Windows__
```PowerShell
git clone https://github.com/kevinsullivan/moralpain_dev.git
```

Once cloned, navigate to the `bin` directory and run the `install_emulator` script.
When prompted accept the licenses and default hardware profile.

__macOS__
```bash
cd moralpain_dev/bin
./install_emulator
```

__Windows__
```PowerShell
cd moralpain_dev\bin
.\install_emulator.ps1
```


The install script will update the `PATH` environment variable. For the changes
to take effect, you will need reload your shell configurations. One easy way to
do this is simply to restart the shell. We can claim success if we can locate
locate the Android tooling.

__macOS__
```bash
which sdkmanager || echo "tooling not found"
```

__Windows__
```PowerShell
Get-Command sdkmanager 
```

Now that we have all of our software in place, we can begin development.
First, launch the emulator from the command line.

__macOS__
```bash
./launch_emulator
```
__Windows__
```PowerShell
.\launch_emulator.ps1
```

Next, open up the `moralpain_dev` repository in VS Code. There will be several
prompts to click through. You should, "Trust the Authors", "Reopen in
Container", and "Install Recommended Extensions".  

VS Code will initialize your project. When done, in the bottom of the window
you should see an Android device listed.  

At this point, your environment is all set up. From here you can navigate to
the `main.dart` file and select the run button the appears above the `main`
method. This will build the application and launch it in the emulator.

## How It Works

We deliver a development environment via VSCode and its *Remote-Containers* capabilities. In a nutshell, when you ask VSCode to clone our repository, it will actually fork it and then clone your fork into the container that it launches to provide the programming platform you will then use to develop your solutions. It is very important to commit changes you make to your container-local repository, but then also to push them to your GitHub repo to back them up and because that should be the main repository for your project. You can log into it by simply opening a Terminal in VSCode. The clone of your repo is in the /workspaces folder within the container file system (or storage *volume*, as it's called).

## Risk Alert and Avoidance

It is important to understand that commits made to git are stored in the Docker container serving up the develop environment.  if you delete the container or its storage volume (which you could do through Docker Desktop), this will erase the work stored in the container. To make your container-local changes persistent, stage/add and then commit your local changes to the local repo, then push your container-repo-local changes to your repository on GitHub.

## Help Make It Even Better

Let us know what you think. Better yet, make it better and send us a PR. You'll be completely set up to do that by the results of this procedure.

## Legal and contact

Copyright: © 2021, 2022 By Rectors and Visitors of the University of Virginia.
Supervising Author: Kevin Sullivan. UVa CS Dept. sullivan@virginia.edu.
Acknowledgments: Thank you to multiple students for reading, testing, fixing.


[1]: https://wiki.debian.org/Apt
[2]: https://brew.sh/
[3]: https://chocolatey.org/
[4]: https://flutter.dev/docs/get-started/install
[5]: https://dart.dev/
[6]: https://developer.android.com/studio
[7]: https://developer.android.com/studio/run/emulator#install
[8]: https://code.visualstudio.com/
[10]: https://www.gnu.org/software/bash/
[11]: https://docs.microsoft.com/en-us/powershell/
[12]: https://github.com/kevinsullivan/moralpain_config
[13]: https://code.visualstudio.com/docs/remote/containers
