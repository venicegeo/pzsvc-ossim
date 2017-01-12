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
mv $GOPATH/bin/pzsvc-exec $GOPATH/bin/pzsvc-ossim

cd $root

tar cvzf $APP.$EXT \
    $GOPATH/bin/pzsvc-taskworker \
    $GOPATH/bin/pzsvc-ossim
tar tzf $APP.$EXT