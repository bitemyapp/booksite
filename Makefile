all: deploy

CMD=./dist/build/site/site

cabal-build:
	cabal clean
	cabal build

clean:
	${CMD} clean

build:
	${CMD} build

deploy: clean build
	${CMD} deploy

watch: clean
	${CMD} watch

getsample:
	cp ../fpbook/releases/sample_current.pdf ./images/sample.pdf
