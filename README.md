# Cplug
A project that shows the fact that a more or less complex plugin system with 100% C and native plugins can be made. No need for the overhead of an interpreted language.

This project make use of TCC (Tiny C Compiler) for compiling the plugins at runtime. This compiler was chosen due to its small size and blazingly fast compilation speed. It is also designed to be incorporated into other programs, which makes this choice even more of a no-brainer.
