starp(){
IFS="
"
touch argf.sch
cat > newfile.c << STARHEADER
#if !defined(_DYLD_INTERPOSING_H_)
#define _DYLD_INTERPOSING_H_
#define DYLD_INTERPOSE(_replacment,_replacee) \
   __attribute__((used)) static struct{ const void* replacment; const void* replacee; } _interpose_##_replacee \
            __attribute__ ((section ("__DATA,__interpose"))) = { (const void*)(unsigned long)&_replacment, (const void*)(unsigned long)&_replacee };
#endif
STARHEADER
IR=$RANDOM;
sed 's/%ctor/__attribute__((constructor)) int _ctor_'$RANDOM'()/g' < $@ > tmp
cat tmp > lookr.c
rm -rf tmp
for i in $(cat lookr.c)
do
if [[ "$(echo $i | grep -E '^%hook')" == "" ]]; then
echo "$i" >> newfile.c
continue; fi
IFS=" "
echo "$i" > tmp
read hook type fname args < tmp
rm -rf tmp
IVR=$RANDOM
echo "static $type ${fname}_${IVR} $args" >> newfile.c
echo "${fname}_${IVR}"';'"$fname" >> argf.sch
done
IFS="
"
for i in $(cat argf.sch)
do
IFS=';'
echo "$i" > tmp
read ivf fname < tmp
rm -rf tmp 
echo 'DYLD_INTERPOSE('"$ivf"', '"$fname"');' >> newfile.c
done
rm -rf lookr.c
rm -rf argf.sch
cat newfile.c
rm -rf newfile.c
}
echo
echo "=========================================="
echo
echo "starproject - objective c hooking platform"
echo "and C/C++ too..."
echo "usage: $0 <pathtosourcecode> <compilerflags>"
echo "compiler: g++"
echo
echo "=========================================="
echo
echo "Compiling ObjC-Star"
cd "`dirname \"$0\"`"
./ObjCHook/compile.sh
echo "PreProcessing $1"
starp "$1" > .___tweak___.mm
echo "Compiling Target"
TARGET="`basename \"$1\"`"
shift
g++ .___tweak___.mm ./build/libStar.a -o ./build/"${TARGET%.*}".dylib -lobjc -framework Foundation -dynamiclib $@
rm -rf .___tweak___.mm star.o
