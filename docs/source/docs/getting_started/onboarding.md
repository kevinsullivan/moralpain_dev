# Onboarding
Configure your computer for development in this project

UVa Moral Distress Reporting, Analysis, and Response project. Department of Computer Science and the School or Nursing. Follow the steps below to build and change our software. Contact Kevin Sullivan UVa Dept. Computer Science, sullivan@virginia.edu, for more information. 

## Configure your local host machine (PC/laptop)

Before starting the configuration, make sure that if you are using Windows, you are on
Windows 11. Additionally, make sure that you use the correct capitalization and punctuation
for every instruction in order to avoid mistakes.

### Package manager

If not yet installed, install standard manager:

macOS: [Homebrew][2]
Windows: [chocolatey][3]

### Git and git-lfs

macOS:

```bash
brew install git git-lfs
```

Windows:

```PowerShell
choco install git git-lfs.install
```

### Docker Desktop

macOS:

```bash
brew install --cask docker
```

Windows:

```bash
choco install docker-desktop
```

### VSCode / Remote Containers

macOS:

```bash
brew install --cask visual-studio-code
```

Windows:

```PowerShell
choco install vscode
```

Run VSCode and install its [Dev Containers][21] extension.

### Java

Install it if it's not already installed.

macOS:

```bash
brew install openjdk@17
```

Windows:

```PowerShell
choco install openjdk --version=17.0.2
```

### Required utilities

macOS
```bash
brew install wget
```


### Chrome or Edge

Your default browser has to support the [Dart Debug extension][16] and as of
this writing only the Chrome and Edge browsers satisfy this requirement.
Firefox does not. 

1. install the Chrome or Edge browser if necessary
2. Make it your default browser (at least temporarily)
3. Run it and install the Chrome "Dart Debug" extension

### SSH
macOS:
No action needed.

Windows:
On Windows, the `OpenSSH` packaged with `PowerShell` may not be sufficient for forwarding the agent to the container. Check the version of the `ssh-agent`

```PowerShell
Get-Command ssh-agent
```

If it falls before `8.9.1.0` then an upgrade is required. Follow the instructions [here to upgrade][24]. Step 8 may be omitted. 

### SSH keys
Create an SSH key and add it to your GitHub account by following the [official instructions][17].

### Configuring the SSH agent
We will use the [ssh agent][18] to manage our ssh keys.

Launch the agent and add your keys.

macOS:
```
eval "$(ssh-agent -s)"
ssh-add ~\.ssh\id_ed25519
```

Windows:

```PowerShell
# By default the ssh-agent service is disabled. Configure it to start automatically.
# Make sure you're running as an Administrator.
Get-Service ssh-agent | Set-Service -StartupType Automatic

# Start the service
Start-Service ssh-agent

# This should return a status of Running
Get-Service ssh-agent

# Now load your key files into ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

### Our software
With the prequisite dependencies installed we can begin initializing our
project.  

First, fork our repository into your GitHub account. Then clone that repository
to your local machine.

```bash
git clone https://github.com/<your-github-id>/moralpain_dev.git
```

Next, launch the docker-desktop application. Note that Window's docker has an
[odd issue][20] where you must logout then login to startup docker after
installation.


Open your cloned `moralpain_dev` folder in VS Code. 
```bash
code moralpain_dev
```


There will be several prompts to click through. You should, "Trust the
Authors", "Reopen in Container", and "Install Recommended Extensions". VS Code
will initialize your project. When done, in the bottom of the window you should
see an Android device listed.  

### Android tools

macoOS:

```bash
./bin/install_emulator
```

When prompted accept the licenses and default hardware profile.  The install
script will update the `PATH` environment variable. For the changes to take
effect, you will need to exit and restart your shell. On Windows, it's still a
manual chore. Use Powershell.


Windows:

#### Android Command Line Tools
Many android utilities search for software relative to an [`ANDROID_HOME`
directory][22]. This directory can be anywhere on your system but we will
continue with `C:\tools\android`. It is best practice to set an environment
variable to identify this directory.

```PowerShell
mkdir -p C:\tools\android
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", "C:\tools\android", "User")
```

Next, in `ANDROID_HOME`, download and extract the android command line tools.
```PowerShell
cd C:\tools\android
wget "https://dl.google.com/android/repository/commandlinetools-win-10406996_latest.zip" -OutFile cmdline-tools.zip
Expand-Archive cmdline-tools.zip
rm .\cmdline-tools.zip
```

The directory structure of the unzipped archive [needs to be tweaked][23].
```PowerShell
mv .\cmdline-tools\cmdline-tools .\cmdline-tools\latest
```

Then, add the following directories to the path.
```PowerShell
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\tools\android\cmdline-tools\latest\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\tools\android\emulator", "User")
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\tools\android\platform-tools", "User")
```

Note the `emulator` and `platform-tools` locations will be created in later steps.  

Finally, exit and restart your shell.  

Your computer should now be able to locate the Android tooling.

```PowerShell
Get-Command sdkmanager 
```

Seek help if the sdkmanager program is not found on your path.

#### Android SDK and Tooling, and Emulator
We can now use the android `sdkmanager` installed with the command line tools
to install the remaining utilities. 

```PowerShell
sdkmanager "build-tools;31.0.0" "platform-tools" "platforms;android-31" "emulator" "system-images;android-31;google_apis;x86_64"
```


#### Create a Virtual Device
The previous step installed, among other packages, an android emulator. Now we
create an android device to run on the emulator.

```PowerShell
avdmanager create avd --name avd_31 --package "system-images;android-31;google_apis;x86_64"
```

When prompted, select "no" for a custom hardware profile.


### Run emulator

On your local machine run the Android emulator. After some seconds you should see an emulated Android phone appear.  

macOS/Linux:

```bash
./launch_emulator
```

Windows:

```PowerShell
adb start-server
emulator -avd avd_31 -gpu host
```

You should now see an Android device emulator starting up and running. 

### Run Moral Distress App on the Android Device
With the Android emulator running, go to VSCode. In the bottom-right, you
should be able to select the "sdk gphone64 x86_64 (android-x64 emulator)"
device. If not, try to reestablish the connection with the device. From the
docker (VS Code terminal) run:

```bash
adb connect host.docker.internal:5555
```

If this errors please seek help. Otherwise, select the device.


We should now build the local dependencies to the project. Use the following
one-liner to make this easy:

```bash
find . -name 'pubspec.yaml' -execdir flutter pub get \;
```

Finally, open the main.dart file and press the "Start Debugging" button in the
top right to run the app on the emulator. 


## Legal and contact

Copyright: © 2021, 2022 By Rectors and Visitors of the University of Virginia.
Authors: Nicholas Phair, Vanessa Amos, Lucia Wocial, Beth Epstein, Kevin Sullivan.
Contact Author (Software): Kevin Sullivan. UVa CS Dept. sullivan@virginia.edu.
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
[14]: https://developer.android.com/studio/#downloads
[15]: https://www.java.com/en/download/manual.jsp
[16]: https://chrome.google.com/webstore/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm
[17]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
[18]: https://www.ssh.com/academy/ssh/agent
[19]: https://stackoverflow.com/a/18915067
[20]: https://github.com/docker/for-win/issues/12798
[21]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
[22]: https://developer.android.com/tools/variables
[23]: https://stackoverflow.com/questions/65262340/cmdline-tools-could-not-determine-sdk-root
[24]: https://superuser.com/questions/1726204/get-agent-identities-ssh-agent-bind-hostkey-communication-with-agent-failed
