# who-let-the-docks-out
collection of scripts to manage docker using docker compose

## scripts

| Script | Description |
|---|---|
| dockget.sh | gets the yaml-file from the defined path. overrides the existing file <br> *pass one or multiple yaml-files as argument* |
| dockpull.sh | pulls the docker images defined in the yaml <br> *pass one or multiple yaml-files as argument / pull all images without an argument* |
| dockrun.sh | runs the container <br> *pass one or multiple yaml-files as argument* |

### additional scripts to complement this collection
| Script | Description |
|---|---|
| dockcheck.sh | checks for new images and updates the container <br>https://github.com/mag37/dockcheck |

## configuration
the scripts pull variable-values from *dockscripts.conf*

example:
```
docker_folder=~/docker
yaml_folder=ftp://yourFtpServer.tld/path/to/compose
yaml_folder=https://github.com/[USER]/[REPO]/blob/master (not tested)
```
you can store the username and password for the yaml-folder in the file ~/.wgetrc:
```
user=john
password=johnspassword
```


## file structure
```
~/docker
├── container1.yaml
├── container2.yaml
├── container1
│   ├── data
│   └── ...
├── container2
│   ├── data
│   └── ...
...
```

## usage
Clone this repo to get the scripts and make them executable.
```bash
git clone https://github.com/daguen/who-let-the-docks-out.git
cd who-let-the-docks-out/
chmod +x *.sh
```

Move scripts to ~/bin and add them to PATH. <br>
This way you can use the scripts from every directory without explicitly typing the full path.
```bash
cp *.sh ~/bin #make sure ~/bin exists
export PATH=~/bin:$PATH
```

Navigate to docker-folder and run the scripts. <br>
Use autocomplet for container-names. Foldername or yaml-filename are accepted as arguments. <br>
Use no argument to list the possible arguments (and use the full list as arguments if possible)
```bash
dockpull.sh 
dockpull.sh [container1]
dockpull.sh [container1.yaml]
```
