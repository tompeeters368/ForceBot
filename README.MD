# ForceBot
ForceBot is a Zerg bot for StarCraft: Brood War written in [GOAL](https://goalapl.atlassian.net/wiki/), which is a programming language for multi-agent systems.

This repository hosts the version of ForceBot submitted to AIIDE and is otherwise not the development branch.

### Running ForceBot
If all you're interested in is running ForceBot, you can simply check the releases on this repository, which contains a pre-built version. In order to run this bot, all you need to do is extract its contents to `C:\StarCraft\bwapi-data` and then run `java -jar bwapi-data/ai/starcraftgoalaiwrapper-0.0.2-SNAPSHOT-shaded.jar` from the `C:\StarCraft` directory (your Java bin directory will need to be added to your PATH properly).

### Setting up ForceBot
Following the install guide on the [Eishub-StarCraft](https://github.com/eishub/Starcraft/wiki/Install-Guide) repository, explains all the steps to setting up the GOAL plugin for Eclipse, installing StarCraft and running the bot. Note that a 64-bit Windows is not required, nor do you need to install the StarCraft connector as this bot supplies its own version.

### Building ForceBot
For preparing ForceBot for running outside of the Eclipse plugin, please consult the following GitHub repository: [StarcraftGOALAIwrapper](https://github.com/Venorcis/StarcraftGOALAIwrapper).
After building you will want to run the bot once, which will unzip required files. Afterwards, you can open the JAR file and delete the `Bot.zip` and `connector.jar` files, as well as `linux.zip`, `mac.zip`, `win32.zip` and `win64.zip` files found in the swiprolog folder. Furthermore, please replace the `connector.jar` that it extracted into the `Bot` directory with the connector found in this repository.
