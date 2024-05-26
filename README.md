# Windows Voice Commands Batch Script

Clunky but private and configurable system for voice commands on Windows using batch scripts. It is not very fast but I find it useful enough for running commands while not sitting at PC or to not interrupt current tasks. 

To overcome bad piping support in Windows, this script makes voice capture and voice recognition dependencies communicate by writing files. 

### Dependencies
- ffmpeg for capturing input. May be replaced by altering line 8 of `wvc_run.bat`. The replacement must output `wvc.m4a` file in the same directory.
- OpenAI Whisper for voice recognition run locally. May be replaced by altering line 9 of `wvc_run.bat`. The replacement must output the text without punctuation symbols into `wvc.txt` file in the same directory. One easy way to install Whisper is with Python 3 and pip `pip install -U openai-whisper`.
- It is recommended to use some advanced solution for keyboard shortcuts such as Powertoys to create a keyboard shortcut that will start the `wvc_run.bat`.

### Configuration
Basic parameters can be configured inside `wvc_config.bat`.

You will definitely need to replace the `wvc_recording_device` with your audio input device, find its name in the "Manage Audio Devices" settings. For most cases replacing the part inside brackets with the device name will be enough.

The `small` Whisper model is small (~500MB) and good enough for English language use. If you really need more precision and support for different languages replace the `wvc_whisper_model` setting with the model name and `wvc_whisper_language` with a language supported by the chosen model.

On Windows you may run into SSL error when fetching the model for the first time. You can spend hours fixing that or just manually download the model and then set `wvc_options` to `--model_dir C:\path\to\model` where the path needs to point to directory where model is downloaded and not to the file itself. "Small" model can be downloaded directly from [direct download](https://openaipublic.azureedge.net/main/whisper/models/9ecf779972d90ba49c06d968637d720dd632c55bbf19d441fb42bf17a411e794/small.pt)

Other configuration options should be self-explanatory.

### Built-in Commands
You are intended to create your own commands, but there are some example built-in commands, currently:
- "Google {topic}" will open Chrome and google for a topic.
- "Run {program name}" edit the `wvc_commands/run.bat` to add running logic for programs you need.

### Custom Commands
Built-in commands are really just examples, you are encouraged to create your own by adding a batch script into `wvc_commands` folder with file name matching the command, i.e. `find.bat`. Only one word is supported for file matching, but you can add logic into script to match more words, see `run.bat` for example.

`%wvc_subject%` holds all the words after the command, it is up to you to parse and use it.

### Usage
Run the `wvc_run.bat` script either manually or with keyboard shortcut. Mind that you must run it as a user to have all the paths in environment available to that user.

Now comes the clunky part. You must wait about half a second for ffmpeg to display that it is receiving input from microphone, and then you have 5 seconds (depending on configuration in `wvc_config.bat`) to speak your command, after which it is sent to voice recognition. If you are running a model for the first time, Whisper will have to download it first. Otherwise, it will take couple more seconds (more or less, depending on your hardware) for command to be processed into text and run.

If running into issues or are working on a new command, it is recommended to put `pause` directive at the end of `wvc_run.bat` file to study the output.

