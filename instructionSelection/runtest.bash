#!/bin/bash

tf=tsttmp.sml
echo "starting test"
rm -f res.txt
for i in {1..49}
do
  echo "---------- $i -----------------"
  echo "CM.make \"sources.cm\"; Main.compile(\"../testcases/extra/t$i.tig\");" > $tf
  echo "val _ = OS.Process.exit(OS.Process.success);" >> $tf 
  echo "-------- $i --------" >> res.txt
  sml $tf >> res.txt
  echo 
done

rm $tf
echo "test finished"
