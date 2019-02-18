# et
### extraterrestrial technology
#### 'et phone home'

## What is ET?

```
beam up #scotty
```

ET is a framework for allowing for more effective communication between phones and PCs. It is also a framework for making the creation of ad-hoc computer clusters super simple.

It currently consists of two tools:
- beam, a tool to interact with, and exchange state with an 'upstream provider', such as a phone
- probe, a tool to examine, create and configure an ad-hoc cluster

I'm pretty committed to this tool, so you can expect to see commits here for... years, honestly. It's a long way from finished. You should consider the current status a definite pre-alpha.

## Alright, how do **I** reach warp speed?

At the moment, this is pretty much just a tool for making it really, really easy to integrate your PC with your phone. 

To make it work, you'll need a POSIX shell environment on your phone. It doesn't need to be rooted, just download the app 'Termux' on the Google Play store. Install and run 'sshd', the SSH daemon. It should spawn an SSH server on port 8022.

Find out your phone's IP address.

Then, download these scripts, and run setup.sh.

If setup worked, you should then be able to run the command

```
beam up
```

And be dumped on your phone's termux shell.

## Objectives

One of the objectives of the project is to rely as much as possible on standard POSIX tools.

The main project will most likely be written in bash script, but some of the subtools ('apps') may be written in Python, because it's easier to build bigger software using something like that.

## Commands, current and future

### beam up
Dumps you into your phone's shell.

### beam up [command]
Executes a command on your phone, prints the standard output, then exits.

### beam scorch
Zeroes out all local copies of your files.

### beam backup
Creates a copy of your home directory on your phone.

### beam backup && beam scorch
;)

### [sudo] beam 
Destroys the local user environment. Requires root.

### beam mount
Mounts phone filesystem locally.

### probe
Prints a status update of the et system.

### probe up
Return all adjacent nodes to the phone.
