cd "`dirname \"$0\"`"
mkdir ../build &>/dev/null
g++ -c runtimeHooker.mm -o ../build/libStar.a

