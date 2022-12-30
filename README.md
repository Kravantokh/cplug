# Cplug
A project that shows the fact that a more or less complex plugin system with 100% C and native plugins can be made. No need for the overhead of an interpreted language.

This project make use of TCC (Tiny C Compiler) for compiling the plugins at runtime. Due to its small size an blazingly fast compilation times this choice was a no-brainer.

TCC is used as a separate executable, because I did not manage to convince it in any way to produce shared objects when used as libtcc.

## What is this all about?
This repo demonstrates a way to make funcional plugin/scripting systems with just C and tcc.

In src there is `cplug.c` which is the host program and `test.c` which is the plugin/script. `test.c` is copied into the build/tcc directory and compiled only when the host program is run (thus scripting).

In `plugin_api/base` you may find the description of the API exposed by the host. This file just demonstrates a few ways to exchange information between the host and the plugins. It is not meant to be taken as the greatest example. It shows only the concepts.

## Why function pointers?
The plugin API makes extensive use of function pointers (it passes a bunch of them to every plugin as an API, for those who haven't checked out any files yet). Why is this indirection needed? Why not just link functions to the plugins as well?

The answer is *control* and *safety*.
This way the host can have much greater control over what functions it exposes to the plugins and how. It can also follow and log them to detect errors and even malicious intent of plugins. On the other hand, this complicates things, because in some way the function signatures must be known by both the host and plugin/script (my method of choice was the usage of a struct containing the pointers and I can not think of a more straightforward way to achieve this).

This necessitates the passing of these function pointers when a plugin is loaded. For this a struct may be used, as mentioned above. That requires a common datatype between host and plugin/script, but most likely one would need more such datatypes anyway and thus it should not be more than a minor inconvenience.

## Performance
This initial pointer passing and the indirect dispatch done by pointers adds a little overhead which may or may not be of concern. Most likely it won't be, because these plugins are most likely faster than any scripting system such as lua or python anyway (! No benchamrks were done, just an *educated guess* !).

## Further possible improvements
One recommendation for further safety would be to put all the plugins on one or multiple separate threads so that they do not have access to the stack of the host. After all, the plugins are also written in C and thus could endager the host as well if the plugin/script writers do not take great care. (Careless programming is never encouraged, but it can get especially destructive in C).

For reasons (mainly laziness) I have not done any of this, but if I were to implement a plugin/scripting system like this in a serious application I would without a doubt go for it.

TCC does minimal optimization on C code (just some expression substitutions and such) which most likely generally serves the purpose, especially considering that TCC is small and portable. If, however, a higher level of optimization is desired one may consider seeking out gcc, clang or msvc and using exclusively that for plugin/script compilation and having TCC only as a fallback.

Another idea would be to compile everything with TCC (remember, it's fast and thus desirable) and detect plugins/scripts in hot parts of the code and then recompile and hot-swap the optimized scripts/plugins in. This, however is a far more complicated system and would require realtime profiling by the host (or possibly by the scripts themselves?) to decide which plugins to recompile. The compiler detection system may complicate things too.
