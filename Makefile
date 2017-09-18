
PACKAGE_PRODUCT=secure-demo-puppet
PACKAGE_VERSION=0.1.0
ARCH="386 amd64 arm"

default: bintray prep build package

clean:
	rm -rf .build
	rm -f *.deb *.rpm

bintray:
	cat .bintray/rpm.json.template | sed "s:%%PACKAGE_NAME%%:$(PACKAGE_PRODUCT):g;s:%%PACKAGE_VERSION%%:$(PACKAGE_VERSION):g;" > .bintray/rpm.json
	cat .bintray/deb.json.template | sed "s:%%PACKAGE_NAME%%:$(PACKAGE_PRODUCT):g;s:%%PACKAGE_VERSION%%:$(PACKAGE_VERSION):g;" > .bintray/deb.json

prep:
	./prep.sh

build: prep
	./build.sh

package: prep
	PACKAGE_PRODUCT=$(PACKAGE_PRODUCT) PACKAGE_VERSION=$(PACKAGE_VERSION) PACKAGE_ARCH=$(PACKAGE_ARCH) ./package.sh

