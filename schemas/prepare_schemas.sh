#!/bin/bash

# This script will convert properly to XSD the 4 needed schemas (listed in ../resources.qrc).
# We need trang utility to convert from RNG. Download it from : https://cwiki.apache.org/confluence/display/lenya/trang

# where trang is built by maven:
TRANG_JAR="~/bin/jing-trang/build/trang.jar"

# Download the PNML grammar
wget https://www.pnml.org/version-2009/grammar.zip
unzip grammar.zip 

# prepare rng files for conversion
sed -i 's/http:\/\/www.pnml.org\/version-2009\/grammar\/conventions\.rng/conventions\.rng/g' grammar/ptnet.pntd
sed -i 's/http:\/\/www.pnml.org\/version-2009\/grammar\/pnmlcoremodel\.rng/pnmlcoremodel\.rng/g' grammar/ptnet.pntd
sed -i 's/http:\/\/www.pnml.org\/version-2009\/grammar\/anyElement\.rng/anyElement\.rng/g' grammar/pnmlcoremodel.rng

# Convert all at once:
java -jar ~/bin/jing-trang/build/trang.jar -I rng -O xsd grammar/ptnet.pntd grammar/ptnet.xsd

# Update anyElement:
cat anyElement > grammar/anyElement.rng.xsd 

# move files:
cp -fv grammar/*xsd . 

# clean
rm -Rf grammar grammar.zip grammar* __MACOSX/

