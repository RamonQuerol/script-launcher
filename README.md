# Script Launcher - SLA

Small CLI tool to store and easily run scripts from anywhere in the system.

## Capabilities

The tool allows the user to:

- Add scripts to the database (sla add)
- Run scripts from the database (sla run)
- Delete scripts from the database (sla del)
- Copy scripts from the database (sla cp)
- List all the scripts in the database (sla ls)

The tool works for any kind of script, no matter if its shell, python or an executable. This is possible because the user sets the "launcher command" (for example, python3 script.py) when they add a script to the database.

To know how to use the tool properly use the "sla help" command. There you should find all the necessary information on how to use all the subcommands (It's quite simple to be honest, but contact me if there are issues).

## Installation

I personally recommend making a symlink to the command in a directory that is inside PATH and named it sla:

```sh
ln -s sla.sh path/to/directory/inside/PATH/sla
```

The autocompletion script `sla_completion_install.sh` installation depends a bit on the linux distribution you are using. However, it usually involves either using some bash-completion directory or making so that the following command is run when bash starts:

```
source /absolute/path/to/sla_completion_install.sh
```

## Reasons and purposes

The reason behind this little project was mainly that I was a bit tired of having my scripts on some obscure directory I have to write the path to every time I wanted to run them. So I just made a command that stores and launches any script from anywhere in the system without too much boilerplate. To achieve this I made the following decisions:

### Written in bash
Mainly because that way I can easily run it in any Unix based system without having to do processes like recompiling. But also because that way I force myself to keep it simple. 

### Simple to write
I named the command "sla" because these letters are pretty easy to write in a normal keyboard (and because as far as I know there is no other command named this way). I also added autocomplete so that you can easily tab your way through the command.

###  Prioritized run over other functionalities
The main goal of the tool is to make running scripts as easy as possible. That comes at the cost of making the experience of adding scripts a little more clumsy. By making the user do all the heavy lifting on "sla add", the "sla run" command ends up being quite simple to use.

## Future improvements

Although I want to keep the command simple and I will not add this features unless I find a script that need them, these improvements are:
- Rename feature and making it so that you can add custom names to the script on "sla add" (Currently takes the basename of the file you added).