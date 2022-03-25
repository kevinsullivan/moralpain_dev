# Moral Distress App IDE Builder

Fork this repository to contribute to development of UVa's Moral Distress Monitoring and Mitigation app, a joint project between Computer Science and the School or Nursing. Follow the steps below and in a few minutes you should have a GitHub-repo-backed, VSCode-provided IDE opened to edit a fork of this repository cloned into your own local Docker container, along with a clone of <https://github.com/kevinsullivan/moralpain.git>. Both projects will reside in /workspaces in the container VM.  

## What To Do
### Recommended

- Update your operating system:
  - If MacOS: Be sure your OS is completely up-to-date (current version of Big Sur, currently 11.5.2 as of this writing).
  - If Windows 10 Home: Update to Windows 10 Education (Windows 10 Home won't do). If you're a UVa student, updating to Windows 10 Education is free.
    1. Get OS Windows Update license key from ITS: <https://virginia.service-now.com/its/>.  
    2. Click Software in the left-hand navigation. Select the *latest* Windows 10 Education version. Get an update key.
    3. After obtaining the OS key, copy and paste it in to the Windows Activation page (same screen as Windows Update).
    4. Reboot your machine. You can check the Windows *System Information* app to confirm that your OS is updated.
- Have a GitHub account. Create one for yourself if necessary. It's free: <https://github.com/>
- Install Docker Desktop: <https://www.docker.com/products/docker-desktop>.
- Install VSCode: <https://code.visualstudio.com/download>.
- Launch Docker Desktop and watch for it to complete its start-up procedures. While it starts up, continue on to the remaining instructions.
- Use GitHub to fork this repository now.
  - Be logged in to your GitHub account.
  - Visit this very repository on GitHub (which is probably where you're reading this)
  - Fork this repo using the *Fork* button in the upper right corner.
  - This will create a copy of this entire repository in *your* GitHub account. Visit your GitHub page to confirm that you now have a clone of this repository.
  - Select the green Code button, then HTTPS, then copy the URL that is provided. This will be the GitHub URL of your newly forked copy of the respository.
- Open our Development Environment directly from your new GitHub repository
  - Launch a *new* VSCode window.
  - Use CTRL/CMD-SHIFT-P to bring up the VSCode command palatte.
  - Search for and select *Clone Repository in Container Volume*
  - Paste the URL of your new repository as the argument.
  - If it asks, select *unique repository*.
- Wait for your development environment to completely "boot up" before taking any further actions.
- Set your git user.name and user.email values in your VM using a terminal
  - git config --global user.name "Your Name"
  - git config --global user.email "your@email.addr"

### Alternative
The above instructions will setup a development environment containerized by docker. The environment
container comes packed with all of the required dependencies. The only limitation is we have not
connected the environment to a phone emulator. Until that feature is implemented, the best
way to emulate the app is with a local development environment.

#### Setting up a local environment
##### Prerequisites
To develop locally we will first need to install the required dependencies.
Installation methods differ from platform to platform but the required tools
are the same.  

We recommend installing a package manager. This is a tool that allows
you to install software packages from the command line. If you are on a Linux
machine, you will use the one appropriate for your distro (e.g. [apt for
Ubuntu][1]). On macOS, [Homebrew][2] is a popular choice. On Windows, there
is [chocolatey][3]. With the package manager installed, we will use it to
install the `moralpain` IDE dependencies. All of the following code snippets
will use the Homebrew package manager but use whatever you have installed.  

First, let us install git and git-lfs. Git will be used for cloning the code base locally
and for managing the project.
```bash
brew install git git-lfs
```

Next, let us install the [Flutter SDK][4]. Flutter packages the
[dart programming language][5] with the SDK so we need not install it
separately.
```bash
brew install --cask flutter
```

At this point you should be able to run Flutter from the command line.
```bash
flutter doctor
```
If the above command fails make sure the install location is on your path.
You might have to exit from your terminal/shell and restart it. Also, at
least on OSX, you might be asked to approve the installation of additional
XCode software on your machine. Proceed to approve installation of this
software on your machine. 

Next, we want to install a phone emulator. Here we will install an android
device. iOS device emulation can only be done on macs. 
```bash
brew install --cask android-studio
```

Now, you might know that [Android Studio][6] is an IDE. However, 
it packages up all of the tools needed to run an emulator. For that reason,
it is easier just to install the whole android-studio package than to
wrangle each individual dependency.  

Once Android Studio is installed we will use it to create an emulator. However, 
before that, you will need to create a project. We will not actually be using 
this project but, we do need it to get to the options for creating an emulator. 
Now, the minimum API to target is 29. Besides that, all of the wizards
default options should be appropriate. Finally, with a project setup we direct
you to the instructions published in the [android studio documentation][7] for
creating the emulator.  When asked for an API level, again target level 29.

After this we should be permanently done with Android Studio.  

Finally, we should install the IDE that we will be using in this project.
That is [visual-studio code][8] (vscode). 
```bash
brew install --cask visual-studio-code
```

##### Building
To build `moralpain_dev` you should first clone the code base to a desired
location on your machine. 
```bash
git clone https://github.com/kevinsullivan/moralpain_dev.git
```

Now, navigate inside the project and install the dependencies.
```bash
cd moralpain_dev/app
flutter pub get
```
Note that these are dependencies that are needed to run the app. The
previous installation steps we went through were to install the dependencies
for the development environment.  

Next, open up the visual studio app. Then open up the cloned project, `moralpain_dev`.
On the bottom bar of vscode, near the right corner, there will be an option to select
the device to run the code on. Search for, and choose the android emulator you previously
installed. This will start the emulator.

Finally, you can launch the app on the emulator by using the explorer window to open
the `main.dart` program. This is the app entry point. Once open, select `Run and Debug`
on the vscode side bar. From there, press the play button. After a compiling the code
and transferring it to the emulator the app should be running on the virtual device.

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
