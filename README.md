# Android backup repacker
Utility (shell-script) to search and get application from device, extract and repack Android backups created with adb backup.

## Requeriments
- bash
- adb
- python 2.7 (with zlib library)

## Usage
### Syntax
```bash
./abrepack.sh <command> <package/application name>

	Commands:
		search <string> - search string in package list on device
		get <app>       - backup app into ab-file
		unpack          - unpack ab-file (unpack to tar and untar)
		repack          - pack untared data into ab-file
		extractapp <app> - backup app, unpack to tar-file and untar it
		clear           - remove all tmp files and dir apps

```

`./abrepack.sh extractapp com.android.game.name` - will get application from android device and unpack it into current directory in ./apps . Then you can do some changes in it.

`./abrepack.sh repack` - will repack ./apps (which was gotten with `extractapp` or `get && unpack`) into backup.mod.ab . Then you can execute `adb restore backup.mod.ab` to restore backup to android device.

`./abrepack.sh clear` - will delete got from device and additional generated files (without backup.mod.ab)


### Example
```
$ ./abrepack.sh search vector
com.nekki.vector		- package:/data/app/com.nekki.vector-1/base.apk=com.nekki.vector

$ ./abrepack.sh extractapp com.nekki.vector
Now unlock your device and confirm the backup operation...
Backup com.nekki.vector is done. Backup was saved in backup.ab
Backup unpacked into backup.tar
Files list was extracted
AB-headers were extracted

$ ./abrepack.sh repack
Backup was created. Now use can execute:
    adb restore backup.mod.ab

$ adb restore backup.mod.ab
Now unlock your device and confirm the restore operation.

```

### P.S.
_Extract_ and _restore_ backups were tested (completely working) with Linux and android 5, android 8

For android 4.4 (tested at one device) works only restore repacked backups. `adb backup` generates empty backups (some bugs in that version of android).

#### Thanks
- https://android.googlesource.com/platform/frameworks/base/+/4a627c71ff53a4fca1f961f4b1dcc0461df18a06
- nelenkov for https://github.com/nelenkov/android-backup-extractor