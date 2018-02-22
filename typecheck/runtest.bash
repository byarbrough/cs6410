#!/bin/bash

echo "starting test"
rm -f res.txt
for i in {1..49}
do
  echo "---------- $i -----------------"
  echo "CM.make \"sources.cm\"; Main.run(\"../testcases/extra/t$i.tig\");" > test.sml
  echo "-------- $i --------" >> res.txt
  sml test.sml >> res.txt
  echo 
done

echo "CM.make \"sources.cm\"; Main.run(\"../testcases/queens.tig\");" > test.sml
echo "test finished"
