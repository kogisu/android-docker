.PHONY: build_image run_image exec_image

build_image:
	docker build -t springjdk .

run_image: build_image
	docker run --rm -it -d --name springjdk -v "${PWD}":/usr/src/app -w /usr/src/app springjdk

exec_image:
	docker exec -it springjdk /bin/bash
