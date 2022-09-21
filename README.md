# Introduction
This is small program developed using [Processing](https://processing.org/) to visualize the results of analysis done with Discrete Element Model software @itasca [3DEC](https://www.itascacg.com/software/3DEC). The viewer program was created using Processing (version 1.5.1) written in Java for viewing the model and time history analysis results in 3D at every time step and allows panning, zooming and rotating of the time history animation in realtime. This means models do not have to be rerun in 3DEC if you want a different view. There are also some export options for images and videos (somewhat experimental). 

The current work is woefully outdated and has been shared as a proof of concept rather than a fully functional program.

# Requirements
- [Processing 1.5.1](https://github.com/processing/processing/releases/download/processing-1.5.1/processing-1.5.1-windows.zip) (to build from source)
- Itasca 3DEC 4.2 (haven't tested model and run files with newer versions of 3DEC)

# Usage & Example
This program was developed as part of a thesis project titled, [Seismic Assessment of the Roman Temple in Évora, Portugal](https://msc-sahc.org/wp-content/uploads/2020/07/2012_ANayeri.pdf) (2012). 

Once you run the program, you need to use the collapsible menus on the upper right to import the 3DEC model. To see how the program works, a [sample model](https://raw.githubusercontent.com/anayeri/Visual3DEC/main/example/model/m03_geometry.dat) has been provided for reference before trying new models. Once the model is loaded, you can then open the time-history data saved from 3DEC via FISH functions. When you play the results, you can actually pan, zoom and rotate. A screencast of the basic operations is available on [YouTube](https://youtu.be/L4JJ2jVPOj8).

Since the thesis used incremental dynamic analysis to look a variety of ground motion, in two directions, and at various intensities, there are 86 time-history runs which [are available in this folder](https://github.com/anayeri/Visual3DEC/tree/main/example/data). You will need to download and load the .out files individually to see the animated time-history data.

**Important Notes**
1. the program can only load poly prism elements (not bricks). But adding new elements shouldn't be too hard.
2. the main assumption is that the blocks are rigid so that it is enough to track displacement of 3 points for each block at each analysis step (to keep output files small). The program uses singular value decomposition to recalculate the displacement/position of the rest of nodes for each block. 

# Binaries
Binaries for windows, linux and Mac OS are available as [a release](https://github.com/anayeri/Visual3DEC/releases). Only the Windows version has been fully tested so you may need to build things from the source.

# Building from Source
The source code for the program is available through this repository. You will need [Processing 1.5.1 IDE](https://github.com/processing/processing/releases/download/processing-1.5.1/processing-1.5.1-windows.zip) to edit and run the source code. Processing packages programs as "sketchbooks", so you will need to unzip the source code for the program and dependencies to the default sketchbook location.
