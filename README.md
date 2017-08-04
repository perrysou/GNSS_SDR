
 	
# Getting Started

This DVD contains a GNSS Software Defined Radio (SDR) implemented in MATLAB code and GNSS signal records. In addition, some of the scripts for creating the figures in the text are also on included.

# Legal Information (disclaimer)

® 2006 Springer Science+Business Media, LLC This electronic component package is protected by federal copyright law and international treaty. If you wish to return this book and the electronic component package to Springer Science+Business Media, LLC, do not open the disc envelope or remove it from the book. Springer Science+Business Media, LLC, will not accept any returns if the package has been opened and/or separated from the book. The copyright holder retains title to and ownership of the package. U.S. copyright law prohibits you from making any copy of the entire electronic component package for any reason without the written permission of Springer Science+Business Media, LLC, except that you may download and copy the files from the electronic component package for your own research, teaching, and personal communications use. Commercial use without the written consent of Springer Science+Business Media, LLC, is strictly prohibited. Springer Science+Business Media, LLC, or its designee has the right to audit your computer and electronic components usage to determine whether any unauthorized copies of this package have been made.

Springer Science+Business Media, LLC, or the author(s) makes no warranty or representation, either express or implied, with respect to this electronic component package or book, including their quality, merchantability, or fitness for a particular purpose. In no event will Springer Science+Business Media, LLC, or the author(s) be liable for direct, indirect, special, incidental, or consequential damages arising out of the use or inability to use the electronic component package or book, even if Springer Science+Business Media, LLC, or the author(s) has been advised of the possibility of such damages.

# System requirements

The system requirements for using GNSS software defined radio are:
* MATLAB version 7.0.4(R14SP2) or later
* DVD drive
* A minimum of 256 megabytes (MB) of RAM (512 MB of RAM, or more, is strongly recommended)
* A minimum of 50 MB of hard-disk space for the GNSS software installation. 4.3 gigabytes (GB) might be required for the GNSS software and signal records from the DVD.

# Installation

To install the GNSS SDR, complete the following steps:
Copy folder "GNSS_SDR" to the hard-disk
(Optional) Copy folder "GNSS_signal_records" to the hard-disk.
Please use a file browser to browse the contents of the DVD.

# Running the GNSS SDR software

**Note**:	It is assumed that the user is familiar with MATLAB language from MATHWORKS.
To run the GNSS SDR, complete the following steps:

1. In Matlab open the "GNSS software defined radio" folder
2. Run the M-script init. Press 0 and then press Enter if you want to select a different data file (signal record) or if the default path is incorrect. If the default path to the data file is correct, press 1 at the MATLAB command prompt, then press Enter and then continue at step 6
3. Run the M-script setSettings. In the settings window click "Open data file" button. Select and open data file in the dialog
4. In the settings window click "Probe data" button. A plot window should be presented if a correct data file was selected
5. Run the M-script postProcessing
6. Now the signal processing will start. It may take a few hours, depending on the speed of the computer, to process the data record. At the end results will be plotted
7. Continue from step 3 to repeat the process with a different data file.
**Note**:	Always run init.m to setup GNSS SDR environment each time MATLAB is restarted. The GNSS SDR depends on the settings structure. It will not work if a correct settings structure is missing in the MATLAB workspace. It is restored by the init script or by the command settings=initSetting();. Also it can be loaded from a file (e.g. from tracking results).
**Note**:	The init.m loads default settings. Therefore save settings in a file or update initSettings.m to save your changes, before running init.m.

## More details on code part

The GNNS SDR is using structure settings system widely. This makes the software flexible and most of the software properties are controlled at one place. There are three ways to change settings. The default values are defined in function initSettings. The default settings are applied by the init script or by a button click at the settings GUI.

The second way to change settings is to use a dedicated GUI. The GUI is launched by the setSettings script. The GUI has three buttons at the bottom of the dialog window. Button "Default" loads default values defined in the function initSettings. "Apply" button saves settings from GUI in the variable settings (in MATLAB workspace). The third button "Load current" loads current contents of the variable settings from the MATLAB workspace. The apply button is switched off if none of the settings was changed since last load from the MATLAB workspace.

The third way to change settings is to change values in the settings structure using the MATLAB command prompt or variable editor. Examine the file initSettings.m for more details on the settings structure.

The software is made such that three main modules - acquisition, tracking, and positioning can be executed separately. The scenario depends on the debugged module.

Acquisition can be switched off (to save time) if the acquisition results already are present in MATLAB workspace (structure acqResults). The acquisition step is controlled by the field skipAcquisition in the settings (for field and allowed values description see comments in function initSettings).

The tracking part can be skipped too (in case the positioning module is debugged and there are no changes in tracking part). A correct settings structure and the tracking results must be present (structure trackResults). The tracking results and settings are automatically saved after each completion of tracking stage in the MATLAB data file trackingResults.mat. To run the positioning part without running tracking part complete the following steps:

1. Load tracking results and settings. Skip this step if tracking results are already in the MATLAB workspace
2. Run this command at the MATLAB command prompt: navSolutions = postNavigation(trackResults, settings);
3. The results are plotted by function plotNavigation: plotNavigation(navSolutions, settings);.

Examine files init.m, initSettings.m, and postProcessing.m for more details on settings and how to use different functions of the SDR and how they work.

# Resources

* The official homepage of the book
* The official homepage of GNSS USB front-end
* SiGe 4110 datasheet (the SiGe 4110 is an example of a GNSS front end ASIC)
 
