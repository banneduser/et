# et
## a toolkit for making communication between phones and PCs simpler

It currently consists of two tools:
- beam, a tool to interact with, and exchange state with an 'upstream provider', such as a phone
- probe, a tool to examine, create and configure an ad-hoc cluster

## Alright, how do I get it to work?

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
