#! /bin/bash -ex

pushd `dirname $0`/.. > /dev/null
root=$(pwd -P)
popd > /dev/null

export GOPATH=$root/gopath
mkdir -p $GOPATH $GOPATH/bin
source $root/ci/vars.sh

go get -v github.com/venicegeo/pzsvc-exec/...
go get -v github.com/venicegeo/pzsvc-exec/pzsvc-taskworker/...

src=$GOPATH/bin/pzsvc-exec
mv $GOPATH/bin/pzsvc-exec $root/pzsvc-ossim.bin
mv $GOPATH/bin/pzsvc-taskworker $root/pzsvc-taskworker.bin

cd $root

tar cvzf $APP.$EXT \
    pzsvc-taskworker.bin \
    pzsvc-ossim.bin
tar tzf $APP.$EXT