# iocage_scripts

A simple plugin based system for creating iocage based jails. 
iocage plugins don't seem to add much, and if I used them, I'd still 
need a script to configure the mounted directories etc. Note that
the goal here is that no persistent information lives inside the
jail. 

setup.sh will look in jail_configs/ for any files there, check if 
a jail of the same name exists, and if not, call setup_<app name>
in an attempt to create it.

Each jail_configs file should define a function setup_<app name> where
<app name> matches both the filename, and the final jail name.

Any support files live in jail_files/ and high level configuration
stuff lives in config.sh. If anyone other than me runs this, you 
will definitely need to modify config.sh


All of the apps that have persistent configuration should store
it in /config, downloads should be in /downloads etc
