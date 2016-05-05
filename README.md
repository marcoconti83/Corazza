![Pisa gioco del ponte](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Pisa_GiocoPonte_29061935.jpg/800px-Pisa_GiocoPonte_29061935.jpg)
# Corazza

Corazza is a library to create interactive Swift scripts or command line tools. It enables to ask questions on standard output and read answers from standard input.

A simple example Swift script usage can be found in the [Example](https://github.com/marcoconti83/corazza/tree/master/Examples) folder.

## Examples

Asks which kind of turtles is your favourite:
```
Do you like turtles?
[Y]es or [N]o? (default: Y) > y

Which one is your favourite?
------------------------------------
1		Chelonoidis nigra
2		Dermochelys coriacea
3		Chelydra serpentina
4		Trachemys scripta elegans
------------------------------------
Choose an option > 2

I love Dermochelys coriacea!
```

## How to use Corazza in your script

Just add ```import Corazza``` to your script

In order to be able to import it, you need to have the `Corazza` in the Swift search path. You can achieve this by compiling it yourself or downloading a binary version from a release. You need to invoke Swift with the `-F` argument, pointing to the folder where Corazza is stored.

### Carthage integration
Corazza can be downloaded locally with [Carthage](https://github.com/Carthage/Carthage). 

Just add 

```github "marcoconti83/Corazza"```

to your `Cartfile`. After running

```carthage update```

you would be able to run any swift file with

```swift -F Carthage/Build/Mac```

The `-F` flag can also be included in the [shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29) line of the script, so that you can just invoke the script directly (e.g. ```$> do.swift```). This is the approach used in the [examples](https://github.com/marcoconti83/corazza/tree/master/Examples) included with this project.

### Without Carthage
You can download the framework binary from the GitHub [latest release](https://github.com/marcoconti83/Corazza/releases/latest)
