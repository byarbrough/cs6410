#!/bin/bash

echo "starting test"
rm -f res.txt
for i in {1..49}
do
  echo "CM.make \"sources.cm\"; Parse.parse(\"../testcases/extra/t$i.tig\");" > test.sml
  echo "-------- $i --------" >> res.txt
  sml test.sml >> res.txt
  echo $i
done

echo "test finished"
