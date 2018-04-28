val args = CommandLine.arguments();
CM.make "sources.cm"; 
Main.compile(hd args);
val _ = OS.Process.exit(OS.Process.success)
